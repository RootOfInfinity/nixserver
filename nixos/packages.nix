{
  pkgs,
  pkgs-unstable,
  pkgs-old,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    vim
    helix
    wget
    htop
    tio
    fastfetch
    nil
    dust
    bat
    # zellij
    ripgrep
    irust
    bacon
    p7zip
    killall
    vscode-langservers-extracted
    jdt-language-server
    wlogout
    cava
    pipes-rs
    cmus
    jq
    inetutils # check that
    usbutils
    udiskie
    udisks
    lld_20
    llvmPackages_20.libcxxClang
    python3
    pwntools
    binwalk
    exiftool
    mtpfs
    gcc
    btop
    unzip
    steam-run-free
    zulu25
    gdb
    gef
    crawl
    pkg-config
    bluetuith
    pulsemixer
    qemu_full
    markdown-oxide
    lldb_19
    yazi
    arduino-cli
    bc
    acpi
    todo
    pmutils
    git

    # docker stuff
    # docker_26
    # dockerfile-language-server-nodejs
    # docker-compose-language-service
    # yaml-language-server
    # mysql-workbench

    cups-brother-hll2350dw
  ];

}
