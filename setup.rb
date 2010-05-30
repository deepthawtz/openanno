require "rubygems"
require "uri"
require "mongo"
require "json"
require "pony"

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
