class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @post = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = "Success!!!"
      redirect_to root_path
    else
      flash.now[:error]= "Invalid form"
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @pevent.update(event_params)
        format.html { redirect_to @event, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calendar
  end

  private
    def find_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :body, :category_id, :tags)
    end
end
