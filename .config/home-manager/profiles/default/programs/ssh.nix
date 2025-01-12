{ config, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {};
  };

  home.file.".ssh/authorized_keys".text = ''
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLdwLOSL6yff5oyllhT183lsBuZndf0xR1YHyyxiz+eJZrCZv0HSorjr1q7d//cHtOLfoUEcX1kUtW1BrRJtN+3D/y9xCgSgC8NeF9gJjE6B+cMkfWcPTRQcM44ukY9ZpSRI+2x/Y/Q3tEf27D50KKIoX6Pm7ffAMufvXsLi7Tnkwgc7y6Fh5jaq6TsESjYnzHxFP5Sx9VmrOjSF6kMssjpC8ItevqnmS7ImGYgfmSII1LfrmvrMXCy41109ilLlNswVg8qsGThgQSbyt99KMIUNNvuYNsLkJPsvSSYHvxwRmlRGN7Nb8DszL/S9e+sQffplfq/S4rCZyTMAwBO3Mh adam@adamwhitlock.com
  '';
}
