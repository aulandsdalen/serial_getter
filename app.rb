require 'csv'

DB = Sequel.connect('sqlite://computers.db')

get '/' do
	computers = DB[:computers].order(Sequel.asc(:added_at)).all
	serials = []
	computers.each do |computer|
		serials << computer[:serial]
	end
	nuserials = serials.select {|e| serials.count(e) > 1}.uniq
	haml :index, :locals => {:computers => computers, :nu => nuserials, :serials => serials}
end

post '/computers/add' do
	# curl -H "Content-Type: text/plain" -d "$serial" http://localhost:9292/computers/add
	t = Time.now
	serial = request.body.read
	logger.info "received serial: #{serial} at #{t}"
	DB[:computers].insert(:serial => serial,
		:added_at => t)
	logger.info "added to database"
end

get '/download' do
	computers = DB[:computers].order(Sequel.asc(:added_at)).all
	CSV.open("computers.csv", "w") { |csv| 
		csv << ["id", "serial number", "added at"]
		computers.each { |c|
			csv << c.values
		}
	}
	send_file "computers.csv", :filename => "computers.csv", :type => "application/csv"
end