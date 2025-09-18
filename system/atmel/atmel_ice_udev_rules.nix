{ stdenv }:

stdenv.mkDerivation {
  name = "atmel-ice-udev-rules";
  src = ./.;
  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp 99-atmel_ice.rules $out/lib/udev/rules.d/
  '';
}
