class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
  end

  def new
    @gram = Gram.new
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end

end
