# frozen_string_literal: true

class ProductsController < ApplicationController
  def new
  end

  def import
    result = Products::ImportProductsService.new(params).call!

    if result[:all_save] 
      redirect_to root_path
      flash[:notice]= "Successfully imported all Products"
    else
      redirect_to new_product_path 
      flash[:error] = result[:errors]
    end

  end

  def index
    @products = Products::FetchService.new(params).call!
  end
end
