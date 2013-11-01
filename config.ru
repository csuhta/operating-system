require "rack-force_domain"

STDOUT.sync = true

use Rack::Deflater # Use gzip
use Rack::Head # Answer HEAD requests
use Rack::ETag # Set ETags for content
use Rack::ForceDomain, ENV["EXPECTED_HOSTNAME"] # Force users onto the offical domain name

use Rack::Static, {
  urls: [""],           # Serve everything in the public folder
  root: "public",       # The public folder is "/"
  index: "index.html",  # Use the index.html convention
  header_rules: [
    [:all, {
      "Cache-Control"    => "public, max-age=31536000",
      "X-Frame-Options"  => "DENY",
      "X-XSS-Protection" =>	"1; mode=block",
      "X-UA-Compatible"  => "IE=Edge",
    }]
  ]
}

run Rack::Directory.new("public")
