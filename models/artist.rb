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

  def update()
    sql = "UPDATE artists
    SET name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end









end
