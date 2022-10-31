# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # BEFORE CHANGING:
  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all

  #   response = albums.map do |album|
  #     album.title
  #   end.join(', ')

  #   return response
  # end
  get '/' do
    return erb(:index)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/add_album' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:add_album)
  end

  post '/albums' do
    if invalid_request_params?
        status 400
        return ''
    end
    
    repo = AlbumRepository.new

    @new_album = Album.new
    @new_album.title = params[:title]
    @new_album.release_year = params[:release_year]
    @new_album.artist_id = params[:artist_id]

    repo.create(@new_album)
    return erb(:post_albums)
  end
  
  # post '/albums' do
  #   # if invalid_request_params?
  #   #     status 400
  #   #     return ''
  #   # end
  #   repo = AlbumRepository.new
  #   artist_repo = ArtistRepository.new
  #   artist = artist_repo.find_by_artist(params[:artist_select])
  #   input_id = artist.id

  #   @new_album = Album.new
  #   @new_album.title = params[:title]
  #   @new_album.release_year = params[:release_year]
  #   @new_album.artist_id = input_id

  #   repo.create(@new_album)
  #   return erb(:post_albums)
  # end


  # get '/artists' do
  #   repo = ArtistRepository.new
  #   artists = repo.all

  #   response = artists.map do |artist|
  #     artist.name
  #   end.join(', ')

  #   return response
  # end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get '/artists/:id' do
    artist_repo = ArtistRepository.new

    @artist = artist_repo.find(params[:id])

    return erb(:artist)
  end

  get '/add_artist' do
    return erb(:add_artist)
  end

  post '/artists' do
    repo = ArtistRepository.new

    @new_artist = Artist.new
    @new_artist.name = params[:name]
    @new_artist.genre = params[:genre]
    
    repo.create(@new_artist)
    return erb(:post_artists)
  end

  get '/posts' do
    return erb(:posts)
  end

  def invalid_request_params?
    return (params[:title] == nil || 
      params[:release_year] == nil ||
      params[:artist_id] == nil)
  end


 

end