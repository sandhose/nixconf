{ ... }:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";

    profiles.default = {
      id = 0;
      settings = {
        "gfx.webrender.all" = true;
      };
    };
  };

  systemd.user.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };
}
