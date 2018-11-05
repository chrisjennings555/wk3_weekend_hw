require_relative("../db/sqlrunner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    SqlRunner.run(sql)
  end

  def customer_at_film()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN films
    ON tickets.film_id = films.id
    WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new(customer)}
  end

  def customer_funds_and_price_of_film
    sql = "SELECT customers.funds, films.price FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN films
    ON tickets.film_id = films.id
    WHERE films.id = $1"
    values = (@id)
    result = SqlRunner.run(sql, values)
    p result
  end

end
