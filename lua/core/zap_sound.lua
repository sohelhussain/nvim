-- zap_sound.lua
-- Electric zap sounds on typing and cursor jumps. Sound only: the lightning
-- visuals come from the Ghostty shader. macOS (afplay), Neovim 0.10+.
--
-- Install: copy to ~/.config/nvim/lua/zap_sound.lua, then in init.lua add:
--   require("zap_sound").setup()
-- The sound files are generated on first run into stdpath("cache")/zap_sound.

local M = {}
local uv = vim.uv or vim.loop

local defaults = {
  volume = 0.5, -- 0.0 to 1.0 (afplay -v)
  keys = true, -- soft crackle on every typed character
  deletes = true, -- lower "pop" when text is deleted (backspace, x, dd, ...)
  jumps = true, -- bigger zap when the cursor jumps
  jump_min = 3, -- minimum jump (lines or columns) that triggers the zap
  throttle_ms = 45, -- minimum gap between sounds
}

local cfg = vim.deepcopy(defaults)
local enabled = true
local files = {}
local last = 0
local last_pos
local sizes = {}

local SR = 44100

local function le16(n)
  return string.char(n % 256, math.floor(n / 256) % 256)
end

local function le32(n)
  return string.char(n % 256, math.floor(n / 256) % 256, math.floor(n / 65536) % 256, math.floor(n / 16777216) % 256)
end

-- Frequency sweep + noise burst + random crackle clicks, exponential decay.
local function synth(dur, f0, f1, noise, decay, amp, seed)
  math.randomseed(seed)
  local n = math.floor(SR * dur)
  local out = {}
  local phase = 0
  for i = 0, n - 1 do
    local t = i / SR
    local p = i / n
    local freq = f0 + (f1 - f0) * p
    phase = phase + 2 * math.pi * freq / SR
    local env = math.exp(-t * decay)
    local s = 0.45 * math.sin(phase) * env
    s = s + noise * (math.random() * 2 - 1) * math.exp(-t * decay * 1.6)
    if math.random() < 0.004 then
      s = s + (math.random() * 2 - 1) * 0.9 * env -- crackle click
    end
    s = math.max(-1, math.min(1, s * amp))
    local v = math.floor(s * 32767)
    if v < 0 then
      v = v + 65536
    end
    out[#out + 1] = le16(v)
  end
  local data = table.concat(out)
  return table.concat {
    'RIFF',
    le32(36 + #data),
    'WAVE',
    'fmt ',
    le32(16),
    le16(1),
    le16(1),
    le32(SR),
    le32(SR * 2),
    le16(2),
    le16(16),
    'data',
    le32(#data),
    data,
  }
end

local function write_file(path, bytes)
  local f = io.open(path, 'wb')
  if not f then
    return false
  end
  f:write(bytes)
  f:close()
  return true
end

local function build_sounds()
  local dir = vim.fn.stdpath 'cache' .. '/zap_sound'
  vim.fn.mkdir(dir, 'p')
  local specs = {
    key1 = { 0.07, 2600, 900, 0.55, 48, 0.9, 1 },
    key2 = { 0.07, 3200, 1200, 0.55, 48, 0.9, 2 },
    key3 = { 0.08, 2100, 800, 0.6, 42, 0.9, 3 },
    del1 = { 0.09, 1000, 220, 0.45, 34, 0.9, 21 },
    del2 = { 0.10, 800, 180, 0.5, 30, 0.9, 22 },
    zap1 = { 0.24, 3400, 350, 0.8, 13, 1.0, 11 },
    zap2 = { 0.28, 2800, 250, 0.9, 11, 1.0, 12 },
  }
  for name, s in pairs(specs) do
    local path = dir .. '/' .. name .. '.wav'
    if vim.fn.filereadable(path) == 0 then
      write_file(path, synth((unpack or table.unpack)(s)))
    end
    files[name] = path
  end
end

local function play(name)
  local now = uv.now()
  if not enabled or now - last < cfg.throttle_ms then
    return
  end
  last = now
  local path = files[name]
  if path and vim.fn.executable 'afplay' == 1 then
    vim.system({ 'afplay', '-v', tostring(cfg.volume), path }, { detach = true })
  end
end

local function pick(prefix, count)
  return prefix .. math.random(count)
end

local function buf_size()
  return vim.fn.line2byte(vim.fn.line '$' + 1)
end

local function check_delete()
  local b = vim.api.nvim_get_current_buf()
  local size = buf_size()
  local prev = sizes[b]
  sizes[b] = size
  if prev and size < prev then
    play(pick('del', 2))
  end
end

function M.setup(opts)
  cfg = vim.tbl_deep_extend('force', defaults, opts or {})
  build_sounds()

  local group = vim.api.nvim_create_augroup('ZapSound', { clear = true })

  if cfg.keys then
    vim.api.nvim_create_autocmd('InsertCharPre', {
      group = group,
      callback = function()
        play(pick('key', 3))
      end,
    })
  end

  if cfg.deletes then
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufReadPost' }, {
      group = group,
      callback = function()
        sizes[vim.api.nvim_get_current_buf()] = buf_size()
      end,
    })
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
      group = group,
      callback = check_delete,
    })
  end

  if cfg.jumps then
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = group,
      callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        if last_pos then
          local d = math.max(math.abs(pos[1] - last_pos[1]), math.abs(pos[2] - last_pos[2]))
          if d >= cfg.jump_min then
            play(pick('zap', 2))
          end
        end
        last_pos = pos
      end,
    })
  end

  vim.api.nvim_create_user_command('ZapSoundToggle', function()
    enabled = not enabled
    vim.notify('Zap sound ' .. (enabled and 'on' or 'off'))
  end, {})
end

return M
