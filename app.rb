require "sinatra/base"
require_relative "config/bootstrap"
require_relative "app/product_fetcher"
require_relative "app/adapters/google_merchant_adapter"

class Feeder < Sinatra::Base
  enable :sessions
  enable :logging
  set :raise_errors, true

  get "/" do
    'OK'
  end

  get "/products.rss" do
    content_type 'text/xml'
    host = request['X-store']
    brand = request.host[/\w+/]
    products = ProductFetcher.new(host, brand).fetch_all
    GoogleMerchantAdapter.new.create_xml(products, brand, host)
  end

end
