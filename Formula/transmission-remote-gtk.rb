class TransmissionRemoteGtk < Formula
  desc "GTK remote control for the Transmission BitTorrent client"
  homepage "https://github.com/leonhandreke/transmission-remote-gtk"
  url "https://github.com/leonhandreke/transmission-remote-gtk/archive/refs/tags/2.0.0.tar.gz"
  sha256 "af44bf9fe6dbbdad39c9189b9cfe8dd4055332d27163bb9719cfec61b737fd93"
  license "GPL-2.0-or-later"
  head "https://github.com/leonhandreke/transmission-remote-gtk.git", branch: "main"

  depends_on "gettext" => :build
  depends_on "librsvg" => :build # rsvg-convert renders the app icon
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "adwaita-icon-theme"
  depends_on "glib"
  depends_on "glib-networking"
  depends_on "gtk4"
  depends_on "json-glib"
  depends_on "libsoup"
  depends_on :macos

  def app_name
    "Transmission Remote GTK.app"
  end

  def install
    # Builds the executable and an application bundle that uses the
    # libraries and data installed by Homebrew. Compiled locally, so it is
    # never quarantined and needs no Developer ID signature.
    system "meson", "setup", "build", "-Dmacos_bundle=enabled", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
    prefix.install "build/#{app_name}"
  end

  def caveats
    <<~EOS
      To start it from the Finder and open .torrent files with it, link the
      application into /Applications (the link survives upgrades):
        ln -sf "#{opt_prefix}/#{app_name}" /Applications/
    EOS
  end

  test do
    assert_path_exists prefix/app_name/"Contents/MacOS/transmission-remote-gtk"
    system "codesign", "--verify", prefix/app_name/"Contents/MacOS/transmission-remote-gtk"
  end
end
