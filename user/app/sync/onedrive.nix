{ ... }:
{
  # OneDrive configuration
  home.file.".config/onedrive/sync_list".text = ''
    /Dokumente/HKA/
    /Dokumente/Bewerbungen/
  '';

  home.file.".config/onedrive/config".text = ''
    disable_websocket_support = "true"
    skip_symlinks = "true"
    skip_dir = ".direnv|*/.direnv|.venv|*/.venv|node_modules|*/node_modules|__pycache__|*/__pycache__"
  '';
}
