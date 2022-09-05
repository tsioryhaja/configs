local status, dap = pcall(require, 'dap')
if (not status) then return end

dap.adapters.python = {
	type = 'executable';
	command = 'python';
	args = {'-m', 'debugpy.adapter'};
}

dap.configurations.python = {
	{
		type = 'python';
		name = 'Debug Python';
		request = 'launch';

		program = '${file}';
		pythonPath = function()
			return 'python'
		end
	}
}
