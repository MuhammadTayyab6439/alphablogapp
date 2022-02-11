class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in

    def current_user
        #get the user on base of session which is saved during creation of user in users_controller
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
    
      def logged_in?
        !!current_user #convert it into bolean
      end

end
