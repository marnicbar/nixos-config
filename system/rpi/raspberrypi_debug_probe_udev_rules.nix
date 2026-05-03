{ stdenv }:

stdenv.mkDerivation {
  name = "raspberrypi_debug_probe_udev_rules";
  src = ./.;
  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp 99-raspberrypi-debug-probe.rules $out/lib/udev/rules.d/
  '';
}
