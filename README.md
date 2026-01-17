<p align="center">
    <a href="https://www.waterfox.com"><img src=".github/assets/nix-waterfox.png" alt="Nix Waterfox" height=170></a>
</p>
<h1 align="center">Nix Waterfox</h1>

<p align="center">
<a href="https://www.waterfox.com/download" target="_blank"><img height=20 src="https://img.shields.io/badge/version-6.6.8-blue" alt="version"/></a>
<a href="https://github.com/Hythera/nix-waterfox/stargazers" target="_blank"><img height=20 src="https://img.shields.io/github/stars/Hythera/nix-waterfox" alt="stars"/>
</p>

<div align="center">
  <a href="https://www.waterfox.com">Waterfox</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://github.com/Hythera/nix-waterfox/issues/new">Issues</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://www.waterfox.com/releases">Changelog</a>
  <br />
</div>

> [!Note]
> This flake is experimental. While I will try to keep it updated, I can't garuantee just in time security updates until Waterfox gets adopted into **nixpkgs**.

## What is Nix Waterfox?

Since the Waterfox browser isn't currently in **nixpkgs**, this flake implements both the `waterfox` and the `waterfox-bin` version of it. Waterfox isn't currently in **nixpkgs** since there is no **commiter** who is willing to maintain it. If you are interested in the progress, you can checkout https://github.com/NixOS/nixpkgs/pull/475318.

## Installation

This flake supports `x86_64` & `aarch64` for both Linux and Darwin. Note while `waterfox-bin` supports all Darwin architectures, it only supports `x86_64-linux`, so if you want to use Waterfox on `aarch64-linux`, you have to use the from-source build.

### Running Waterfox in a Nix-Shell

You can test Waterfox on your system by running it in a **Nix-Shell**. It is recommendet to use the `-bin` package for this.

```bash
# Run the Nix-Shell (requires the new experimental Nix command)
nix shell github:Hythera/nix-waterfox#waterfox-bin

# Start Waterfox
waterfox
```

### System Package

The second way is to install Waterfox on your NixOS system. While you can use the `waterfox` package, it is recommended to use the `waterfox-bin` package, as the from-source build can take up to 2 hours depending on your system. If you don't want to install Waterfox globally, you can use tools like **home-manager**. Just use `home.packages` in you home-configuration instead.

```nix
# flake.nix
{
  inputs = {
    rootapp.url = "github:Hythera/nix-waterfox";
    ...
  };
  outputs = {
    nixpkgs,
    ...
  }: let
    system = "...";
    in {
      nixosConfigurations."..." = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./configuration.nix
          ...
        ];
      };
    }
}
```

```nix
# configuration.nix
{ 
  inputs,
  pkgs, 
  ...
}:
{
  environment.systemPackages = [
    inputs.waterfox.packages.${pkgs.system}.waterfox-bin
  ]
}
```
