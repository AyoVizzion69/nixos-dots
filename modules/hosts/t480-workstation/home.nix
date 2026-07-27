{ config, pkgs, ... }:
{
home = {
  username = "vizzion";
  homeDirectory = "/home/vizzion";
  stateVersion = "26.05";
  packages = with pkgs; [
  fastfetch
  nil
  ripgrep
  nixpkgs-fmt
  nodejs
  gcc
  wofi
  ];
};
  programs.git.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
      };
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        cursor = {
          text = "#1e1e2e";
          cursor = "#f5e0dc";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#cba6f7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#cba6f7";
          cyan = "#94e2d5";
          white = "#a6adc8";
        };
      };
    };
  };
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {};
    extraConfig = ''
      local mainMod = "SUPER"

      hl.config({
          general = {
              gaps_in = 10,
              gaps_out = 10,
              border_size = 1,
              resize_on_border = true,
              hover_icon_on_border = true,
              layout = "fibonacci",
              col = {
                  active_border = { colors = {"rgba(89b4faee)", "rgba(cba6f7ee)"}, angle = 45 },
                  inactive_border = "rgba(45475aaa)",
              },
          },
          decoration = {
              rounding = 1,
              blur = {
                  enabled = true,
                  size = 3,
                  passes = 5,
                  new_optimizations = true,
                  xray = false,

                  vibrancy = 0,
                  vibrancy_darkness = 0.38,
              },
          },
          input = {
              kb_layout = "us",
              kb_options = "grp:alt_space_toggle,compose:rctrl",
              accel_profile = "adaptive",
              natural_scroll = true,
              touchpad = {
                  natural_scroll = true,
                  tap_button_map = "lrm",
              },
          },
          misc = {
              force_default_wallpaper = 0,
              background_color = "rgba(1e1e2eff)",
          },
      })

      hl.gesture({
          fingers = 3,
          direction = "horizontal",
          action = "workspace",
      })

      hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
      hl.bind(mainMod .. " + Q", hl.dsp.window.close())
      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi --show drun"))
      hl.bind(mainMod .. " + M", hl.dsp.exit())

      hl.on("hyprland.start", function ()
      hl.exec_cmd("waybar")
    end)
    
      for i = 1, 9 do
          local key = i % 10
          hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
          hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end
    '';
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${./walls/wp3.jpg}" ];
      wallpaper = [
        {
          monitor = "";
          path = "${./walls/wp3.jpg}";
        }
      ];
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.8";
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";
      selection_background = "#585b70";
      selection_foreground = "#cdd6f4";
      color0 = "#45475a";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#cba6f7";
      color6 = "#94e2d5";
      color7 = "#bac2de";
      color8 = "#585b70";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#cba6f7";
      color14 = "#94e2d5";
      color15 = "#a6adc8";
    };
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 1;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "clock" ];

        "hyprland/workspaces" = {
          format = "{name}";
        };
        "hyprland/window" = {
          max-length = 50;
        };
        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [ "" "" "" ];
          };
        };
        "network" = {
          format-wifi = "{signalStrength}%";
          format-disconnected = "Disconnected";
        };
      };
    };
    style = ''
      * {
        font-family: "monospace";
        font-size: 13px;
        color: #cdd6f4;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.9);
      }
      #workspaces button {
        color: #a6adc8;
        padding: 0 5px;
        background: transparent;
        border: none;
        border-radius: 0;
      }
      #workspaces button:hover {
        background: #313244;
      }
      #workspaces button.active {
        color: #1e1e2e;
        background: #cba6f7;
      }
      #clock {
        color: #f9e2af;
        padding: 0 10px;
      }
      #pulseaudio {
        color: #a6e3a1;
        padding: 0 10px;
      }
      #network {
        color: #89b4fa;
        padding: 0 10px;
      }
      #window {
        color: #a6adc8;
        padding: 0 10px;
      }
    '';
  };
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      show = "drun";
      prompt = "Search...";
      allow_markup = true;
      insensitive = true;
    };
    style = ''
      window {
        background-color: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
        border-radius: 8px;
        border: 1px solid #45475a;
      }
      #input {
        margin: 5px;
        border: none;
        border-radius: 4px;
        background-color: #313244;
        color: #cdd6f4;
        padding: 8px;
      }
      #outer-box {
        margin: 5px;
      }
      #entry {
        padding: 8px;
        border-radius: 4px;
      }
      #entry:selected {
        background-color: #45475a;
        color: #cba6f7;
      }
    '';
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      steam = "steam -cef-disable-gpu";
      btw = "echo nixos is tuff";
    };
 };
}
