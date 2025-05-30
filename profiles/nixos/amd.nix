{ pkgs, ... }:

{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "amd_iommu=on"
      "acpi_enforce_resources=lax"
    ];
    kernelModules = [
      "kvm-amd"
      "i2c-dev"
      "i2c-piix4"
    ];
  };

  hardware.cpu.amd.updateMicrocode = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];

  hardware.graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

  # Force RADV
  #environment.variables.VK_ICD_FILENAMES =
  #  "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  environment.variables.AMD_VULKAN_ICD = "RADV";
}
