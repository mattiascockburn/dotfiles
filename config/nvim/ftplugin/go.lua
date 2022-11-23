-- load DAP when it's available
local status_ok, dap = pcall(require, "dap-go")
if not status_ok then
  return
end
dap.setup()


