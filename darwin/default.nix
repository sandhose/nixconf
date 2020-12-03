{ pkgs, ... }:

{
  environment = {
    systemPackages =
      with pkgs; [
        postgresql_12
        pinentry_mac
        reattach-to-user-namespace
        notmuch
        my.neomutt
        msmtp
        wireshark
        xquartz
      ];

    variables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
      LANG = "en_US.UTF-8";
    };
  };

  nix = {
    trustedUsers = [ "@admin" ];

    useSandbox = false;
    package = pkgs.nixFlakes;

    maxJobs = 3;
    buildCores = 3;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system = {
    defaults = {
      trackpad = {
        ActuationStrength = 1; # force click
        Clicking = true; # tap to click

        # Firm click
        FirstClickThreshold = 2;
        SecondClickThreshold = 2;

        # Two-finger right click
        TrackpadRightClick = true;
      };

      dock = {
        autohide = true;
        tilesize = 48;
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
      };
    };

    stateVersion = 4;
  };

  users.users = {
    sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
      home = "/Users/sandhose";
    };
  };
}
