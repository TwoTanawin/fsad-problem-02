class QuotationsController < ApplicationController
  require "open-uri"
  require "nokogiri"

  skip_before_action :verify_authenticity_token

  def index
    @killed_ids = cookies[:killed_quotations]&.split(" ") || []

    if params[:query].present?
      @quotations = Quotation.joins(:category)
                             .where("LOWER(quotations.quote) LIKE :query OR LOWER(quotations.author_name) LIKE :query",
                                    query: "%#{params[:query].downcase}%")
                             .where.not(id: @killed_ids)
    else
      @quotations = Quotation.includes(:category).where.not(id: @killed_ids)
    end

    respond_to do |format|
      format.html # Renders the default view
      format.json { render json: @quotations }
      format.xml { render xml: @quotations }
    end
  end

  def kill
    killed_ids = cookies[:killed_quotations]&.split(" ") || []

    unless killed_ids.include?(params[:id])
      killed_ids << params[:id]
      cookies[:killed_quotations] = {
        value: killed_ids.join(" "),
        expires: 1.year.from_now
      }
      flash[:notice] = "Quotation hidden successfully."
    end

    redirect_back(fallback_location: quotations_path)
  end

  def erase_personalization
    cookies.delete(:killed_quotations)
    redirect_to quotations_path, notice: "Personalization erased successfully. All quotations are now visible."
  end

  def new
    @quotation = Quotation.new
    @disable_new_category = false
    @disable_existing_category = false
  end

  def show
    @quotation = Quotation.find(params[:id])
    respond_to do |format|
      format.html # Renders the default view
      format.json { render json: @quotation }
      format.xml { render xml: @quotation }
    end
  end

  def create
    if params[:quotation].nil?
      flash[:error] = "Invalid form submission."
      redirect_to new_quotation_path
    else
      if params[:quotation][:new_category].present?
        category = Category.find_or_create_by(name: params[:quotation][:new_category])
        @disable_existing_category = true
        @disable_new_category = false
      else
        category = Category.find(params[:quotation][:category_id])
        @disable_existing_category = false
        @disable_new_category = true
      end

      @quotation = Quotation.new(quotation_params.merge(category: category))

      if @quotation.save
        redirect_to quotations_path, notice: "Quotation was successfully created."
      else
        render :new
      end
    end
  end

  def import
    url = params[:import_url]

    if url.present?
      begin
        xml_data = URI.open(url).read
        doc = Nokogiri::XML(xml_data)

        doc.xpath("//quotation").each do |quotation_node|
          author_name = quotation_node.at_xpath("author_name").content
          quote = quotation_node.at_xpath("quote").content
          category_name = quotation_node.at_xpath("category/name").content

          category = Category.find_or_create_by(name: category_name)
          Quotation.create(author_name: author_name, quote: quote, category: category)
        end

        flash[:notice] = "Quotations imported successfully."
      rescue => e
        flash[:alert] = "Failed to import quotations. Error: #{e.message}"
      end
    else
      flash[:alert] = "Please provide a valid URL."
    end

    @quotations = Quotation.includes(:category) # Reload quotations to reflect the new entries
    render :index
  end

  private

  def quotation_params
    params.require(:quotation).permit(:author_name, :quote)
  end
end
