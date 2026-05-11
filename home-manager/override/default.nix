{...}:

{
  home.file.".local/share/applications/google-chrome-wayland.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Name=Google Chrome (Wayland)
    Exec=google-chrome --enable-features=UseOzonePlatform --ozone-platform=wayland %U
    Icon=google-chrome
    Type=Application
    Categories=Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;
  '';
}