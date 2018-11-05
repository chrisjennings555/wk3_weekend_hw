require_relative("../db/sqlrunner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    SqlRunner.run(sql)
  end

  def films_watched_by_customer()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    INNER JOIN customers
    ON tickets.customer_id = customers.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map {|film| Film.new(film)}

  end

  def price_of_film_watched_by_customer()
    film_cost = self.films_watched_by_customer
    result = film_cost.map {|film| film.price}
    return result[0].to_i
  end

  def customer_pays_for_film
    p @funds.to_i - self.price_of_film_watched_by_customer
  end
end
