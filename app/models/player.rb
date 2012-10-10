class Player < ActiveRecord::Base
  attr_accessible :number, :name, :position, :first_cap, :opposition
  has_query_parsing
end
