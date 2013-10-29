STDOUT.sync = true

use Rack::Deflater      # Use gzip
use Rack::Head          # What does this do? :(

use Rack::Static, {
  urls: [""],           # Serve everything in the public folder
  root: "public",       # The public folder is "/"
  index: "index.html",  # Use the index.html convention
  header_rules: [
    [:all, {
      "Cache-Control" => "public, max-age=31536000",
    }]
  ]
}

run Rack::Directory.new("public")
