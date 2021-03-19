{ ... }:

{
  boot = {
    kernelParams = [ "amd_iommu=on" ];
    kernelModules = [ "kvm-amd" ];
  };

  hardware.cpu.amd.updateMicrocode = true;
}
