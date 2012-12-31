# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.delete_all
User.delete_all

admin1 = User.create(name:'admin1', email:'admin1@manager.com',
 password:'admin1', type: 'Admin')

admin2 = User.create(name:'admin2', email:'admin2@manager.com',
 password:'admin2', type: 'Admin')

member1 = User.create(name:'member1', email:'member1@manager.com',
 password:'member1', type: 'Member')

member2 = User.create(name:'member2', email:'member2@manager.com',
 password:'member2', type: 'Member')

p1 = Project.create(name:'project1', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin1.id)

p2 = Project.create(name:'project2', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin1.id)

p3 = Project.create(name:'project3', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin1.id)

p4 = Project.create(name:'project4', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin1.id)

p5 = Project.create(name:'project5', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin2.id)

p6 = Project.create(name:'project6', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin2.id)

p7 = Project.create(name:'project7', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin2.id)

p8 = Project.create(name:'project8', start_date:'2012-1-1',
	, end_date:'2012-12-31', creator_id: admin2.id)

p2.parent = p1
p4.parent = p3
p6.parent = p5
p8.parent = p7

r11 = p1.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r12 = p1.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r13 = p1.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r21 = p2.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r22 = p2.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r23 = p2.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r31 = p3.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r32 = p3.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r33 = p3.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')


r41 = p4.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r42 = p4.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r43 = p4.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r51 = p5.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r52 = p5.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r53 = p5.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r61 = p6.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r62 = p6.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r63 = p6.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r71 = p7.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r72 = p7.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r73 = p7.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')

r81 = p8.releases.build(version:'release 1', start_date:'2012-1-1',
	, end_date:'2012-4-30')
r82 = p8.releases.build(version:'release 2', start_date:'2012-5-1',
	, end_date:'2012-8-31')
r83 = p8.releases.build(version:'release 3', start_date:'2012-9-1',
	, end_date:'2012-12-31')