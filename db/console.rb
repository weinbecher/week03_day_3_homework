require("pry")
require_relative("../models/artist")
require_relative("../models/album")

# Albums.delete_all

artist1 = Artists.new(
  {'name' => 'Bob Marley'}
)
artist1.save

album1 = Albums.new(
  {'title' => 'Redemption Song',
   'genre' => 'reggae',
   'artist_id' => artist1.id
  })

album1.save

binding.pry
nil
