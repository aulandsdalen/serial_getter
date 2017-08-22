DB = Sequel.connect('sqlite://computers.db')

get '/' do
	computers = DB[:computers].order(Sequel.desc(:added_at)).all
	haml :index, :locals => {:computers => computers}
end

get '/computers/:serial' do
	# display info
end

post '/computers/add' do
	t = Time.now
	serial = request.body.read
	logger.info "received serial: #{serial} at #{t}"
	DB[:computers].insert(:serial => serial,
		:added_at => t)
	logger.info "added to database"
end