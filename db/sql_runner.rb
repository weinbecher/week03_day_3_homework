require ('pg')

class SqlRunner
  def self.run( sql, values = [] )
    # if not using the argument here, use the defaut empty array.
    begin
      db = PG.connect({ dbname: 'collection', host: 'localhost' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end
end
