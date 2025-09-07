{ stdenv }:

stdenv.mkDerivation {
  name = "stlink-udev-rules";
  src = ./.;
  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp 49-stlinkv3.rules $out/lib/udev/rules.d/
  '';
}
