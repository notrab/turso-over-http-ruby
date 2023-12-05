#!/usr/bin/env ruby

require 'dotenv'
require_relative '../lib/turso'

Dotenv.load

url = ENV['DATABASE_URL']
authToken = ENV['AUTH_TOKEN']

client = Turso.new(url, authToken)

result = client.execute([
  {
    "q": "INSERT INTO todos (text, completed) VALUES (?, ?)",
    "params": ["Create Ruby example", 1]
  }
])

puts result

result2 = client.execute("SELECT * FROM todos")

puts result2
