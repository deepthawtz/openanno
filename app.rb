$KCODE="utf-8"
%w[ rubygems sinatra setup ].map {|x| require x }

# putting this in setup.rb doesn't work for some reason
smtp_options = {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'openanno@gmail.com',
    :password             => 'openannotation',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "openanno.com" # the HELO domain provided by the client to the server
}


# index page
get "/" do
  erb :index
end

# POST annotation
# POST "/:uid", :subdomain => "api"
post "/api/:uid" do

  api_key = params[:api_key] || "homies"

  annotations = JSON.parse(request.body.read.to_s)

  # show an error if the api_key is invalid
  if !User.find_one(:api_key => api_key)
    status 403
    return "Unknown API Key"
  end


  # build an annotation and insert it
  anno = {
    :api_key => api_key,
    :uid => params[:uid],
    :created_at => Time.now,
    :annotations => annotations
  }
  Anno.insert(anno)

  "Ok"
end

# get annotations for object
# get "/:uid", :subdomain => /api/ do
get "/api/:uid" do

  # return all annotations in one merged array
  result = { :uid => params[:uid],
             :annotations => Anno.find({:uid => params[:uid]}).to_a.map { |a| a["annotations"] }.flatten }

  result.to_json

end





# request an api key and mail it to the user
post "/" do
  email = params[:email]

  # figure out if the email address is legit
  email_regex = %r{^[0-9a-z][0-9a-z.+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z]$}xi
  if email =~ email_regex

    # if the email already exists, delete it
    User.remove :email => email

    # generate API key
    require "digest/sha1"
    api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..16]

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
              :via_options => smtp_options)

    # this is used in the docs template to display a flashy banner
    @email_sent = true

    # render the docs page showing a tutorial
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
