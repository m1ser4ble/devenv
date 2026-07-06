return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	ft = { "markdown", "Avante" },
	opts = {
		-- 커서 올라간 줄은 raw 텍스트로 표시 (편집 편의)
		render_modes = { "n", "c", "t" },
		anti_conceal = { enabled = true },
		-- 헤딩 스타일
		heading = {
			enabled = true,
			sign = true,
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
		},
		-- 코드블록
		code = {
			enabled = true,
			sign = true,
			style = "full",
			width = "block",
			left_pad = 0,
			right_pad = 1,
		},
		-- 체크박스
		checkbox = {
			enabled = true,
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰱒 ", scope_highlight = "@markup.strikethrough" },
		},
		-- 테이블
		pipe_table = {
			enabled = true,
			style = "full",
		},
		-- 불릿
		bullet = {
			enabled = true,
			icons = { "●", "○", "◆", "◇" },
		},
	},
	keys = {
		{ "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
	},
}
