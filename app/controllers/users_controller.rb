class UsersController < ApplicationController
    before_action :require_user, only: [:edit,:update] 

   # before_action :require_same_user, only: [:edit,:update]

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
        session[:user_id] = @user.id
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
    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all associated articles successfully deleted"
        redirect_to articles_path
      end
    
    
    private
    def require_same_user

        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own account"
            redirect_to users_path
        end
    end
end
