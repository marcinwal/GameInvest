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

use Rack::Flash, :accessorize => [:notice, :error,:asset,:price,:bid,:ask, :user, :side, :user_id]
use Rack::MethodOverride

set :partial_template_engine, :erb
set :public, 'public'

enable :sessions

get '/' do
  # byebug
  response['Access-Control-Allow-Origin'] = '*'   
  Time.now.to_s
  #to allow ajax

  flash[:user_id] = session[:user_id]
  @asset = "EURUSD=X"
  flash[:asset] = @asset
  # flash[:user] = 1
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
   trade = Trade.create(:asset_id => asset_id, :user_id => flash[:user_id], :price => flash[:price],
    :quantity => 1, :side => flash[:side])
   if trade.save
     redirect ('/')
   else
     flash[:errors] = "Failed Trade"
     redirect ('/')
   end


end

post '/sign_up' do
  erb :sign_up
end

post '/newuser' do

  @user = User.create(:email => params[:email],
  :password => params[:password], :password_confirmation => params[:password_confirmation])

  if @user.save
    flash[:user_id] = @user.id
    redirect '/'#erb :index
  else
    flash[:errors] = @user.errors.full_message
    redirect '/'#erb :index
  end
end


post '/login' do
  email,password = params[:email],params[:password]
  user = User.authenticate_email(email,password)
  if !user
    flash[:errors] = ["Wrong email, username or password"]
    redirect '/'
  else
    session[:user_id] = user.id
    flash[:notice] = "Welcome back #{user.email.capitalize}"
    redirect '/'
  end
end
