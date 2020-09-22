class Work < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :type_id,     numericality: { other_than: 1, message: "is invalid" }
    validates :name
    validates :genre_id,    numericality: { other_than: 1, message: "is invalid" }
    validates :place
    validates :start_time,  if: :past_date_time
    validates :end_time,    if: :past_start_time
    validates :description
    validates :user
  end

  private
  def past_date_time
    if start_time < Time.current
      errors.add(:start_time, "is valid")
    end
  end

  def past_start_time
    if end_time < start_time || end_time < Time.current
      errors.add(:end_time, "is valid") 
    end
  end


end
