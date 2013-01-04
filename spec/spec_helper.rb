require 'active_record'
require 'validates_belongs_to'
require 'shoulda/matchers'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                        :database => File.dirname(__FILE__) + "/validates_belongs_to.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'