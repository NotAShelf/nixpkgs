{
  lib,
  buildGoModule,
  fetchFromGitHub,
  gitUpdater,
}:
let
  pname = "hexxy";
  version = "2024-06-07-unstable";
in
buildGoModule {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "sweetbbak";
    repo = "hexxy";
    # upstream does not publish releases, i.e., there are no tags
    rev = "30e0aa5549bbafeb8204fe34b0d37019f9acc975";
    hash = "sha256-KBgxZD95UT7i/eYeKLm0LVLliKgK/KiJYXVY9zzwbvk=";
  };

  vendorHash = "sha256-qkBpSVLWZPRgS9bqOVUWHpyj8z/nheQJON3vJOwPUj4=";
  ldflags = [
    "-s"
    "-w"
  ];

  passthru.updateScript = gitUpdater { };

  meta = {
    description = "A modern and beautiful alternative to xxd and hexdump";
    homepage = "https://github.com/sweetbbak/hexxy";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.NotAShelf ];
  };
}
