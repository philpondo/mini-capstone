require 'http'

response = HTTP.get("http://localhost:3000/api/products")
response = HTTP.patch("http://localhost:3000/api/products/:id")

puts response