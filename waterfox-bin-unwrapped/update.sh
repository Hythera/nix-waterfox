#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash nix curl coreutils jq common-updater-scripts

set -eou pipefail

latestVersion=$(curl ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} -sL https://api.github.com/repos/BrowserWorks/Waterfox/releases | jq -r '.[0].tag_name')
currentVersion=$(nix eval --raw .#waterfox-bin-unwrapped.version)

echo "latest  version: $latestVersion"
echo "current version: $currentVersion"

if [[ "$latestVersion" == "$currentVersion" ]]; then
    echo "package is up-to-date"
    exit 0
fi

hash_linux=$(nix-prefetch-url https://cdn.waterfox.com/waterfox/releases/${latestVersion}/Linux_x86_64/waterfox-${latestVersion}.tar.bz2)
hash_linux=$(nix --extra-experimental-features nix-command hash convert "sha256:$hash_linux")
echo Linux: $hash_linux

hash_darwin=$(nix-prefetch-url https://cdn.waterfox.com/waterfox/releases/${latestVersion}/Darwin_x86_64-aarch64/Waterfox%20${latestVersion}.dmg --name waterfox-${latestVersion}.dmg)
hash_darwin=$(nix --extra-experimental-features nix-command hash convert "sha256:$hash_darwin")
echo Darwin: $hash_darwin

#update-source-version waterfox-bin-unwrapped $latestVersion $hash --system="x86_64-linux" --ignore-same-version
