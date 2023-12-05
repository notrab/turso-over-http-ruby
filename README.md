# Turso over HTTP (Ruby)

## Usage

Create the file `.env` with the following contents:

```bash
DATABASE_URL=https://[DATABASE_HOSTNAME]
AUTH_TOKEN=
```

Then run:

```bash
ruby bin/run.rb
```

## Using the `Turso` client

```ruby
result = client.execute([
  {
    "q": "INSERT INTO todos (text, completed) VALUES (?, ?)",
    "params": ["Create Ruby example", 1]
  }
])

puts result

result2 = client.execute("SELECT * FROM todos")

puts result2
```
