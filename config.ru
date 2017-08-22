#\ --host 0.0.0.0 -E deployment
require 'rubygems'
require 'sinatra'
require 'json'
require 'sequel'
require File.expand_path '../app.rb', __FILE__

run Sinatra::Application