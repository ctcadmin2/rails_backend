class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  private

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def page_number(params) # TODO improve
    if params
      if params[:number]
        params[:number]
      else
        1
      end
    else
      1
    end
  end

  def page_size(params) # TODO improve
    if params
      if params[:size]
        params[:size]
      else
        5
      end
    else
      5
    end
  end

  def sorted_list(param) # TODO improve
    params = param.split(',')
    sort_list = ''
    for  i in (0...params.count)
      if params[i][0] == '-'
        sort_list += "#{params[i][1..-1]} DESC"
      else
        sort_list += "#{params[i]}"
      end
      if i < params.count - 1
        sort_list += ', '
      end
    end
    sort_list
  end
end
