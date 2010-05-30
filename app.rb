$KCODE="utf-8"
%w[ rubygems sinatra setup faker digest/sha1 ].map {|x| require x }


get "/" do
  erb :index
end


# POST "/:uid", :subdomain => "api"
post "/api/:uid" do
  validate_api_key(params[:api_key])
  annotations = JSON.parse(request.body.read.to_s)

  anno = {
    :api_key => api_key,
    :uid => params[:uid],
    :created_at => Time.now,
    :annotations => annotations
  }
  Anno.insert(anno)

  "OK\n\n"
end

post "/manualpost" do

  if !User.find_one(:api_key => params[:api_key])
     @api_key_error = true

     erb :add, :layout => :form
 else
  annotations = process_from_post(params["type"])

  anno = {
    :api_key => params[:api_key],
    :uid => params["obj_name"],
    :created_at => Time.now,
    :annotations => annotations
  }
  Anno.insert(anno)

  "OK\n\n"
  end
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
  erb :add, :layout => :form
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

  # process some annotations

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
  # annos_type = [
  #   {"id" => "movies",
  #     "names" => ["name1", "name2"],
  #     "values" => ["value1", "value2"]
  #     },
  #   {"id" => "event",
  #       "names" => ["event_field"],
  #       "values" => ["some_event_field_value"]
  #   }
  # ]
  def process_from_post(annos_type)
    result = []
    annos_type.each do |_,anno|
      p "Working on type #{anno["id"]}"
      set = {}
      anno["names"].each_with_index do |key,idx|
        p "Key=#{key} Idx=#{idx}"
        set[key] = anno["values"][idx]

      end
      p set
      result << { anno["id"] => set}
    end
    return result
  end

  def validate_api_key(api_key)
    if !User.find_one(:api_key => api_key)
      status 403
      return "Unknown API Key\n\n"
    end
  end
end

