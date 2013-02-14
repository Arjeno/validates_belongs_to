class User < ActiveRecord::Base
  has_many :warehouses
  has_many :cars
end

class Warehouse < ActiveRecord::Base
  has_many :cars
  has_and_belongs_to_many :shared_cars
  belongs_to :user
end

class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :warehouse
  validates :warehouse, :belongs_to => :user
end

class SharedCar < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :warehouses
  validates :warehouses, :belongs_to => :user
end