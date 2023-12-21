local util = require('lspconfig.util')
return {
  settings = {
    filetypes = { 'helm' },
    root_dir = function(fname)
      return util.root_pattern('Chart.yaml')(fname)
    end
  },
}
