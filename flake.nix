{
  description = "MCP Genmedia Go Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    vertex-ai-creative-studio = {
      url = "github:GoogleCloudPlatform/vertex-ai-creative-studio";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, vertex-ai-creative-studio }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        src = "${vertex-ai-creative-studio}/experiments/mcp-genmedia/mcp-genmedia-go";
        mcp-servers = [
          "mcp-avtool-go"
          "mcp-chirp3-go"
          "mcp-imagen-go"
          "mcp-lyria-go"
          "mcp-veo-go"
        ];

        buildGoMcp = { pname, ... }@args: pkgs.buildGoModule (args // {
          inherit src;
          pname = pname;
          version = "0.1.0";
          vendorHash = "sha256-xAfn6cRU61D949nwOj96Gt8xbSjcRPxh2vKNWBLCfGo=";
          proxyVendor = true;
          subPackages = [ "./${pname}" ];
          ldflags = [ "-s" "-w" ];
          nativeBuildInputs = [ pkgs.go pkgs.google-cloud-sdk ];
        });

      in
      {
        packages = (builtins.listToAttrs (map (server: {
          name = server;
          value = buildGoMcp { pname = server; };
        }) (builtins.filter (n: n != "mcp-avtool-go") mcp-servers))) // {
          "mcp-avtool-go" = buildGoMcp {
            pname = "mcp-avtool-go";
            buildInputs = [ pkgs.ffmpeg ];
            doCheck = false;
          };
        };
      });
}
