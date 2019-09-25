require("pry")
require_relative("../models/pizza_order")
require_relative("../models/customer")

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Bob'})
customer1.save()
customer2 = Customer.new({'name' => 'jim'})
customer2.save()

all_customers = Customer.all()

order1 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'topping' => 'cheese',
  'quantity' => 2
  })

  order1.save()

  order2 = PizzaOrder.new({
    'customer_id' => customer1.id,
    'topping' => 'cheese',
    'quantity' => 4
    })
    order2.save
# 
# returned_order = PizzaOrder.find(14)

binding.pry
nil
