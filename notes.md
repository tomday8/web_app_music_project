<!-- Example for GET /albums/1 -->

<html>
  <head></head>
  <body>
    <h1>Doolittle</h1>
    <p>
      Release year: 1989
      Artist: Pixies
    </p>
  </body>
</html>

<!-- Example for GET /albums/2 -->

<html>
  <head></head>
  <body>
    <h1>Surfer Rosa</h1>
    <p>
      Release year: 1988
      Artist: Pixies
    </p>
  </body>
</html>


# GET /albums/:id Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  
method: GET
path: /albums/:id
path param: :id = id number

  

## 2. Design the Response

response = (200 OK)
response = ('album_name', 'release_year', 'artist_name')
```

## 3. Write Examples

```
# Request:

GET /albums/1
Response: 200 OK
Response: 'Doolittle', 1989, 'Pixies'



GET /albums/2
Response: 200 OK
Response: 'Surfer Rosa', 1988, 'Pixies'

## 4. Encode as Tests Examples

```ruby
context "GET /albums" do
    it 'gets first album and returns 200 OK' do
      response = get('/albums/1')
      expect(response.status).to eq(200)
    end

    it 'verifies first album details and returns 200 OK' do
      response = get('/albums/1')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Doolittle</h1>')
    end
  end

 
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
