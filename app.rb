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
post "/api/:uid" do

  api_key = params[:api_key] || "homies"
  annotations = JSON.parse(request.body.read.to_s)
  # TODO
  # verify api_key
  anno = {
    :api_key => api_key,
    :uid => params[:uid],
    :annotations => annotations
  }
  Anno.insert(anno)

  "Ok"
end

# get annotations for object
# get "/:uniqueid", :subdomain => /api/ do
get "/api/:uid" do
  annos = Anno.find({:uid => params[:uid]}).to_a
  "#{annos.inspect}"
  # JSON.generate(annos)
end





# request an api key and mail it to the user
post "/request_api_key" do
  email = params[:email]

  # TODO test email valid
  if email

    # TODO generate API key
    # TODO send out API key
    
    @email_sent = true
    erb :docs
  else
    @form_error = "WRONG! You suck you pathetic failure!"
    erb :index
  end
  

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
