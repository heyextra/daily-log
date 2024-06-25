class TipsController < ApplicationController
        include HasDate
      
        def new
          @entry = Tip.new
        end
      
        def create
          @entry = Tip.new(entry_params)
          if @entry.save
            redirect_to day_path(@entry.occurred_on), notice: "Added Tip"
          else
            render :new, status: :unprocessable_entity
          end
        end
      
        def edit
          @entry = current_user.tips.find(params[:id])
        end
      
        def update
          @entry = current_user.tips.find(params[:id])
          if @entry.update(entry_params)
            redirect_to day_path(@entry.occurred_on), notice: "Updated Tip"
          else
            render :new, status: :unprocessable_entity
          end
        end

        def destroy
            @entry = current_user.tips.find(params[:id])
            @entry_date = @entry.occurred_on
            @entry.destroy
            flash[:success] = "Tip deleted"
            redirect_to day_path(@entry_date)
          end
      
        private
      
        def entry_params
          params.require(:tip).permit(:total_amount, :split, :personal_payout, :occurred_on, :location)
            .merge(user: current_user)
        end
      
end
