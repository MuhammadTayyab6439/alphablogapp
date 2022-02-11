class CategoriesController < ApplicationController

    def new 
       @category=Category.new
    end

    def create
        @category=Category.new(params.require(:category).permit(:name))
        if @category.save
            flash[:notice]="category was created successfully..."
            redirect_to @category
        else
            render 'new'
        end
    end
    
    def show

    end

    def index

    end


end
