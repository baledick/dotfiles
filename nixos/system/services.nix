{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      videoDrivers = ["amdgpu"];
      xkb.layout = "us";
      wacom.enable = true;
    };

    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    greetd = {
      enable = true;

      settings = {
        default_session={
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --time --issue --asterisks --cmd labwc";
          user = "greeter";
        };
      };
    };

    pipewire = {
      enable = true;

      audio.enable = true;

      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
