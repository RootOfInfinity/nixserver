# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./stylixconfig.nix
  ];

  # -- NIXOS SETTINGS -- #
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  nix.settings.auto-optimise-store = true;

  # -- HARDWARE SETTINGS -- #
  hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  services.flatpak.enable = true;

  # -- DIRENV SETTINGS -- #
  programs.direnv.enable = true;

  # -- STEAM SETTINGS -- #
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.steam.package = pkgs-unstable.steam;
  environment.variables."STEAM_EXTRA_COMPAT_TOOLS_PATHS" =
    "/home/rootofinfinity/.steam/root/compatibilitytools.d";
  # If ya wanna use mangohud, gamescope, or gamemode, put it in the
  # launch options like `mangohud %command%`

  # -- I2PD SETTINGS -- #
  services.i2pd = {
    enable = true;
    address = "127.0.0.1";
    ssu2.enable = true;
    proto.http = {
      enable = true;
      port = 7072;
    };
    proto.httpProxy.enable = true;
    proto.sam.enable = true;
    proto.i2cp = {
      enable = true;
      address = "127.0.0.1";
      port = 7654;
    };

  };

  # -- FLASHDRIVE SETTINGS -- #
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;

  # -- VIRTUAL MACHINE MANAGER -- #
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "rootofinfinity" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = true;
  # virtualisation.docker.enable = true;
  # users.groups.docker.members = [ "rootofinfinity" ];
  virtualisation.podman.enable = true;

  # -- BOOT LOADER SETTINGS -- #
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false; # if activated, someone could get root access.
  boot.loader.efi.canTouchEfiVariables = true;

  # -- NETWORKING SETTINGS -- #
  # networking.hostName = "Declared in user.nix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  # networking.nameservers = [ "8.8.8.8" ];
  # networking.defaultGateway6 = {
  #   address = "fe80::1";
  #   interface = "enp2s0";
  # };
  networking.enableIPv6 = true;
  # networking.extraHosts = ''
  #   54.236.113.205 registry-1.docker.io
  #   54.198.86.24 registry-1.docker.io
  #   54.227.20.253 registry-1.docker.io
  # '';
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # -- I DONT KNOW LOL -- #
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # -- IF I EVER SWITCH TO X11 -- #
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services = {
  #   displayManager.defaultSession = "xfce";
  #   xserver = {
  #     enable = true;
  #     desktopManager = {
  #       xfce.enable = true;
  #     };
  #   };
  # };

  # -- SOUND SETTINGS -- #
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   jack.enable = true;
  # };

  # -- XDG PORTAL -- #
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # -- PRINTING -- #
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # -- KEPT JUST CAUSE -- #
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixadmin = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "dialout"
      "i2pd"
      # "docker"
    ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  fonts.packages = with pkgs-unstable; [
    nerd-fonts.bigblue-terminal
    nerd-fonts.profont
  ];

  # -- DONT REALLY KNOW FR -- #
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # -- SERVICES -- #
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # -- RANDOM STUFF - #
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
