class DragonRentalRequest < ActiveRecord::Base
  attr_accessible :dragon_id, :end_date, :start_date, :status
end
