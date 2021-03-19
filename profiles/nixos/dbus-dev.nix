{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      sandhose-dbus = super.writeTextFile {
        name = "sandhose-dbus";
        destination = "/share/dbus-1/system.d/fr.sandhose.conf";
        text = ''
          <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
            "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
          <busconfig>
            <policy user="sandhose">
              <allow own_prefix="fr.sandhose"/>
              <allow send_destination="fr.sandhose"/>
            </policy>

            <policy context="default">
              <allow send_destination="fr.sandhose.Player"/>
            </policy>
          </busconfig>
        '';
      };
    })
  ];

  services.dbus.packages = [ pkgs.sandhose-dbus ];
}
