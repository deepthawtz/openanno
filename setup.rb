require 'json'


#begin
#  require "mongo"; include Mongo
#rescue LoadError
#  puts "You need the mongo gem\nTry: gem install mongo\n"
#  exit(1)
#end
#
#begin
#  db = Connection.new("localhost", Connection::DEFAULT_PORT).db("openanno")
#  Anno = db.collection("anno")
#  AnnoAdd = db.collection("annoadd")  # { "anno_id" : "anno_user" } where anno_user is the last to modify
#  User = db.collection("user")
#rescue Mongo::ConnectionFailure
#  puts "Make sure MongoDB daemon (mongod) is running\nTry: mongod\n"
#  exit(1)
#end


# some harmless extensions to the mongo ruby client lib that i like
#def Anno.all
#  Vocabulary.find.to_a
#end
#
#def Anno.empty?
#  (Vocabulary.count == 0 ? true : false)
#end
# 
