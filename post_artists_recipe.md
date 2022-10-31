# POST /artists Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  
method: POST
path: /artists
body params:    name=Wild nothing
                genre=Indie

  

## 2. Design the Response

response = (200 OK)
response = ('')
```

## 3. Write Examples

```
# Request:

POST /artists

# Expected response:

Response for 200 OK
Response = ('')
```

## 4. Encode as Tests Examples

```ruby
context "POST /artists" do
    it 'receives an artist entry and returns 200 OK' do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie' )
      expect(response.status).to eq(200)
      expect(response.body).to eq ('')
     end
  end

  it 'adds entry to artists database, returns 200 OK and matches artist'
      response = post('/artists', name: 'Wild nothing', genre: 'Indie' )
      result = get(/albums)
      expect(response.status).to eq(200)
      expect(result.body).to include 'Wild Nothing'
   end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
