require 'socket'

def main()
	print "Host: "
	host = gets.chomp
	print "Port min:  "
	min_port = gets.chomp.to_i
	print "Port max: "
	max_port = gets.chomp.to_i
	if min_port > max_port
		print "min port can't be bigger max port"
	else
		scanport(host, min_port, max_port)
	end
end

def scanport(host, min_port, max_port)
	num = max_port - min_port
	File.new("logs/#{host}.txt", "w")
	loop do
		begin
			socket = TCPSocket.new(host, min_port)
			status = "Open"
		rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
			status = "Timeout"
		end
		print "SCAN PORT: #{min_port}\n"

		File.open("logs/#{host}.txt", "a") { |f| f << "#{min_port} | #{status}\n" }
		if min_port == max_port
			system("cls")
			print "Scan #{num} port"
			exit
		end
		min_port += 1
	end
end

begin
	main()
rescue Interrupt
	puts "\nCtrl + C"
	puts "\nExiting..."
end