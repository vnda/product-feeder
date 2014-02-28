class Credentials

  def self.shop shop
    raise StandardError, 'Shop credentials not found' if ENV[shop].nil?
    username, password = ENV[shop].split(':')
    {username: username, password: password}
  end
end
