vim.api.nvim_create_user_command("IMSelectByOSC", require("im-select-remote").IMSelectByOSC, {})
vim.api.nvim_create_user_command("IMSelectBySocket", require("im-select-remote").IMSelectBySocket, {})
