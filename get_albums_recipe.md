# GET /albums Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  
method: GET
path: /albums

  

## 2. Design the Response

response = (200 OK)
#List of albums:
Doolittle
Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring
```

## 3. Write Examples

```
# Request:

GET /albums

expect response = (200 OK)
expect albums:
Doolittle
Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring
# Expected response:

Response for 200 OK

```

## 4. Encode as Tests Examples

```ruby
context "POST /albums" do
    it 'returns 200 OK' do
      response = post('/albums', title: "Voyage", release_year: 2022, artist_id: 2)
      expect(response.status).to eq(200)
     end
  end

  it 'returns an added album'
     response = post('/albums', title: "Voyage", release_year: 2022, artist_id: 2)
      expect(response.status).to eq(200)
      expect
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
