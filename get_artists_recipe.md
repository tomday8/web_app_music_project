# GET /artists Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  
method: GET
path: /artists

  

## 2. Design the Response

response = (200 OK)
#List of artists
response = 'Pixies, ABBA, Taylor Swift, Nina Simone'
```

## 3. Write Examples

```
# Request:

GET /artists

# Expected response:

Response for 200 OK
Response = 'Pixies, ABBA, Taylor Swift, Nina Simone'
```

## 4. Encode as Tests Examples

```ruby
context "GET /artists" do
    it 'intially can returns 200 OK' do
      response = get('/artists')
      expect(response.status).to eq(200)
     end
  end

  it 'returns 200 OK and a list of artist'
     response = get('/artists'
      expect(response.status).to eq(200)
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone'
   end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
