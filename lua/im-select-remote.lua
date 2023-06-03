local M = {}
M.config = {
  osc = {
    secret = "",
  },
  socket = {
    port = 23333,
  },
}

--- write writes the OSC 1337 escape sequence to the terminal
-- @tparam osc1337 string the OSC 1337 escape sequence
-- @treturn bool whether the write was successful
local function write(osc1337)
  local success = false
  if vim.fn.has("nvim") then
    success = vim.fn.chansend(vim.api.nvim_get_var("stderr"), osc1337) > 0
  else
    vim.cmd("silent! !echo " .. vim.fn.shellescape(osc1337))
    vim.cmd("redraw!")
    success = true
  end
  return success
end

--- check_auto_enable_conditions checks whether the auto enable conditions are met
-- @treturn bool whether the auto enable conditions are met
local function check_auto_enable_socket()
  if vim.fn.system("cat ~/.ssh/config | grep 'Port " .. M.config.socket.port .. "'") ~= "" then
    return true
  end
  return false
end

M.IMSelectByOSC = function()
  write("\033]1337;Custom=id=" .. M.config.osc.secret .. ":im-select\a")
end

M.IMSelectBySocket = function()
  local current_dir = vim.fn.expand("%:p:h")
  local cmd = "python " .. current_dir .. "/im_client.py"
  os.execute(cmd)
end

M.IMSelectOSCEnable = function()
  vim.cmd([[
      augroup im_select_remote
        autocmd!
        autocmd BufEnter * lua require("im-select-remote").IMSelectByOSC()
        autocmd BufLeave * lua require("im-select-remote").IMSelectByOSC()
        autocmd InsertLeave * lua require("im-select-remote").IMSelectByOSC()
      augroup END
    ]])
end

M.IMSelectSocketEnable = function()
  vim.cmd([[
      augroup im_select_remote
        autocmd!
        autocmd BufEnter * lua require("im-select-remote").IMSelectBySocket()
        autocmd BufLeave * lua require("im-select-remote").IMSelectBySocket()
        autocmd InsertLeave * lua require("im-select-remote").IMSelectBySocket()
      augroup END
    ]])
end

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  if check_auto_enable_socket() then
    M.IMSelectSocketEnable()
  end
end

return M
