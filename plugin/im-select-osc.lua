vim.api.nvim_create_user_command("IMSelectByOSC", require("im-select-osc").IMSelectByOSC, {})
vim.api.nvim_create_user_command("IMSelectBySocket", require("im-select-osc").IMSelectBySocket, {})
