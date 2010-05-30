$KCODE="utf-8"
%w[ rubygems sinatra setup ].map {|x| require x }

# index page
get "/" do
  erb :index
end

# POST annotation
# POST "/:uid", :subdomain => "api"
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
# get "/:uid", :subdomain => /api/ do
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


# Admin stuff
get "/stats" do
  # TODO: authenticate admin
  total = Anno.count
  annos = Anno.all

  erb :stats, :layout => :admin, :locals => {
    :total => total,
    :annos => annos
  }
end

post "/delete/:uid" do
  # TODO auth
  Anno.find_one(params[:uid]).delete
end

helpers do
  # def some_stuff_to_help_us
end


