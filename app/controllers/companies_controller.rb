class CompaniesController < ApplicationController
    def index
        @companies = Company.all
    end

    def show
        @company = Company.find(params[:id])
    end

    def company_jobs
        @company_jobs = Company.find(params[:id])
    end
end