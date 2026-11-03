require "http/client"

url = "http://127.0.0.1:8080"

read = File.read("file").to_slice

response = HTTP::Client.post("#{url}/create", body: read)
if response.status_code == 200
  id = response.body
  puts id

  content = HTTP::Client.get("#{url}/check/id")
  puts content.body
end
