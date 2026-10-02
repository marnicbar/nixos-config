{ pkgs, pkgs-unstable, ... }:

let
  version = "0.1.25";

  src = pkgs.fetchFromGitHub {
    owner = "neka-nat";
    repo = "freecad-mcp";
    rev = "v${version}";
    hash = "sha256-E6oTCpLMI/WBAmWwIWKu8tmWJAFPKZ55R6/zvd+8Pzo=";
  };

  # MCP server (stdio). Built from unstable because it requires mcp >= 1.28.1,
  # which the stable channel doesn't have yet.
  freecad-mcp = pkgs-unstable.python3Packages.buildPythonApplication {
    pname = "freecad-mcp";
    inherit version src;
    pyproject = true;

    build-system = with pkgs-unstable.python3Packages; [ hatchling ];

    dependencies = with pkgs-unstable.python3Packages; [
      mcp
      validators
    ];

    pythonImportsCheck = [ "freecad_mcp" ];
  };
in
{
  # FreeCAD addon that runs the XML-RPC server the MCP server talks to. It must
  # stay at the same version as the MCP server above.
  home.file.".local/share/FreeCAD/v1-1/Mod/FreeCADMCP".source = "${src}/addon/FreeCADMCP";

  programs.mcp.servers.freecad = {
    command = "${freecad-mcp}/bin/freecad-mcp";
    # Used by the execute_code_headless tool.
    args = [
      "--freecadcmd"
      "${pkgs.freecad-wayland}/bin/freecadcmd"
    ];
  };
}
