{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook4,
  cairo,
  gdk-pixbuf,
  glib,
  gtk4,
  pango,
  polkit,
}:
rustPlatform.buildRustPackage {
  pname = "soteria";
  version = "0-unstable-2024-06-07";

  src = fetchFromGitHub {
    owner = "ImVaskel";
    repo = "soteria";
    rev = "47f6c1e3ffec4806db40b9999470b9006335e8a7";
    hash = "sha256-qmVymqhGyv92jU1ZWyP9ZRTKYEXz8b8R1bOrIwAfA0k=";
  };

  cargoHash = "sha256-dPaBXXMYGBqncKwhR/HeiKSOmoyPg+WhsvE3yYgY9hw=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk4
    pango
  ];

  # From upstream packaging:
  #  Takes advantage of nixpkgs manually editing PACKAGE_PREFIX by grabbing it from
  #  the binary itself.
  #  https://github.com/NixOS/nixpkgs/blob/9b5328b7f761a7bbdc0e332ac4cf076a3eedb89b/pkgs/development/libraries/polkit/default.nix#L142
  #  https://github.com/polkit-org/polkit/blob/d89c3604e2a86f4904566896c89e1e6b037a6f50/src/polkitagent/polkitagentsession.c#L599
  preBuild = ''
    export POLKIT_AGENT_HELPER_PATH="$(strings ${polkit.out}/lib/libpolkit-agent-1.so | grep "polkit-agent-helper-1")"
  '';

  meta = {
    description = "A Polkit authentication agent written in GTK designed to be used with any desktop environment.";
    homepage = "https://github.com/ImVaskel/soteria";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      NotAShelf
      itslychee
    ];
    mainProgram = "soteria";
  };
}
