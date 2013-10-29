preload_app true
worker_processes ENV.fetch("UNICORN_PROCESSES").to_i
timeout ENV.fetch("REQUEST_TIMEOUT").to_i

before_fork do |server, worker|

  Signal.trap "TERM" do
    puts "Unicorn master caught SIGTERM"
    Process.kill "QUIT", Process.pid
  end

  sleep 1

end

after_fork do |server, worker|

  Signal.trap "TERM" do
    # Do nothing, wait for SIGQUIT
  end

end
