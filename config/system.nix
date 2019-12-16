{
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
}
