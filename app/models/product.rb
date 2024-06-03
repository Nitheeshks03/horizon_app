# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
end
