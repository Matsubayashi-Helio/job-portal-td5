class HomeController < ApplicationController
    def index
    end

    def search
        @search = params[:q]
        @companies = Company.where('name like ?', "#{params[:q]}")

        @jobs = Job.where('title like ?', "#{params[:q]}")
    end
end