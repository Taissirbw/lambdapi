Installation from the sources
-----------------------------

- download `$node_file.tar.xz` from [node.js](https://nodejs.org/)

- extract node:

```bash
sudo apt-get install xz-utils # if you do not have xz already installed
tar xfa $node_file.tar.xz # creates $node_dir
```

- add `$node_dir/bin` in your `$PATH`:

```bash
export PATH=$node_dir:$PATH
```

- add `$node_dir/lib/node_modules` in your `$NODE_PATH`:

```bash
export NODE_PATH=$node_dir/lib/node_modules:$NODE_PATH
```

- install dependencies:

```bash
npm install -g @types/vscode
npm install -g vsce # for creating VSCE packages only
```

- compilation:

```bash
make
```

- manual (un)installation (for testing):

```bash
make [install|uninstall]
```

The install script creates a symbolic link from
``~/.vscode/extensions/lambapi`` to the current directory. You can
override this link location [for example for ``vscodium``] by setting the
``VSCE_DIR`` environment variable:

```bash
VSCE_DIR=~/.vscodium/extensions make install
```

Another solution for install is:

```bash
code --install-extension lambdapi-$version.vsix
```

Uninstallation can be done from code: go to extensions (Ctrl+Shift+X),
chose lambdapi and click on uninstall.

- create a VSCE package (optional):

```bash
vsce package # creates the file lambdapi-$version.vsix
```