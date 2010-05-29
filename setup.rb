ENV["MONGOHQ_URL"] ||= "localhost"

require "uri"
require "mongo"

uri = URI.parse(ENV["MONGOHQ_URL"])
conn = Mongo::Connection.new(ENV["MONGOHQ_URL"], Mongo::Connection::DEFAULT_PORT)
db = conn.db(uri.path.gsub(/^\//, ""))