$KCODE="utf-8"
%w[ rubygems sinatra setup ].map {|x| require x }

before do
  @redis = Redis.new
end

get "/" do
  "some stuff"
end

post "/" do
  stuff = params[:word]
  junk = params[:answer]

 # some stuff
end



helpers do
  # def some_stuff_to_help_us
end
