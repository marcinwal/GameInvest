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

use Rack::Flash, :accessorize => [:notice, :error,:asset,:price,:bid,:ask, :user, :side]
use Rack::MethodOverride

set :partial_template_engine, :erb
set :public, 'public'

enable :sessions

get '/' do
  @asset = "EURUSD=X"
  flash[:asset] = @asset
  flash[:user] = 1
  price = get_quote(@asset)
  @bid,@ask = price.bid,price.ask
  flash[:bid],flash[:ask] = @bid,@ask
  @last_trade_price = price.last_trade_price
  erb :index
end

post '/' do
   flash[:side] = params.first[0]
   flash[:price] = flash[:side] == "sell" ? flash[:bid] : flash[:ask]
   flash[:notice] = "You just did a #{flash[:side]} of #{flash[:asset]} at #{flash[:price]}."
   # flash[:notice] = "You just sold #{flash[:asset]} at #{flash[:bid]}." if params.first[0] == "sell"
   # byebug
   asset_id = Asset.first(:name => flash[:asset]).id
   trade = Trade.create(:asset_id => asset_id, :user_id => flash[:user], :price => flash[:price],
    :quantity => 1, :side => flash[:side])
   if trade.save
     redirect ('/')
   else
     flash[:errors] = "Failed Trade"
     redirect ('/')
   end


end
