require 'bundler/setup'

require 'sinatra'
require 'haml'

require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-observer'


APP_DIR = File.expand_path(File.dirname(__FILE__))
PUBLIC_DIR = File.join(APP_DIR, 'public')
MODELS_DIR = File.join(APP_DIR, 'models')

require File.join(MODELS_DIR, 'player.rb')
require File.join(MODELS_DIR, 'challenge.rb')

set :public, PUBLIC_DIR


##### Latter: A Table Tennis Ladder ############

I18N = {
  :record_not_found => "Record not found",
  :record_not_saved => "Record could not be saved. Please check data and try again."
}

######### Configuration #########
configure :test do
  DataMapper.setup(:default, "sqlite3::memory")
  DataMapper.auto_upgrade!
end

configure do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/latter.db.sqlite3")
  DataMapper.auto_upgrade!
end

before '/player*' do
  authenticate!
end

before '/challenge*' do
  authenticate!
end


get '/' do
  redirect '/players' if @current_player
  haml :"auth/login"
end

post '/login' do
  @current_player = Player.first(:email => params[:email])
  @current_player ? redirect('/players') : haml(:"auth/login")
end

get '/logout' do
  session[:player_id] = nil
end

get '/players' do
  @players = Player.all.sort { |a, b| a.total_wins <=> b.total_wins }
  haml :"players/index"
end

get '/player/:id' do
  @player = Player.get(params[:id])
  not_found?(@player)
  
  haml :"players/show"
end

get '/player/new' do
  haml :"players/new"
end

get '/player/edit' do
  haml :"players/edit"
end

post '/player' do
  @player = Player.create(params[:player])
  @player.saved? ? redirect("/player/#{@player.id}") : error(400, I18N[:record_not_saved])
end

post '/player/:id' do
  @player = Player.get(params[:id])
  not_found?(@player)
  
  updated = @player.update! params[:player]
  updated ? redirect("/player/#{params[:id]}") : error(400, I18N[:record_not_saved])
end

post '/player/:id/delete' do
  @player = Player.get(params[:id])
  not_found?(@player)
  
  @player.destroy
  redirect '/players'
end

get '/challenges' do
  @challenges = Challenge.all
  haml :"challenges/index"
end


get '/challenge/new' do
  haml :"challenges/new"
end

get '/challenge/edit' do
  haml :"challenges/edit"
end

get '/challenge/:id/:from_id/vs/:to_id' do
  @challenge = Challenge.get(params[:id])
  not_found?(@challenge)
  
  haml :"challenges/show"  
end

post '/challenge' do
  @challenge = Challenge.new
  @challenge.from_player = Player.get(params[:challenge][:from_player_id])
  @challenge.to_player = Player.get(params[:challenge][:to_player_id])
  @challenge.completed = false
  @challenge.save ? redirect('/challenges') : redirect('/challenges/new')  
end

post '/challenge/:id/update' do
  @challenge = Challenge.get(params[:id])
  not_found?(@challenge)
  
  @challenge.completed? ? (error(400, I18N[:challenge_can_only_be_updated_once])) : nil
  
  @challenge.winner = Player.get(params[:challenge][:winner_id])
  @challenge.score = params[:challenge][:score]
  @challenge.completed = true
  challenge_updated = @challenge.save
  challenge_updated ? redirect('/challenges') : redirect('/challenges/edit')
end

def not_found?(object)
  error(404, I18N[:record_not_found]) unless object
end

def authenticate!
  @current_player = Player.get(session[:player_id])
  redirect '/' unless @current_player
end
  
