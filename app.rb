get '/' do
	haml :index
end

get '/computers/:serial' do
	# display info
end

post '/computers/add' do
	# add computer s/n to db
end