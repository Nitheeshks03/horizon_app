# frozen_string_literal: true

class Category < ApplicationRecord
  #associations
  has_many :products
end
