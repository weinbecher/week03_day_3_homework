require ('pg')
require_relative ('../db/sql_runner')
require_relative('artist')

class Albums
  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end


  # Create and Save Albums

  def save()
  sql = "INSERT INTO albums
  (
    title,
    genre,
    artist_id
  )
  VALUES
  (
    $1, $2, $3
  )
  RETURNING id "
  values = [@title, @genre, @artist_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
  end

  # List All Artists/Albums

  def self.all()
  sql = "SELECT * FROM albums;"
  albums = SqlRunner.run(sql)
  return albums.map { |album| Albums.new(album) }
  end


  # Get the artist for a particular album

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run( sql, values )
    artists = results.map { |artist| Artists.new(artist)}
    return artists
  end

  # Find Artists/Albums by their ID

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    albums = results.first
    return albums
  end




  def update()
    sql = "UPDATE albums SET (
      title,
      genre
    ) =

    (
    $1, $2
    )
    WHERE id = $3
    "
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end






 def self.delete_all()
   sql = "DELETE FROM albums"
   SqlRunner.run(sql)
 end









end
