# validates_belongs_to [![Build Status](https://secure.travis-ci.org/Arjeno/validates_belongs_to.png?branch=master)](http://travis-ci.org/Arjeno/validates_belongs_to)

Validate your associations to ensure they belong to the same owner. Also works for `has_and_belongs_to_many` associations.

## Usage

Add to your Gemfile:

```ruby
gem 'validates_belongs_to'
```

Add the validator to your model:

```ruby
class Car < ActiveRecord::Base
  validates :warehouse, :belongs_to => :user
  # or you can use validates_belongs_to :warehouse, :user
end
```

## Example code: belongs_to

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

Car.create :warehouse => warehouse # Works fine
Car.create :warehouse => warehouse_2 # Validation failed: Warehouse does not belong to user
```

## Example code: has_and_belongs_to_many


```ruby
class User < ActiveRecord::Base
  has_many :warehouses
  has_many :cars
end

class Warehouse < ActiveRecord::Base
  has_many :cars
  belongs_to :user
  has_and_belongs_to_many :cars
end

class Car < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :warehouses
  validates :warehouses, :belongs_to => :user
end

user = User.create
warehouse = user.warehouses.create

user_2 = User.create
warehouse_2 = user_2.warehouses.create

Car.create :warehouses => [warehouse] # Works fine
Car.create :warehouses => [warehouse_2] # Warehouses do not belong to user
```