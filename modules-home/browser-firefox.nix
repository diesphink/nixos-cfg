# =======
# Firefox
# =======

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.firefox = {
    enable = true;

    profiles."diego" = {
      isDefault = true;
      
      userChrome = ''
        @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

        /* to hide the native tabs */
        #TabsToolbar {
            visibility: collapse;
        }

        /* to hide the sidebar header */
        #sidebar-header {
            visibility: collapse;
        }

        #sidebar { 
            min-width:0px !important; 
            max-width:none !important; 
        }

        #main-window[inFullscreen] #sidebar-box,
        #main-window[inFullscreen] #sidebar-splitter {
          display: none !important;
          width: 0px !important;
        }

        #webrtcIndicator {
          display: none;
        }
      '';

      settings = {
        "browser.newtabpage.pinned" = [
          {
            title = "gmail";
            url = "https://gmail.com";
          }
        ];
      };

      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets",true);
        user_pref("browser.toolbars.bookmarks.visibility","never");
        user_pref("media.hardwaremediakeys.enabled",false);
      '';

    };

  };
}
