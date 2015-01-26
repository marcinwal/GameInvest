env = ENV["RACK_ENV"] || 'development'

require './app/models/user'
require './app/models/trade'
require './app/models/asset'

DataMapper.setup(:default, "postgres://localhost/game_invest_#{env}")
DataMapper.finalize
