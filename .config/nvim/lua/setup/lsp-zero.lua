local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.set_preferences({
    diagnostics = {
        disable = {"lowercase-global","trailing-space"}
    }
})
-- TODO Check what this does
lsp.nvim_workspace()
lsp.setup()
