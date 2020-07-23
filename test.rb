require_relative 'swop_client'
require 'date'

swop_client = SwopClient.new("<your-swop-api-key>")


# fetch single rates
puts "single rate for EUR/USD for today"
puts swop_client.single_rate("EUR", "USD")

puts "single rate for EUR/USD for 21th July of 2020"
puts swop_client.single_rate("EUR", "USD", date: Date.new(2020, 07, 21))


# timeseries
puts "timeseries one week"
puts swop_client.timeseries(Date.new(2020, 07, 14), Date.new(2020, 07, 21))

puts "timeseries one week - with base currency USD"
puts swop_client.timeseries(Date.new(2020, 07, 14), Date.new(2020, 07, 21), base: "USD")

puts "timeseries one week - with base currency USD and target currencies GBP, EUR"
puts swop_client.timeseries(Date.new(2020, 07, 14), Date.new(2020, 07, 21), base: "USD", targets: ["GBP", "EUR"])
