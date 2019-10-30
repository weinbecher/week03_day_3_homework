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
 #
 #
 # def self.delete_all()
 #   sql = "DELETE FROM albums"
 # end





end
