require'json'



res = JSON.parse '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}';

puts res['desc']['someKey']