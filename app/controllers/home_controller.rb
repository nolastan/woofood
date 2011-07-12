class HomeController < ApplicationController
  def index
    @items = Item.where(:new => true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
end