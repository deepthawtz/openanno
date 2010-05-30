require "rubygems"
require "uri"
require "mongo"
require "json"
require "pony"
require "koala"

include Koala


if ENV["MONGOHQ_URL"]
  uri = URI.parse(ENV["MONGOHQ_URL"])
  conn = Mongo::Connection.from_uri(ENV["MONGOHQ_URL"])
  db = conn.db(uri.path.gsub(/^\//, ""))
else
  db = Mongo::Connection.new("localhost", Mongo::Connection::DEFAULT_PORT).db("openanno")
end

Anno = db.collection("anno")
User = db.collection("user")

def Anno.all
  Anno.find.to_a
end

def User.all
  User.find.to_a
end

SMTP_OPTIONS = {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'openanno@gmail.com',
    :password             => 'openannotation',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "openanno.com" # the HELO domain provided by the client to the server
}


