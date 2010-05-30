$KCODE="utf-8"
%w[ rubygems sinatra setup faker digest/sha1 ].map {|x| require x }


get "/" do
  erb :index
end

# POST "/:uid", :subdomain => "api"
post "/api/:uid" do
  api_key = params[:api_key] || "homies"
  annotations = JSON.parse(request.body.read.to_s)

  # show an error if the api_key is invalid
  if !User.find_one(:api_key => api_key)
    status 403
    return "Unknown API Key\n\n"
  end

  # build an annotation and insert it
  anno = {
    :api_key => api_key,
    :uid => params[:uid],
    :created_at => Time.now,
    :annotations => annotations
  }
  Anno.insert(anno)

  "OK\n\n"
end

# get annotations for object
# get "/:uid", :subdomain => /api/ do
get "/api/:uid" do

  # return all annotations in one merged array
  result = { :uid => params[:uid],
             :annotations => Anno.find({:uid => params[:uid]}).to_a.map { |a| a["annotations"] }.flatten }

  "#{result.to_json}\n"
end


# duplicates facebook api and pulls in annotations
# annotations are fb_{fb_uniqueid}
get "/fb/:uid" do
  fb_obj = Facebook::GraphAPI.new().get_object(params[:uid])
  uid = fb_obj["id"] ? "fb_"+fb_obj["id"] : "fb_"+params[:uid]

  # return all annotations in one merged array
  result = { :uid => uid,
             :fb_object => fb_obj,
             :annotations => Anno.find({:uid => uid}).to_a.map { |a| a["annotations"] }.flatten }

  "#{result.to_json}\n"
end




# request an api key and mail it to the user
post "/" do
  email = params[:email]

  # figure out if the email address is legit
  email_regex = %r{^[0-9a-z][0-9a-z.+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z]$}xi
  if email =~ email_regex

    # if the email already exists, delete it
    User.remove :email => email

    # check if already has a key and return old one
    user = User.find_one({:email => params[:email]})
    api_key = user['api_key'] if user and user['email']

    # generate api key
    api_key ||= (Faker::Address.city.gsub(/\s/, '_') + "_" + Faker::Address.city.gsub(/\s/, '_') + "_" + rand(100).to_s).downcase

    # insert api key into MongoDB
    # TODO error checking? whatever ...
    User.insert({:email => email, :api_key => api_key})

    # send out API key
    body = ERB.new(File.new("views/welcome_mail.erb").read).result(binding)
    Pony.mail(:from => "openanno <openanno@gmail.com>",
              :body => body,
              :to => email,
              :subject => "Welcome to openanno!",
              :via => :smtp,
              :via_options => SMTP_OPTIONS)

    # this is used in the docs template to display a flashy banner
    @email_sent = true

    # render the docs page showing a tutorial
    erb :docs
  else
    @form_error = "Please enter a correct email address"
    erb :index
  end
end

get "/add" do
  erb :add
end

# random other page
get "/docs" do
  erb :docs
end

# Admin stuff
get "/stats" do
  # TODO: authenticate admin
  total = Anno.count
  annos = Anno.all.reverse

  # sort by recently modified/added

  erb :stats, :layout => :admin, :locals => {
    :total => total,
    :annos => annos
  }
end

post "/delete/all" do
  Anno.remove({})
end

post "/delete/:uid" do
  # TODO auth
  Anno.remove({"uid" => params[:uid]})
end

helpers do
  # def some_stuff_to_help_us
end

