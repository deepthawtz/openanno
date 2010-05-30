$KCODE="utf-8"
%w[ rubygems sinatra setup ].map {|x| require x }

# index page
get "/" do
  erb :index
end

# POST annotation
# POST "/:uniqueid", :subdomain => /api/ do
#
# (RFC DYLAN-1): we could expand this API
# by offering the following url pattern
#
# /api/:namespace-category-src/(:uid)
#
# where: :namespace-category-src is a source
# and :uid is optional
#
# the benefit might be to treat twitter as
# just one annotation source while other sources
# should happen to like to offer annotation-like
# meta-data
# feel free to veto this idea down.
post "/api/:uid" do

  api_key = params[:api_key] || "homies"
  annotations = JSON.parse(request.body.read.to_s)
  # TODO
  # verify api_key
  anno = {
    :api_key => api_key,
    :uid => params[:uid],
    :created_at => Time.now,
    :annotations => annotations
  }
  Anno.insert(anno)
  redirect "/"
end

# get annotations for object
# get "/:uniqueid", :subdomain => /api/ do
get "/api/:uid" do
  annos = Anno.find({:uid => params[:uid]}).to_a

  # TODO: render template with annos Array
  erb :display_anno
  "#{annos.inspect}"
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
  erb :docs
end


get "/stats" do
  # TODO: authenticate admin
  total = Anno.count
  report = []
  Anno.all.each do |anno|
    report << "<li> <a href='/api/#{anno["uid"]}'>#{anno["uid"]}</a> || <span class='date'> <em>#{anno["created_at"]}</em> </span> || <span class='usage'> #usage #standard </span> || </li>"
  end

  erb :stats, :locals => {
    :total => total,
    :report => report
  }
end


helpers do
  # def some_stuff_to_help_us
end

