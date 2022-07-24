(1..100).each do |number|
  Task.create(status: 'test st ' + number.to_s, content: 'test content ' + number.to_s)
end