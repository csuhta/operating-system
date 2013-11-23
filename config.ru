require "rack-force_domain"
require "rack-server-pages"

STDOUT.sync = true

use Rack::Deflater # Use gzip
use Rack::Head # Answer HEAD requests
use Rack::ServerPages # ERB processing
use Rack::ForceDomain, ENV["EXPECTED_HOSTNAME"] # Force users onto the offical domain name

if ENV.fetch("RACK_ENV") == "production" && ENV["HTTP_USERNAME"] && ENV["HTTP_PASSWORD"]
  use Rack::Auth::Basic, "Restricted Site" do |username, password|
    [username, password] == [
      ENV.fetch("BASIC_AUTH_USERNAME"),
      ENV.fetch("BASIC_AUTH_PASSWORD")
    ]
  end
end

use Rack::Static, {
  urls: [""],           # Serve everything in the public folder
  root: "public",       # The public folder is "/"
  index: "index.html",  # Use the index.html convention
  header_rules: [
    [:all, {
      "Cache-Control"    => "public, max-age=31536000",
      "X-Frame-Options"  => "DENY",
      "X-XSS-Protection" => "1; mode=block",
      "X-UA-Compatible"  => "IE=Edge",
    }]
  ]
}

run Rack::Directory.new("public")
