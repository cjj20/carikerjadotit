# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

company1  = Company.create!(name: "Sunscrapers", image: "https://public.justjoin.it/offers/company_logos/original_x2/fdb4ead4944104451e43b69865aff6398ad43d30.png?1698137026", country: "Berlin", hq_location: "123")
job1      = Job.create!(title: "Team Lead Engineer (on-site)", salary_min: 32000, salary_max: 38000, salary_is_undisclosed: false,
            employment_type: 0, location_type: 0, is_new: true, experience_level: 2, type_of_work: 0, job_description: "Text",
            apply_link: "link", main_technology: "Python", online_interview: true, company_id: company1.id)
job1.tag_names += ["Python", "Golang", "Team Leadership", "AWS", "Docker"]
job1.save

company2  = Company.create!(name: "Lingaro", image: "https://public.justjoin.it/offers/company_logos/original_x2/30764644353fa68f201a068dfed841f4b6895eb3.png?1697534145", country: "krakow", hq_location: "123")
job2      = Job.create!(title: "Data Integration Engineer with GCP", salary_min: 0, salary_max: 0, salary_is_undisclosed: true,
            employment_type: 0, location_type: 2, is_new: true, experience_level: 1, type_of_work: 0, job_description: "Text",
            apply_link: "link", main_technology: "Python", online_interview: true, company_id: company2.id)
job2.tag_names += ["GCP", "SQL", "Python"]
job2.save

company3  = Company.create!(name: "Adverity", image: "https://public.justjoin.it/offers/company_logos/original_x2/d9e98ccd1eba844a04f9ba4b8e6d0f9414d87fe1.png?1697791668", country: "Katowice", hq_location: "123")
job3      = Job.create!(title: "Junior Full Stack Engineer", salary_min: 2900, salary_max: 3750, salary_is_undisclosed: false,
            employment_type: 0, location_type: 0, is_new: true, experience_level: 0, type_of_work: 1, job_description: "Text",
            apply_link: "link", main_technology: "Python", online_interview: true, company_id: company3.id)
job3.tag_names += ["Python", "Golang", "React", "Typescript", "Rest API"]
job3.save

company4  = Company.create!(name: "Fujitsu Technology Solution", image: "https://public.justjoin.it/offers/company_logos/original_x2/9bc6a99b9877a41d625a0e1f2facf85854528488.jpg?1697190866", country: "Warszawa", hq_location: "123")
job4      = Job.create!(title: "IAM Automation Engineer)", salary_min: 0, salary_max: 0, salary_is_undisclosed: true,
            employment_type: 0, location_type: 2, is_new: true, experience_level: 2, type_of_work: 0, job_description: "Text",
            apply_link: "link", main_technology: "Java", online_interview: false, company_id: company4.id)
job4.tag_names += ["Java", "Web Services", "SQL", "BeanShell", "IAM Concepts"]
job4.save

company5  = Company.create!(name: "Intent", image: "https://public.justjoin.it/offers/company_logos/original_x2/e95737b5eecb9ecc33c85643703f922b4d05cf68.png?1697531283", country: "Gdansk", hq_location: "123")
job5      = Job.create!(title: "Junior Flutter Developer", salary_min: 9000, salary_max: 13000, salary_is_undisclosed: false,
            employment_type: 0, location_type: 2, is_new: true, experience_level: 0, type_of_work: 0, job_description: "Text",
            apply_link: "link", main_technology: "Mobile", online_interview: true, company_id: company5.id)
job5.tag_names += ["English", "Flutter", "Dart"]
job5.save