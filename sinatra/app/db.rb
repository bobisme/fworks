require 'connection_pool'
require 'pg'

module DB
  def self.conn
    @@conn ||= ConnectionPool.new(size: 16, timeout: 5) { PG.connect }
  end

  def with
    conn.with { |conn| yield conn }
  end
end
