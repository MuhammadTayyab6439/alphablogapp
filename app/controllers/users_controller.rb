class UsersController < ApplicationController



    def show
        @user=User.find(params[:id])
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user= User.new
    end
    def create
        @user=User.new(params.require(:user).permit(:username,:email,:password))
        if @user.save
            flash[:notice] ="hy #{@user.username} welcome to my app."
            redirect_to articles_path
        else
            render 'new'
        end        
    end
    def edit
        @user=User.find(params[:id])
    end   
    def update
        @user=User.find(params[:id])
        if @user.update(params.require(:user).permit(:username,:email,:password))
            flash[:notice]="User updated successfully.."
            redirect_to users_path
        else
            render 'edit'
        end    
    end
end
