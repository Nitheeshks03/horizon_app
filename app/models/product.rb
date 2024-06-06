# frozen_string_literal: true

class Product < ApplicationRecord
  #validations
  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true

  #associations
  belongs_to :category
end
