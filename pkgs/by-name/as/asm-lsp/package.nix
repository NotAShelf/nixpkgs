{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, stdenv
, darwin
}:
rustPlatform.buildRustPackage {
  name = "asm-lsp";

  src = fetchFromGitHub {
    owner = "bergercookie";
    repo = "asm-lsp";
    rev = "75c61b5a2452ca8e295297b7956a93635932646e";
    hash = "sha256-/Q1Ge57YgGKLzWdXFSUb/eovnjcI7TnaMAQZNp6OFVg=";
  };

  cargoHash = "sha256-5FX5oFWHecY8tXugSdQksURLt5fmZaUKca1IiC6R/tQ=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
    ];

  meta = with lib; {
    description = "Language server for NASM/GAS/GO Assembly";
    homepage = "https://github.com/bergercookie/asm-lsp";
    # license = licenses.unfree;
    maintainers = with maintainers; [ NotAShelf ];
    mainProgram = "asm-lsp";
  };
}
