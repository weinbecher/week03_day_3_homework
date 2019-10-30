require ('pg')
require_relative ('../db/sql_runner')
require_relative('album')

class Artists
  attr_reader :id
  attr_accessor :name


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  # Create and Save Artists

  def save()
    sql = "INSERT INTO artists
    (name)
    VALUES
    ($1)
    RETURNING id;"
    values = [@name]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i
  end


  # List All Artists


  def self.all()
  sql = "SELECT * FROM artists;"
  albums = SqlRunner.run(sql)
  return albums.map { |artist| Artists.new(artist) }
  end


  # List all the albums by an artist

  def albums()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )
    albums = results.map { |album| Albums.new( album) }
    return albums
  end



  def update()
    sql = "UPDATE artists
    SET name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end


  # Delete Artists

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# cant do because the id needs to br album's REFERENCES
  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


# Find Artists by their ID

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    artists = results.first
    return artists
  end






end
