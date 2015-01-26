require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'mailgun'
require 'yahoo_finance'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'


require 'byebug'

use Rack::Flash, :accessorize => [:notice, :error,:asset,:price,:bid,:ask]
use Rack::MethodOverride

set :partial_template_engine, :erb
set :public, 'public'

enable :sessions

get '/' do
  @asset = "EURUSD=X"
  flash[:asset] = @asset
  price = get_quote(@asset)
  @bid,@ask = price.bid,price.ask
  flash[:bid],flash[:ask] = @bid,@ask
  @last_trade_price = price.last_trade_price
  erb :index
end

post '/' do
   flash[:notice] = "You just bought #{flash[:asset]} at #{flash[:ask]}." if params.first[0] == 'buy'
   flash[:notice] = "You just sold #{flash[:asset]} at #{flash[:bid]}." if params.first[0] == "sell"
   redirect ('/')
end
