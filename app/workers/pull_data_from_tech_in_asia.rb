class PullDataFromTechInAsia
  include Sidekiq::Worker

  require 'algolia'

  def perform
    repo        = TechInAsiaRepository.new
    created_job = 0

    jobs = repo.job_postings
    jobs.each do |job|
      if created_job <= 5
        unless Job.exists?(reference_id: job[:objectID])
          company_format  = repo.company_format(job)
          create_company  = CompaniesManager::CreateCompany.new(data: company_format).call
          job_format      = repo.job_format(job)

          created_job += 1 if JobsManager::CreateJob.new(data: job_format, company: create_company).call
        end
      end
    end
  end
end