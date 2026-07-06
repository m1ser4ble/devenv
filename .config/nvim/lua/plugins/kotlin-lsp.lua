-- Kotlin LSP routing:
--   * Gradle/Maven/workspace.json projects -> JetBrains kotlin-lsp
--   * CCK Bazel trees -> local cck-kotlin-lsp

local jetbrains_kotlin_lsp = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/intellij-server")
local cck_kotlin_lsp = vim.fn.expand("$HOME/.local/bin/kotlin-lsp")

local kotlin_build_markers = {
  "settings.gradle",
  "settings.gradle.kts",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "workspace.json",
}

local bazel_markers = {
  "MODULE.bazel",
  "WORKSPACE",
  "WORKSPACE.bazel",
}

local function norm(path)
  return path and vim.fs.normalize(path) or nil
end

local function root(bufnr, markers)
  return norm(vim.fs.root(bufnr, markers))
end

local function is_cck_root(path)
  return path and vim.uv.fs_stat(vim.fs.joinpath(path, "tools", "cck-kotlin-lsp", "go.mod")) ~= nil
end

local function build_root(bufnr, on_dir)
  local build = root(bufnr, kotlin_build_markers)
  local bazel = root(bufnr, bazel_markers)
  if is_cck_root(bazel) then
    return
  end
  if build and (not bazel or #build >= #bazel) then
    on_dir(build)
  end
end

local function bazel_root(bufnr, on_dir)
  local build = root(bufnr, kotlin_build_markers)
  local bazel = root(bufnr, bazel_markers)
  if bazel and (is_cck_root(bazel) or not build or #bazel > #build) then
    on_dir(bazel)
  end
end

local function jetbrains_rpc(dispatchers, config)
  local root_dir = norm(config.root_dir or vim.uv.cwd())
  local bin = vim.fn.executable(jetbrains_kotlin_lsp) == 1 and jetbrains_kotlin_lsp or "intellij-server"
  -- ponytail: one cache/index DB per project root; split per client only if same-root parallel LSPs lock up.
  local system_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "kotlin-lsp", vim.fn.sha256(root_dir))
  return vim.lsp.rpc.start({ bin, "--stdio", "--system-path", system_path }, dispatchers, {
    cwd = root_dir,
    env = { PATH = "/home/linuxbrew/.linuxbrew/bin:" .. (vim.env.PATH or "") },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = { enabled = false },

        kotlin_lsp = {
          cmd = jetbrains_rpc,
          filetypes = { "kotlin" },
          root_dir = build_root,
          workspace_required = true,
        },

        cck_kotlin_lsp = {
          cmd = { cck_kotlin_lsp },
          filetypes = { "kotlin" },
          root_dir = bazel_root,
          mason = false,
          workspace_required = true,
        },
      },
    },
  },
}
