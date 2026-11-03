#!/bin/sh
# Combines the site's CSS and JS into one file each so the page makes fewer requests.
# Edit the original files listed below, then run `sh build.sh` and commit the bundles.
set -e
cd "$(dirname "$0")"

CSS="
assets/css/bootstrap.min.css
assets/fonts/font-awesome.min.css
assets/fonts/simple-line-icons.css
assets/css/slicknav.css
assets/css/nivo-lightbox.css
assets/css/animate.css
assets/css/main.css
assets/css/responsive.css
"

JS="
assets/js/jquery-min.js
assets/js/popper.min.js
assets/js/bootstrap.min.js
assets/js/jquery.counterup.min.js
assets/js/waypoints.min.js
assets/js/wow.js
assets/js/jquery.nav.js
assets/js/jquery.easing.min.js
assets/js/nivo-lightbox.js
assets/js/jquery.slicknav.js
assets/js/main.js
"

# Font paths in the icon CSS ("../fonts/...") resolve the same from assets/css/,
# so the bundle can live there unchanged. @charset is only valid at the top.
{
  echo '@charset "UTF-8";'
  for f in $CSS; do
    echo "/* $f */"
    grep -v '^@charset' "$f" | grep -v '^@import'
    echo
  done
} > assets/css/bundle.css

{
  for f in $JS; do
    echo "/* $f */"
    grep -v '^//# sourceMappingURL=' "$f"
    echo
    echo ';'
  done
} > assets/js/bundle.js

echo "Built assets/css/bundle.css and assets/js/bundle.js"
