local util = require('lspconfig.util')
return {
  settings = {
    filetypes = { 'yaml' },
    root_dir = function(fname)
      return util.root_pattern('.azure')(fname)
    end
  },
}
