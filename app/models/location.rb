class Location < ActiveRecord::Base

  attr_accessor :lat, :lng, :address, :range, :number


  validate :address_or_coordinates
  validate :distance_or_best

  def address_or_coordinates
    unless ( lat.present? && lng.present? ) || address.present?
      errors.add(:lat, "can't be blank") if lat.blank?
      errors.add(:lng, "can't be blank") if lng.blank?
      errors.add(:address, "can't be blank") if address.blank?
    end
  end

  def distance_or_best
    unless number.present? || range.present?
      errors.add(:number, "can't be blank") if number.blank?
      errors.add(:range, "can't be blank") if range.blank?
    end
  end

end
