{ ... }:

{
  boot = {
    kernelParams = [ "amd_iommu=on" "acpi_enforce_resources=lax" ];
    kernelModules = [ "kvm-amd" "i2c-dev" "i2c-piix4" ];
  };

  hardware.cpu.amd.updateMicrocode = true;
}
