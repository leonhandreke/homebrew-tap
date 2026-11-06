# leonhandreke/tap

Homebrew tap for [transmission-remote-gtk](https://github.com/leonhandreke/transmission-remote-gtk), built from source.

```
brew tap leonhandreke/tap
brew trust leonhandreke/tap
brew install leonhandreke/tap/transmission-remote-gtk
```

To start it from the Finder and open `.torrent` files with it, link the app into `/Applications` once:

```
ln -sf "$(brew --prefix)/opt/transmission-remote-gtk/Transmission Remote GTK.app" /Applications/
```
