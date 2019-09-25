require('pg')
require_relative('../models/customer')

class PizzaOrder
  attr_accessor :topping, :quantity, :customer_id
  attr_reader :id

  attr_accessor :first_name, :last_name, :topping, :quantity
  attr_reader :id

  def initialize(options)

    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO pizza_orders
    (

      topping,
      quantity,
      customer_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@topping, @quantity, @customer_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i


  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    results = SqlRunner.run(sql, values)[0]
    return Customer.new(results)
  end

  def update()
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "
    UPDATE pizza_orders SET (
      topping,
      quantity
      customer_id
    ) =
    (
      $1,$2, $3
    )
    WHERE id = $4"
    values = [@topping, @quantity, @id, @customer_id]
    SqlRunner.run(sql, values)

  end

  def delete()
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  #   db.prepare("delete", sql)
  #   db.exec_prepared("delete", values)
  #   db.close()
  end

  def self.find(id)

    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    order_hash = results[0]
    order = PizzaOrder.new(order_hash)
    return order
  end


  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
  end

  def self.all()
    # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "SELECT * FROM pizza_orders"
    orders_hashes = SqlRunner.run(sql)
    orders =  orders_hashes.map { |order| PizzaOrder.new(order) }
    return orders
  end

end
