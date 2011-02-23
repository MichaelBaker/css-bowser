require "sinatra"

get "/" do
  File.open "public/index.html" do |file|
    file.read
  end
end