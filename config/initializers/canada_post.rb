require 'canada_post'
APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/canada_post_credentials.yml")[Rails.env]
CANADA_POST_SERVICE = CanadaPost::Client.new(username: APP_CONFIG[:username],
                                               password: APP_CONFIG[:password],
                                               customer_number: APP_CONFIG[:customer_number],
                                               mode: APP_CONFIG[:mode])