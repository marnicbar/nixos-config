{ inputs, pkgs, pkgs-unstable, ... }:

{
  imports = [ ./freecad-mcp.nix ];

  # Tool-agnostic MCP server registry (programs.mcp.servers), populated by the
  # imported modules. Each AI client opts in via enableMcpIntegration.
  programs.mcp.enable = true;

  programs.claude-code = {
    enable = true;
    package = pkgs-unstable.claude-code;
    enableMcpIntegration = true;
  };

  # FHS variant so MCP servers launched via npx/uvx/docker work.
  home.packages = [
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-fhs
  ];

  home.file.".claude/CLAUDE.md".source = ./CLAUDE.md;
}
