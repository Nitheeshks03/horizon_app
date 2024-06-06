# frozen_string_literal: true

class ProductsController < ApplicationController
  def new
  end

  def import
    @products = Products::ImportProductsService.new(params).call!

    if @products.all?(&:save)
      redirect_to root_path
      flash[:notice] = "You have successfully imported #{@products.length} products."
    else
      flash[:error] = "Product import failed"
    end
  end

  def index
    @products = Products::FetchService.new(params).call!
  end
end
