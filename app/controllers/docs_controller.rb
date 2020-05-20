class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.where(user_id: current_user)
    # .all.order("created_at DESC")
  end

  # Responsible for view file
  def show
  end

  def new 
    @doc = current_user.docs.build
  end

  def create
    @doc = current_user.docs.build(doc_params)

    if @doc.save
      redirect_to @doc 
    else 
      # not redirect as redirect refreshes the page, losing the content
      render "new"
    end

  end 

  # Responsible for view file
  def edit
  end 

  # Fetches doc and change parameter
  def update 
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render "edit"
    end
  end

  def destroy
    @doc.destroy 
    redirect_to docs_path
  end

  private

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end

end
