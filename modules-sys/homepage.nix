# Homepage

# Documentation: https://gethomepage.dev/latest/configs/
# Material Design Icons: https://materialdesignicons.com/
# Simple Icons: https://simpleicons.org/

{ config, pkgs, ... }:

let
  inherit (config.lib.stylix.colors)
    base00
    base01
    base02
    base03
    base04
    base05
    base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;
in

{
  services.homepage-dashboard = {
    enable = true;
    settings = {
      # background = "#2E3440";
      target = "_self";
      color = "slate";
      theme = "dark";
      # background = {
      #   image = "https://source.unsplash.com/random/2560x1440";
      #   brightness = 50;
      #   saturate = 50;
      # };
      # cardBlur = "md";

      # headerStyle = "boxedWidgets";
      iconStyle = "theme";
      headerStyle = "clean";
      useEqualHeights = true;
      statusStyle = "dot";
      layout = [
        {
          "General Usage" = {
            # tab = "Test";
            # icon = "mdi-web";
            icon = "mdi-circle-medium";
            style = "row";
            columns = 4;
          };
        }
        {
          Social = {
            # tab = "Other";
            # icon = "mdi-chat";
            icon = "mdi-circle-medium";
            style = "row";
            columns = 4;
          };
        }
        {
          Admin = {
            # tab = "Other";
            # icon = "mdi-chat";
            icon = "mdi-circle-medium";
            style = "row";
            columns = 4;
          };
        }
        {
          Shop = {
            # tab = "Other";
            # icon = "mdi-chat";
            icon = "mdi-circle-medium";
            style = "row";
            columns = 4;
          };
        }
        {
          References = {
            # icon = "mdi-book-open-variant";
            icon = "mdi-circle-medium";
            style = "row";
            columns = 4;
          };
        }
        {
          Local = {
            # icon = "mdi-desktop-classic";
            icon = "mdi-circle-medium";
            style = "column";
            columns = 4;
          };
        }
        {
          Marvin = {
            # icon = "mdi-server-network";
            icon = "mdi-circle-medium";
            style = "column";
          };
        }
        {
          Devices = {
            # icon = "mdi-lan";
            icon = "mdi-circle-medium";
            style = "column";
          };
        }
      ];
    };

    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "google";
          target = "_blank";
          showSearchSuggestions = true;
        };
      }
      {
        "openmeteo" = {
          label = "Sorocaba"; # optional
          # 23°28'59.8"S 47°27'54.5"W
          latitude = -23.4832709;
          longitude = -47.4700209;
          timezone = "Europe/Kiev"; # optional
          units = "metric"; # or imperial
          cache = 5; # Time in minutes to cache API responses, to stay within limits
          format.maximumFractionDigits = 1;
        };
      }
    ];

    services = [
      {
        Devices = [
          {
            "Jânio" = {
              icon = "mdi-robot-vacuum";
              href = "http://192.168.15.15";
              siteMonitor = "http://192.168.15.15";
            };
          }
          {
            "Slartibartfast" = {
              icon = "mdi-printer-3d-nozzle";
              href = "http://slartibartfast.local";
              siteMonitor = "http://slartibartfast.local";
            };
          }
          {
            "Roteador Vivo" = {
              icon = "mdi-router-wireless";
              href = "http://192.168.15.1";
              siteMonitor = "http://192.168.15.1";
            };
          }
        ];
      }
      {
        Local = [
          {
            "Syncthing - Ford" = {
              icon = "mdi-sync";
              href = "http://localhost:8384/";
              siteMonitor = "http://localhost:8384/";
            };
          }
        ];
      }
      {
        Marvin = [
          {
            "Marvin - Admin" = {
              icon = "mdi-security";
              href = "https://marvin.lly.com.br";
              siteMonitor = "https://marvin.lly.com.br";
            };
          }
          {
            "File Station" = {
              icon = "mdi-security";
              href = "https://files.lly.com.br";
              siteMonitor = "https://files.lly.com.br";
            };
          }
          {
            "Plex" = {
              icon = "mdi-plex";
              href = "https://plex.lly.com.br";
              siteMonitor = "https://plex.lly.com.br";
            };
          }
          {
            "Syncthing - Marvin" = {
              icon = "mdi-sync";
              href = "https://sync.lly.com.br";
              siteMonitor = "https://sync.lly.com.br";
            };
          }
        ];
      }
      {
        Hactar = [
          {
            "Grocy" = {
              icon = "mdi-fridge-alert";
              href = "https://grocy.lly.com.br";
              siteMonitor = "https://grocy.lly.com.br";
            };
          }
          {
            "Grocy - Tablet" = {
              icon = "mdi-tablet-dashboard";
              href = "http://192.168.15.2:9283/grocy-tablet";
              siteMonitor = "http://192.168.15.2:9283/grocy-tablet";
            };
          }
          {
            "FreshRSS" = {
              icon = "mdi-fridge-alert";
              href = "https://rss.lly.com.br";
              siteMonitor = "https://rss.lly.com.br";
            };
          }
          {
            "Actual Budget" = {
              icon = "mdi-fridge-alert";
              href = "https://budget.lly.com.br";
              siteMonitor = "https://budget.lly.com.br";
            };
          }

        ];
      }
    ];

    bookmarks = [
      {
        "Social" = [
          {
            "Bluesky" = [
              {
                icon = "si-bluesky";
                href = "https://bsky.app/";
              }
            ];
          }
          {
            "Discord" = [
              {
                icon = "mdi-discord";
                href = "https://discord.com/channels/@me";
              }
            ];
          }
          {
            "WhatsApp" = [
              {
                icon = "mdi-whatsapp";
                href = "https://whatsapp.com/";
              }
            ];
          }
          {
            "Instagram" = [
              {
                icon = "mdi-instagram";
                href = "https://instagram.com/";
              }
            ];
          }
          {
            "Reddit" = [
              {
                icon = "mdi-reddit";
                href = "https://reddit.com";
              }
            ];
          }
        ];
      }
      {
        "General Usage" = [

          {
            "Gmail" = [
              {
                icon = "mdi-gmail";
                href = "https://gmail.com/";
              }
            ];
          }
          {
            "Chess" = [
              {
                icon = "mdi-chess-king";
                href = "https://chess.com/";
              }
            ];
          }
          {
            "GitHub" = [
              {
                icon = "mdi-github";
                href = "https://github.com/diesphink/";
              }
            ];
          }
          {
            "iFood" = [
              {
                icon = "mdi-food";
                href = "https://ifood.com.br";
              }
            ];
          }
          {
            "Chat GPT" = [
              {
                icon = "mdi-head-snowflake";
                href = "https://chatgpt.com/?oai-dm=1";
              }
            ];
          }
          {
            "Youtube" = [
              {
                icon = "mdi-youtube";
                href = "https://youtube.com";
              }
            ];
          }
          {
            "XP" = [
              {
                icon = "mdi-bank";
                href = "https://portal.xpi.com.br/default.aspx";
              }
            ];
          }
          {
            "Printables" = [
              {
                icon = "mdi-printer-3d";
                href = "https://printables.com";
              }
            ];
          }
        ];
      }
      {
        "Shop" = [
          {
            "Mercado Livre" = [
              {
                icon = "mdi-cart";
                href = "https://mercadolivre.com.br";
              }
            ];
          }
          {
            "Ali Express" = [
              {
                icon = "mdi-cart";
                href = "https://aliexpress.com";
              }
            ];
          }
        ];
      }
      {
        "Admin" = [
          {
            "Squarespace" = [
              {
                icon = "mdi-web-box";
                href = "https://account.squarespace.com/domains";
              }
            ];
          }
          {
            "Cloudflare" = [
              {
                icon = "mdi-web-box";
                href = "https://dash.cloudflare.com/";
              }
            ];
          }
          {
            "Oracle Cloud" = [
              {
                icon = "mdi-web-box";
                href = "https://cloud.oracle.com/?tenant=sphink";
              }
            ];
          }
          {
            "Registro.br" = [
              {
                icon = "mdi-web-box";
                href = "https://registro.br";
              }
            ];
          }
        ];
      }
      {
        References = [
          {
            "Build123d Documentation" = [
              {
                icon = "mdi-book-open-outline";
                href = "https://build123d.readthedocs.io/en/latest/";
              }
            ];
          }
          {
            "Nix - Package Search" = [
              {
                icon = "mdi-nix";
                href = "https://search.nixos.org/packages?channel=unstable";
              }
            ];
          }
          {
            "Nix - Home manager options" = [
              {
                icon = "mdi-nix";
                href = "https://nix-community.github.io/home-manager/options.xhtml";
              }
            ];
          }
          {
            "Nix - Built-ins functions" = [
              {
                icon = "mdi-nix";
                href = "https://teu5us.github.io/nix-lib.html";
              }
            ];
          }
          {
            "Nerd Fonts Cheat Sheet" = [
              {
                icon = "mdi-font-awesome";
                href = "https://www.nerdfonts.com/cheat-sheet";
              }
            ];
          }
          {
            "Tabler" = [
              {
                icon = "mdi-table";
                href = "https://preview.tabler.io/?theme=light";
              }
            ];
          }
          {
            "Tabler - Icons" = [
              {
                icon = "mdi-table-star";
                href = "https://tabler.io/icons";
              }
            ];
          }
          {
            "Material Design Icons" = [
              {
                icon = "mdi-material-design";
                href = "https://pictogrammers.com/library/mdi/";
              }
            ];
          }
        ];
      }
    ];

    customCSS = ''
      /* #footer {
        display: none !important;
      } */

      #page_container {
        background-color: #${base00} !important;
      }

      .bg-emerald-500 {
        background-color: #${base0B} !important;
      }

      .bg-rose-500 {
        background-color: #${base08} !important;
      }

      .bg-theme-100\/20 {
        background-color: #${base02} !important;
      }

      .bookmark-icon {
        background-color: #${base01} !important;
      }

      .information-widget-search input {
        background-color: #${base00} !important;
        border-color: #${base02} !important;
      }

      .information-widget-search button {
        background-color: #${base01} !important;
      }

      .service-icon div, .bookmark-icon div div {
        background-color: #${base07} !important;
      }

      #widgets-wrap svg {
        color:  #${base07} !important;
      }

      #widgets-wrap .resource-usage.bg-theme-800\/30 {
        background-color: #${base01} !important;
      }

      #widgets-wrap .resource-usage .bg-theme-800\/70 {
        background-color: #${base03} !important;
      }


      dialog {
        background-color: #${base00} !important;
      }

      dialog input {
        background-color: #${base01} !important;
      }

      dialog button.bg-theme-300\/50 {
        background-color: #${base0B} !important;
        color: #${base00} !important;
      }

      dialog button.bg-theme-300\/50 div div div {
        background-color: #${base00} !important;
      }

      .bookmark-group-name, .service-group-name {
        color: #${base03} !important;
        font-size: 1em !important;
      }

      .bookmark-group-icon div, .service-group-icon div {
        background-color: #${base03} !important;
      }

    '';

    # bookmarks = {
    #   Entertainment = [
    #     {
    #       chess = {
    #         abbr = "CH";
    #         href = "https://www.chess.com";
    #       };
    #       twitter = {
    #         abbr = "TT";
    #         href = "https://www.twitter.com";
    #       };
    #     }
    #   ];
    # };
  };
}
