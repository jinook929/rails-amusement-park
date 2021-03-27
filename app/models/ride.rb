class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  validates :user_id, presence: true
  validates :attraction_id, presence: true

  def take_ride
    if !enough_tickets || !tall_enough
      message = "Sorry."
      if !enough_tickets
        message.concat(" You do not have enough tickets to ride the #{self.attraction.name}.") 
      end
      if !tall_enough
        message.concat(" You are not tall enough to ride the #{self.attraction.name}.") 
      end
    end

    if enough_tickets && tall_enough
      # self.user.update(tickets: (self.user.tickets - self.attraction.tickets), happiness: (self.user.happiness + self.attraction.happiness_rating), nausea: (self.user.nausea + self.attraction.nausea_rating))
      self.user.tickets -= self.attraction.tickets
      self.user.happiness += self.attraction.happiness_rating
      self.user.nausea += self.attraction.nausea_rating
      self.user.save
    end
    message if message.present?
  end

  private

  def enough_tickets
    self.user.tickets >= self.attraction.tickets
  end

  def tall_enough
    self.user.height >= self.attraction.min_height
  end
end
