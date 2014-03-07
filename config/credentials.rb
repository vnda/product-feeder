class ShopCredentialsNotFound < StandardError; end

class Credentials

  def self.shop shop
    raise ShopCredentialsNotFound, "Shop credentials not found for #{shop}" if ENV[shop].nil?
    username, password = ENV[shop].split(':')
    {username: username, password: password}
  end
end
