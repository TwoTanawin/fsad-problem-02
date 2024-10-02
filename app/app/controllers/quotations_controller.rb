class QuotationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    killed_ids = cookies[:killed_quotations]&.split(' ') || []

    if params[:query].present?
      @quotations = Quotation.joins(:category)
                             .where("LOWER(quotations.quote) LIKE :query OR LOWER(quotations.author_name) LIKE :query", query: "%#{params[:query].downcase}%")
                             .where.not(id: killed_ids)
    else
      @quotations = Quotation.includes(:category).where.not(id: killed_ids)
    end

    respond_to do |format|
      format.html # Renders the default view
      format.json { render json: @quotations }
      format.xml { render xml: @quotations }
    end
  end

  def kill
    killed_ids = cookies[:killed_quotations]&.split(' ') || []
    killed_ids << params[:id] unless killed_ids.include?(params[:id])

    cookies[:killed_quotations] = {
      value: killed_ids.join(' '),
      expires: 1.year.from_now
    }

    redirect_to quotations_path, notice: 'Quotation killed.'
  end

  def erase_personalization
    cookies.delete(:killed_quotations)
    redirect_to quotations_path, notice: 'Personalization erased.'
  end

  def new
    @quotation = Quotation.new
  end

  def show
    @quotation = Quotation.find(params[:id])
    respond_to do |format|
      format.html # Renders the default view
      format.json { render json: @quotations }
      format.xml { render xml: @quotations }
    end
  end


  def create
    if params[:quotation].nil?
      flash[:error] = "Invalid form submission."
      redirect_to new_quotation_path
    else
      if params[:quotation][:new_category].present?
        category = Category.find_or_create_by(name: params[:quotation][:new_category])
      else
        category = Category.find(params[:quotation][:category_id])
      end

      @quotation = Quotation.new(quotation_params.merge(category: category))

      if @quotation.save
        redirect_to quotations_path, notice: 'Quotation was successfully created.'
      else
        render :new
      end
    end
  end

  private

  def quotation_params
    params.require(:quotation).permit(:author_name, :quote)
  end

end
