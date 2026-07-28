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
      };
  programs.helix = {
    enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {};
    extraConfig = ''
      local mainMod = "SUPER"

      hl.config({
          general = {
              gaps_in = 12,
              gaps_out = 10,
              border_size = 0,
              resize_on_border = true,
              hover_icon_on_border = true,
              layout = "fibonacci",
              col = {
                  active_border = { colors = {"rgba(89b4faee)", "rgba(cba6f7ee)"}, angle = 45 },
                  inactive_border = "rgba(45475aaa)",
              },
          },
          decoration = {
              rounding = 12,
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

      hl.window_rule({
    name = "kitty-opacity",
    match = { class = "kitty" },
    opacity = 0.8
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
       hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
      hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
      hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

      hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

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
      preload = [ "${./walls/city.jpg}" ];
      wallpaper = [
        {
          monitor = "";
          path = "${./walls/city.jpg}";
        }
      ];
    };
  };
  programs.kitty = {
    enable = true;
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
