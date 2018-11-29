class HomeController < ApplicationController
  def index

  end

  def team

  end

  def research

  end

  def publications
    @papers = Paper.all.order("pubdate DESC")
  end

  def jobs
    @jobs = Job.all
  end
end
