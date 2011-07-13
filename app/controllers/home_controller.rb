class HomeController < ApplicationController
  def index
    @date = Item.last.last #Date was being buggy
    @items = Item.where(:special => true)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end
end