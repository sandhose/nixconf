{ ... }:

{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      records = true;
      auto_sync = true;
      sync_frequency = "5m";
    };
    daemon.enable = true;
  };
}
