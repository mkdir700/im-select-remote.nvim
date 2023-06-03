local M = {}
M.config = {
  secret = "",
}

-- setup is the public method to setup your plugin
--
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

--- echo prints a message to the user
-- @tparam msg string the message to print
local function echo(msg)
  vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
end

--

M.IMSelect = function()
  echo("\033]1337;Custom=id=" .. M.config.secret .. ":im-select\a")
end

return M
