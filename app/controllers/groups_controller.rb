class GroupsController < ApplicationController
    before_action :unauthorized_redirect
    after_action :verify_authorized

    def index
        authorize Group, :index?
        @groups = Group.all
    end

    def show
        @group= Group.find(params[:id])
        authorize @group

        if current_user.teacher
            render :teacher_view_group
        end
    end

    def new
        authorize Group, :new?
    end

    def create
        authorize Group, :create?
        @group = current_user.taught_classes.build(group_params)
        @group.save()

        redirect_to group_path(@group)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def group_params
        params.require(:group).permit(:name, :teacher)
    end
    
end