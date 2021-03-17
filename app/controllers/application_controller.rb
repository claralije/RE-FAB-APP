class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
    # [...]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications_count
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :location, :bio, :school, :average_rating, :photo])
  end

  def after_sign_in_path_for(resource)
    products_path # your path
  end

  def set_notifications_count
    if user_signed_in?
    my_product_deals = Deal.joins(:product).where('products.user_id = ?', current_user.id)
    @notification_count = my_product_deals.where(status: 'pending').count
  else
    @notification_count = 0
  end

  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
