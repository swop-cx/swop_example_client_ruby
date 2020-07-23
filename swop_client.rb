require 'rubygems'
require 'bundler/setup'
require 'httparty'

class SwopClient
  include HTTParty
  base_uri 'https://swop.cx/rest'

  def initialize(api_key)
    @options = { headers: {"Authorization" => "ApiKey #{api_key}"} }
  end

  def single_rate(base_currency, quote_currency, date: nil)

    query_params = build_query_params(Hash.new.tap do |qp|
      qp[:date] = date.iso8601 if date
    end)

    self.class.get("/rates/#{base_currency}/#{quote_currency}#{query_params}", @options)
  end

  def timeseries(from_date, to_date, base: nil, targets: nil, include_meta: nil)
    return if from_date.nil?
    return if to_date.nil?

    query_params = build_query_params(Hash.new.tap do |qp|
      qp[:start] = from_date.iso8601
      qp[:end] = to_date.iso8601
      qp[:base] = base if base
      qp[:targets] = targets.join(',') if targets
      qp[:meta] = include_meta if include_meta
    end)

    self.class.get("/timeseries#{query_params}", @options)
  end

  private

  def build_query_params(query_params)
    "?#{query_params.map{|k, v| "#{k}=#{v}"}.join("&")}" if query_params.size > 0
  end
end
