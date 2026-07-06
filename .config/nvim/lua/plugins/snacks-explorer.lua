-- snacks.explorer 매핑 override
--
-- 배경:
--   LazyVim 기본 <leader>fe = `Snacks.explorer({ cwd = LazyVim.root() })`.
--   이 호출은 picker 를 새로 열기만 하고, 현재 버퍼 파일을 트리에서
--   reveal 하는 건 내부 on_find (git_status 콜백) 타이밍에 의존한다.
--   snacks 의 explorer 재작성 이후 이 타이밍이 깨지는 경우가 있어,
--   "사이드바는 뜨는데 현재 파일이 트리에 펼쳐지지 않는" 증상이 발생.
--
--   해결: Snacks.explorer.reveal() 을 명시적으로 호출.
--   이 API 는 ① parent walk → ② Tree:open(file) → ③ target=file 로
--   커서까지 이동시켜 주는 dedicated reveal 함수.

return {
  "folke/snacks.nvim",
  -- picker (explorer/fuzzy finder 공용) 에서 PageDown/PageUp 매핑.
  -- snacks 는 기본적으로 <PageDown>/<PageUp> 을 매핑하지 않아서
  -- nvim 기본 <C-f>/<C-b> fallthrough 가 picker 의 가상 커서와 충돌해
  -- "위로 올라가는" 것처럼 보이는 증상이 발생함.
  opts = {
    picker = {
      -- explorer / files picker 에서 hidden 파일 (.pi, .env, .git* 등) 표시.
      -- snacks 기본값은 hidden=false. ignored 는 .gitignore 매칭 파일.
      sources = {
        explorer = {
          hidden = true,
          ignored = false, -- gitignore 매칭 파일은 기본 숨김 (H/I 로 토글 가능)
        },
        files = {
          hidden = true,
        },
      },
      win = {
        input = {
          keys = {
            ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<PageDown>"] = "list_scroll_down",
            ["<PageUp>"] = "list_scroll_up",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer.reveal()
      end,
      desc = "Explorer (reveal current file)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer (cwd)",
    },
    -- <leader>e / <leader>E 도 같은 동작으로 통일
    { "<leader>e", "<leader>fe", desc = "Explorer (reveal current file)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer (cwd)", remap = true },
  },
}
