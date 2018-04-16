require_relative '../db'
require_relative '../models/artist'

module ArtistRepo
  TABLE = 'artists'.freeze

  NotFound = Class.new(RuntimeError)

  def self.get_by_id(id)
    DB.conn.with do |conn|
      res = conn.exec_params("SELECT * FROM #{TABLE} WHERE id=$1", [id])
      raise NotFound if res.size == 0
      row = res.fetch(0)
      Artist.new(id: row.fetch('id'), name: row.fetch('name'))
    end
  end

  def self.all
    DB.conn.with do |conn|
      conn.exec("select * from #{TABLE}").map do |row|
        Artist.new(id: row.fetch('id'), name: row.fetch('name'))
      end
    end
  end

  def self.create(artist)
    DB.conn.with do |conn|
      res = conn.exec_params(
        "INSERT INTO #{TABLE} (name) VALUES ($1) RETURNING id", [artist.name]
      )
      res[0]['id']
    end
  end
end
