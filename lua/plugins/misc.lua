return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
    },
    {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end
	}
}
