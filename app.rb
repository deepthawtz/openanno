$KCODE="utf-8"
%w[ rubygems sinatra setup ].map {|x| require x }
#before do
#  @redis = Redis.new
#end

# this sucker doesn't work in current sinatra
#class Sinatra::Base
#      # New code here
#      def subdomain(pattern)
#        condition {
#          if request.subdomains[0] =~ pattern
#            @params[:subdomain] = $~[1..-1]
#            true
#          else
#            false
#          end
#        }
#      end
#      # End new code      
#end

# post annotation
#post "/:uniqueid", :subdomain => /api/ do
post "/api/:uniqueid" do

  api_key = params[:api_key]
  annotations = JSON.parse(request.body.read.to_s)
  
  # TODO write to DB
  
 
  "Ok"
  
end

# get annotations for object
#get "/:uniqueid", :subdomain => /api/ do
get "/api/:uniqueid" do

  # TODO pull object from MongoDB
  # build it to look like this
  object = { "id" => "UNIQUE_ID_123",
              "annotations" => [
                              {"movie" => {"actor" => "Sean Connery", "year" => "1991"}},
                              {"type" => {"annotation-name" => "value", "annotation-name2" => "value2"}},
                              {"movie" => {"year" => "none"}}
                              ]
              }

  # return JSON
  JSON.generate(object)

end





# request an api key and mail it to the user
post "/request_api_key" do
  "Requested API key"
end

# random other page
get "/docs" do
  "docs"

  erb :docs
end

# index page
get "/" do
  @instance_var = "Jonas"
  erb :index
end






helpers do
  # def some_stuff_to_help_us
end
