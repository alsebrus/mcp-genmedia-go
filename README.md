# MCP Genmedia Go

This project provides a Nix flake for building a set of Go-based MCP (Media Control Platform) servers for media generation using Google's Vertex AI Creative Studio.

## Description

The flake builds several individual Go modules, each representing a specific MCP server for different media generation tasks. The source code for these servers is sourced from the [GoogleCloudPlatform/vertex-ai-creative-studio](https://github.com/GoogleCloudPlatform/vertex-ai-creative-studio) repository.

## Dependencies

The project has the following primary dependencies, as defined in `flake.nix`:

*   **Nixpkgs:** The standard Nix package set.
*   **flake-utils:** A helper library for creating Nix flakes.
*   **vertex-ai-creative-studio:** The source repository containing the Go MCP server implementations.
*   **Go:** The programming language used for the servers.
*   **Google Cloud SDK:** For interacting with Google Cloud services.
*   **FFmpeg:** A dependency for the `mcp-avtool-go` server.

## How to Build

To build the packages provided by this flake, you can use the `nix build` command. For example, to build the `mcp-imagen-go` server, run the following command from the root of the project directory:

```sh
nix build .#mcp-imagen-go
```

This will create a `result` symlink in the current directory, which will point to the compiled binary.

## Available Packages

The following packages can be built using this flake:

*   `mcp-avtool-go`
*   `mcp-chirp3-go`
*   `mcp-imagen-go`
*   `mcp-lyria-go`
*   `mcp-veo-go`
