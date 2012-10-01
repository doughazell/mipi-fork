# Command-line Export Facilities

# TODO: Replace with 'gem install httparty'
namespace :export do
    desc "Dump contents of URL to command-line output."
    
    task :url, [:path, :username, :password] => :environment do |t, args|
        require "net/http"
        require "uri"
        
        uri = URI.parse(args.path)
        
        # Shortcut
        response = Net::HTTP.get_response(uri)
        
        # Will print response.body
        Net::HTTP.get_print(uri)
        
#        puts args.options
#        puts args.choices
    end
end