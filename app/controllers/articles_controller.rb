class ArticlesController < ApplicationController
  def index
    @articles = [{title: 'And amazing article'}] * 10
  end
end
