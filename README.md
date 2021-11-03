# AppImage for Tmux

This is a Docker image and script for creating an AppImage package for Tmux.

## How to use

`create_appimage.sh` script can generate AppImage for any version of tmux (at least recent, I didn't test many old versions). The first argument to the script should be version number from the [release page of tmux](https://github.com/tmux/tmux/releases). The second argument is optional and needed for the release candidate version of tmux. Sometimes they have a number at the end, for example, 3.3-rc2. This second argument for such a number.

Also, `create_appimage.sh` can create AppImage from the latest commit in master brunch of [tmux repository](https://github.com/tmux/tmux). For that, pass `master` as the first argument for the script.

Docker needs to be installed on the system.

Script will download and run docker container, which will create an AppImage file in the current directory.

Example:
```bash
# Building 3.2a version
./create_appimage.sh 3.2a
# Building 3.3-rc2 version
./create_appimage.sh 3.3-rc 2
# Building from master
./create_appimage.sh master
```

## Acknowledgments

To understand how to create AppImage and for creating this project I looked up source code of multiple similar projects.

- [nelsonenzo/tmux-appimage](https://github.com/nelsonenzo/tmux-appimage) - Dockerfile to create an AppImage of tmux.
- [Provide an AppImage generation script Pull Request for tmux](https://github.com/tmux/tmux/pull/2465) - @michaellee8 wanted to create an official AppImage for tmux. So that the AppImage file will be on the releases page in [tmux repository](https://github.com/tmux/tmux). He created [this script](https://github.com/michaellee8/tmux/blob/master/.github/genappimage.sh) for building the AppImage package.
- [NeoVim script for creating AppImage](https://github.com/neovim/neovim/blob/master/scripts/genappimage.sh)
- [Build instructions from tmux wiki](https://github.com/tmux/tmux/wiki/Installing#from-source-tarball)
