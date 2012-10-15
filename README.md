# validates_belongs_to [![Build Status](https://secure.travis-ci.org/Arjeno/validates_belongs_to.png?branch=master)](http://travis-ci.org/Arjeno/validates_belongs_to)

This is a simple validator which validates an association belongs to the same owner.

## Example code

```ruby
class User < ActiveRecord::Base
  has_many :warehouses
  has_many :cars
end

class Warehouse < ActiveRecord::Base
  has_many :cars
  belongs_to :user
end

class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :warehouse
  validates :warehouse, :belongs_to => :user
end

user = User.create
warehouse = user.warehouses.create

user_2 = User.create
warehouse_2 = user_2.warehouses.create

car = warehouse.cars.create # Works fine

car.warehouse = warehouse_2
car.save! # Validation failed: Warehouse does not belong to user
```