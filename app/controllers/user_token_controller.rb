class UserTokenController < Knock::AuthTokenController
  private

  def authenticate
    if entity.present? && entity.authenticate(auth_params[:password])
      if entity.active
        entity
      else
        render json: { error: 'not_active' }, status: 403
      end
    else
      raise Knock.not_found_exception_class
    end
  end
end
