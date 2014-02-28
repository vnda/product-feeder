require 'yaml'

STORES = YAML.load(File.read("config/api_keys.yml")).freeze
