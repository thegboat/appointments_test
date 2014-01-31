module RestHelpers

  def create
    new_resource.save ? render_created : render_failure
  end


  def update
    resource.update_attributes(resource_params) ? render_success : render_failure
  end

  def destroy
    resource.destroy ? render_success : render_failure
  end

  def show
    render_success
  end

  def index
    render_success
  end

  protected

  def resource_params
    respond_to?(:resource_class) ? params[resource_class.to_s.demodulize.underscore] : {}
  end

  def resource
    @resource
  end

  def collection
    @collection
  end

  def new_resource
    @resource = resource_class.new(resource_params)
  end

  def find_one
    return unless respond_to?(:resource_class)
    return unless params[:id]

    @resource = resource_class.find_by_id(params[:id])

    return resource if resource
    render_error(:not_found)
  end

  def find
    @collection = resource_class.all
  end

  def failures
    resource.respond_to?(:errors) ? resource.errors.full_messages : []
  end

  def failure_message
    failures.to_sentence
  end

  private

  def render_success
    render :status => :ok, :json => success_json
  end

  def render_created
    render :status => :created, :json => success_json
  end

  def render_error(error_type)
    error_type = :bad_request if not error_type.is_a?(Symbol)
    render :status => error_type, :json => {
      :error => error_type,
      :error_description => I18n.translate(error_type, :scope => [:response, :errors, :messages])
    }
  end

  def render_failure
    render :status => :unprocessable_entity, :json => {
      :error => :unprocessable_entity,
      :error_description => failures
    }
  end

  def success_json
    collection ? collection.to_json : resource.to_json
  end
end