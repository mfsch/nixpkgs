{ lib
, mkXfceDerivation
, exo
, garcon
, gobject-introspection
, gtk3
, libdbusmenu-gtk3
, libwnck
, libxfce4ui
, libxfce4util
, tzdata
, vala
, xfconf
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-panel";
  version = "4.18.2";

  sha256 = "sha256-kqc+5pClmAPEkyNWKj4uPgwFFKBDWrwFHqRDWjYrwa4=";

  nativeBuildInputs = [
    gobject-introspection
    vala
  ];

  buildInputs = [
    exo
    garcon
    libdbusmenu-gtk3
    libxfce4ui
    libwnck
    xfconf
    tzdata
  ];

  propagatedBuildInputs = [
    gtk3
    libxfce4util
  ];

  patches = [ ./xfce4-panel-datadir.patch ];

  postPatch = ''
    substituteInPlace plugins/clock/clock.c \
       --replace "/usr/share/zoneinfo" "${tzdata}/share/zoneinfo"
  '';

  meta = with lib; {
    description = "Panel for the Xfce desktop environment";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
