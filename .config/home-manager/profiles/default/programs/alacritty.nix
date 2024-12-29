{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      window = {
        title = "terminal";
        dynamic_title = false;
        opacity = 0.95;
        startup_mode = "Windowed";
        decorations = "Buttonless";
        
        dimensions = {
          columns = 120;
          lines = 32;
        };
        
        padding = {
          x = 10;
          y = 10;
        };
      };

      scrolling = {
        history = 50000;
        multiplier = 3;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;

        primary = {
          background = "0x2e3440";
          foreground = "0xd8dee9";
        };

        normal = {
          black = "0x3b4252";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x88c0d0";
          white = "0xe5e9f0";
        };

        bright = {
          black = "0x4c566a";
          red = "0xbf616a";
          green = "0xa3be8c";
          yellow = "0xebcb8b";
          blue = "0x81a1c1";
          magenta = "0xb48ead";
          cyan = "0x8fbcbb";
          white = "0xeceff4";
        };
      };
    };
  };
}