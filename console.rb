require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

require("pry-byebug")

Customer.delete_all
Film.delete_all
Ticket.delete_all


customer1 = Customer.new('name' => 'Chris', 'funds' => '50')
customer2 = Customer.new('name' => 'Kate', 'funds' => '60')
customer3 = Customer.new('name' => 'Mike', 'funds' => '50')
customer4 = Customer.new('name' => 'Rose', 'funds' => '60')

customer1.save
customer2.save
customer3.save
customer4.save

film1 = Film.new('title' => 'Harry Potter', 'price' => '10')
film2 = Film.new('title' => 'Taxi', 'price' => '9')
film3 = Film.new('title' => 'Showman', 'price' => '12')
film4 = Film.new('title' => 'Star', 'price' => '11')

film1.save
film2.save
film3.save
film4.save

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id)
ticket3 = Ticket.new('customer_id' => customer3.id, 'film_id' => film3.id)
ticket4 = Ticket.new('customer_id' => customer4.id, 'film_id' => film4.id)


ticket1.save
ticket2.save
ticket3.save
ticket4.save

# customer1.delete
#
# film2.delete
# film1.title = ('HBP')
# film1.update
# Film.all
# customer1.customer_pays_for_film
# nil
# customer1.name = ('Bill')
# customer1.update

film1.customer_funds_and_price_of_film
