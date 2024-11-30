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
          background = "0x1b2b34";
          foreground = "0xd8dee9";
        };

        normal = {
          black = "0x29414f";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0x65737e";
        };

        bright = {
          black = "0x405860";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xadb5c0";
        };
      };
    };
  };
}