require "spec_helper"
require "rack/test"
require_relative '../../app'

DatabaseConnection.connect

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  context "GET /albums" do
    # xit 'returns a list of albums' do
    #   response = get('/albums')

    #   expected_response =  'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

    #   expect(response.status).to eq(200)
    #   expect(response.body).to eq(expected_response)
    # end

    it 'returns a list of albums' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include 'Doolittle'
      expect(response.body).to include 'Waterloo'
      expect(response.body).to include 'Lover'
      expect(response.body).to include 'Here Comes the Sun'
    end

    it 'links to an albums individual page' do
      response = get('/albums')
      expect(response.body).to include 
      ('<a href="/albums/2">Go to this albums page</a>')
      expect(response.body).to include 
      ('<a href="/albums/4">Go to this albums page</a>')
      expect(response.body).to include 
      ('<a href="/albums/8">Go to this albums page</a>')
    end
  end

  context "POST /albums" do
    it 'returns 200 OK' do
      response = post(
        '/albums', 
        title: "Voyage", 
        release_year: 2022, 
        artist_id: 2
      )
      expect(response.status).to eq(200)
      expect(response.body).to include ('You saved album:')
    end

    it 'validates parameters and returns 400 if incorrect' do
      response = post(
        '/albums',
        invalid_artist_title: 'OK Computer',
        another_invalid_thing: 123
      )
      expect(response.status).to eq(400)
    end

    it 'adds album to database' do
      response = post(
        '/albums', 
        title: "Voyage", 
        release_year: 2022, 
        artist_id: 2
      )
      result = get('/albums')
      expect(response.status).to eq(200)
      expect(result.body).to include('Voyage')
    end
  end
  
  context "GET /artists" do
    it 'intially can returns 200 OK' do
      response = get('/artists')
      expect(response.status).to eq(200)
    end
  
    it 'returns 200 OK and a list of artist' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include 'Pixies'
      expect(response.body).to include 'ABBA' 
      expect(response.body).to include 'Taylor Swift' 
      expect(response.body).to include 'Nina Simone'
    end

    it 'links to an artists individual page' do
      response = get('/artists')
      expect(response.body).to include 
      ('<a href="/artists/1"></a>')
      expect(response.body).to include 
      ('<a href="/artists/2"></a>')
      expect(response.body).to include 
      ('<a href="/artists/3"></a>')
      expect(response.body).to include 
      ('<a href="/artists/4"></a>')
    end
  end

  context "POST /artists" do
    it 'receives an artist entry and returns 200 OK' do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie' )
      expect(response.status).to eq(200)
      expect(response.body).to include ('You saved artist:')
     end
  

  it 'adds entry to artists database, returns 200 OK and matches artist' do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie' )
      result = get('/artists')
      expect(response.status).to eq(200)
      expect(result.body).to include 'Wild Nothing'
   end
  end

  context 'GET /albums/:id' do
    it 'returns info about album at index 1' do
      response = get('/albums/1')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Doolittle</h1>')
      expect(response.body).to include ('Release year: 1989')
      expect(response.body).to include ('Artist: Pixies')
    end

    it 'returns info about album at index 2' do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Surfer Rosa</h1>')
      expect(response.body).to include ('Release year: 1988')
      expect(response.body).to include ('Artist: Pixies')
    end
  end

  context 'GET /artists/:id' do
    it 'returns info about artist at index 1' do
      response = get('/artists/1')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Pixies</h1>')
      expect(response.body).to include ('Genre: Rock')
    end

    it 'returns info about artist at index 2' do
      response = get('/artists/2')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>ABBA</h1>')
      expect(response.body).to include ('Genre: Pop')
    end
  end

  context 'GET /add_album' do
    it 'returns status 200' do
      response = get('/add_album')
      expect(response.status).to eq(200)
    end

    it 'gets a form and displays to user' do
      response = get('/add_album')
      expect(response.status).to eq(200)
      expect(response.body).to include ('form action="/albums" method="POST"')
      expect(response.body).to include ('<input type="text" name="title">')
      expect(response.body).to include ('<input type="text" name="release_year">')
      expect(response.body).to include ('<input type="text" name="artist_id">')
    end
  end


  context 'GET /add_artist' do
    it 'returns status 200' do
      response = get('/add_artist')
      expect(response.status).to eq(200)
    end

    it 'gets a form and displays to user' do
      response = get('/add_artist')
      expect(response.status).to eq(200)
      expect(response.body).to include 'form action="/artists" method="POST"'
      expect(response.body).to include ('<input type="text" name="name">')
      expect(response.body).to include ('<input type="text" name="genre">')
    end
  end

end
