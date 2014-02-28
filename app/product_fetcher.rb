require_relative "api"

class ProductFetcher

  def initialize(host, store)
    @host = host
    @credentials = Credentials.shop store
    self
  end

  def fetch_all
    API.get(@host, "/v2/products", @credentials)
  end

end
