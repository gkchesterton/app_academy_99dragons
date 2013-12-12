class DragonRentalRequest < ActiveRecord::Base
  before_validation :set_status_to_pending

  attr_accessible :dragon_id, :end_date, :start_date, :status

  validates :dragon_id, :end_date, :start_date, presence: true
  validates :status, inclusion: %w(APPROVED DENIED PENDING)
  # validate :no_overlap
  validate :start_before_end_date

  belongs_to :dragon

  def approve!
    self.status = "APPROVED"

    other_requests = dragon.dragon_rental_requests
    # other_requests.delete(self)

    ActiveRecord::Base.transaction do
      self.save!
      other_requests.each do |request|
        next if request == self
        request_start = request.start_date
        request_end = request.end_date

        if start_date.between?(request_start, request_end) ||
           end_date.between?(request_start, request_end)
             request.deny!
        end
      end
    end
    other_requests
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  private

  def no_overlap
    dragon.dragon_rental_requests.each do |request|
      request_dates = [request.start_date, request.end_date]
      request_dates.each do |request_date|
        if request_date.between?(start_date, end_date) && request_date.status == "APPROVED"
            errors[:overlaps] << "your dragon is already reserved, dawg"
          return
        end
      end
    end
  end

  def start_before_end_date
    if start_date > end_date
      errors[:start_before_end_date] << "Start date must be before end date"
    end
  end

  def set_status_to_pending
    self.status ||= "PENDING"
  end
end