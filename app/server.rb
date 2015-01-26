require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require 'mailgun'

require 'byebug'

set :partial_template_engine, :erb
set :public, 'public'