# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  #Enable ZRam because fuck swap partitions lol
  zramSwap.enable = true;
  zramSwap.memoryPercent = 200;
  boot.kernel.sysctl."vm.page-cluster" = 0;
  #NixOS Options Below
  #Enable Hyprland and related
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;
  #SwayFX Lol
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };
  #Gaming
  programs.steam.enable = true;
  #Git Stuff
  programs.git.enable = true;
  programs.lazygit.enable = true;
  #Enable Flatpak like the heathen I am
  services.flatpak.enable = true;
  #Uncategorized crap that I will deal with later
  programs.file-roller.enable = true;
  programs.adb.enable = true;
  programs.command-not-found.enable = true;
  hardware.opengl.driSupport32Bit = true;
  programs.gamescope.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    #pkgs.xdg-desktop-portal-gtk # For both
    pkgs.xdg-desktop-portal-hyprland # For Hyprland
    pkgs.xdg-desktop-portal-gnome # For GNOME
  ];
  #Enable btrfs autoscrubbing for volume health
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
  #Flakes ON
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #Shell Aliases Below
  programs.bash.shellAliases = {
    #Fuck it we ball update ALL THE THINGS DAMNIT.  
    nixos-ball = "nix flake update && sudo nixos-rebuild --flake ~/.config/nix/nixos switch && flatpak update";
    #ABORT ABORT MISTAKES WERE MADE
    nixos-fuckgoback = "sudo nixos-rebuild --rollback switch";
    #We can Rebuild him
    nixos-robocop = "sudo nixos-rebuild --flake ~/.config/nix/nixos switch";
  };
  #Enable Plymouth for the nice bootup
  boot.plymouth = {
    enable = true;
    theme = "black_hud";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "black_hud" ];
      })
    ];
  };

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astralthinkpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_NZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "nz";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.astralphnx = {
    isNormalUser = true;
    description = "AstralPhnx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    armcord
    pinta
    thunderbird
    libreoffice-qt6-still
    onlyoffice-bin
    clapper
    spotify
    mission-center
    lollypop
    protonplus
    protonup-qt
    protontricks
    prismlauncher-unwrapped
    lutris-unwrapped
    waycheck
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  kitty
  swaynotificationcenter
  mesa-demos  
  fastfetch
  vscode
  vscode-extensions.jnoortheen.nix-ide
  swayosd
  rofi-wayland
  flameshot
  wl-screenrec
  wlogout
  eww
  btrfs-assistant
  gnome.gnome-tweaks
  gnome.gnome-software
  wget
  curl
  #home-manager
  github-desktop
  gh
  #swayfx-unwrapped
  font-awesome
  nerdfonts
  qadwaitadecorations-qt6
  qadwaitadecorations
  adw-gtk3
  adwaita-qt
  adwaita-qt6
  gnome.dconf-editor
  
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
