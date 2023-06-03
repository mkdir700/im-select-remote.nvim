local M = {}
M.config = {
  osc = {
    secret = "",
  },
  socket = {
    port = 23333,
  },
}

-- setup is the public method to setup your plugin
--
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

--- write writes the OSC 1337 escape sequence to the terminal
-- @tparam osc1337 string the OSC 1337 escape sequence
-- @treturn bool whether the write was successful
local function write(osc1337)
  local success = false
  -- if vim.fn.filwritable("/dev/fd/2") == 1 then
  -- success = vim.fn.writefile({ osc1337 }, "/dev/fd/2", "b") == 0
  -- if vim.fn.has("nvim") then
  -- success = vim.fn.chansend(vim.api.nvim_get_var("stderr"), osc1337) > 0
  -- else
  vim.cmd("silent! !echo " .. vim.fn.shellescape(osc1337))
  vim.cmd("redraw!")
  success = true
  -- end
  return success
end

M.IMSelectByOSC = function()
  write("\033]1337;Custom=id=" .. M.config.osc.secret .. ":im-select\a")
end

M.IMSelectBySocket = function()
  local current_dir = vim.fn.expand("%:p:h")
  local cmd = "python " .. current_dir .. "/im_client.py"
  os.execute(cmd)
end

return M
