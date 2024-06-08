{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    dataDir = "/home/sphink";
    user = "sphink";
    overrideFolders = true;
    overrideDevices = true;
    settings = {
      devices = {
        "zem" = {
          id = "VUU7PKC-L6J5XJP-HPBGBET-GW7N7J4-LYCZHHV-234T3AS-GCYCQ2X-KI2ZBQC";
        };
        "marvin" = {
          id = "V3UL6LB-EKABB5D-EULJLQQ-WPW2IBG-AZM4BN7-MIJIG7J-V7J5KPH-TD35ZAI";
        };
        "HLTE556N" = {
          id = "YMXYP7H-2QI6CMQ-Q2AUPR7-TX4CCCC-WL3UMPQ-H5SUXWN-QM2EAPT-2HEVVAB";
        };
      };

      options = {
        urAccepted = -1;
      };

      folders = {
        "Notes" = {
          path = "/home/sphink/notes";
          devices = [
            "zem"
            "marvin"
            "HLTE556N"
          ];
          id = "hyrnl-n7ill";
        };
        "Calibre" = {
          path = "/home/sphink/Documents/calibre";
          devices = [
            "zem"
            "marvin"
          ];
          id = "mzgzk-fanzv";
        };
        "vault" = {
          path = "/home/sphink/.vault";
          devices = [
            "zem"
            "marvin"
            "HLTE556N"
          ];
          id = "yingz-zdnsi";
        };
      };
    };
  };
}
