# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

if Rails.env.production?
	puts "RUNNING IN PRODUCTION!"
	map CarpoolApp::Application.config.relative_url_root || "/" do
		run Rails.application
	end
else 
	run Rails.application
end
