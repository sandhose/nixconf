{ ... }:

{
  programs.firefox = {
    enable = true;

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
