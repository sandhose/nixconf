{ ... }:

{
  # Explicitely disable pulseaudio, because we are using pipewire
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security = {
    # Pipewire uses this
    rtkit.enable = true;

    pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "soft";
        value = "64";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "hard";
        value = "128";
      }
    ];
  };

  systemd.user.services.pipewire.serviceConfig.LimitMEMLOCK = "131072";
}
