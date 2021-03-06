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
    begin
      content_type 'text/xml'
      host = request.env['HTTP_X_STORE']
      store = host.match(/[w\.]*(\w+).*/)[1]
      products = ProductFetcher.new(host, store).fetch_all
      GoogleMerchantAdapter.new.create_xml(products, store, host).encode("UTF-8")
    rescue ShopCredentialsNotFound => ex
      content_type 'text/html'
      status 403
      ex.message
    rescue => ex
      content_type 'text/html'
      status 500
      ex.message + "\n" + ex.backtrace.join("\n")
    end
  end

end
