class SearchController < ApplicationController
  def search
    query = Riddle::Query.escape(params[:q])
    @results = ThinkingSphinx.search(query)
  end
end
