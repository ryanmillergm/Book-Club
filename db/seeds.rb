# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@michaelcrighton = Author.create(name: "Michael Crichton")
@raybradbury = Author.create(name: "Ray Bradbury")
@gorevidal = Author.create(name: "Gore Vidal")
@johnsteinbeck = Author.create(name: "John Steinbeck")

@user_1 = User.create(name: "James999")
@user_2 = User.create(name: "Samantha326")
@user_3 = User.create(name: "Liz@NY")
@user_4 = User.create(name: "Hector123")
@user_5 = User.create(name: "Johnny555")


@sphere = Book.create(title: "Sphere", pages: 345, year_published: 1987, book_img_url: "https://upload.wikimedia.org/wikipedia/en/b/b8/Big-sphere.jpg")
@sphere_review_1 = @sphere.reviews.create(title: "Sphere_Review_1", rating: 3, text: "Review 1 description")
@sphere_review_2 = @sphere.reviews.create(title: "Sphere_Review_2", rating: 5, text: "Review 2 description")
@user_1.reviews << @sphere_review_1
@user_2.reviews << @sphere_review_2
@michaelcrighton.books << @sphere


@jurassicpark = Book.create(title: "Jurassic Park", pages: 400, year_published: 1990, book_img_url: "https://upload.wikimedia.org/wikipedia/en/3/33/Jurassicpark.jpg")
@jurassicpark_review_1 = @jurassicpark.reviews.create(title: "JurassicPark_Review_1", rating: 2, text: "Review 1 description")
@jurassicpark_review_2 = @jurassicpark.reviews.create(title: "JurassicPark_Review_2", rating: 1, text: "Review 2 description")
@jurassicpark_review_3 = @jurassicpark.reviews.create(title: "JurassicPark_Review_3", rating: 1, text: "Review 3 description")
@jurassicpark_review_4 = @jurassicpark.reviews.create(title: "JurassicPark_Review_4", rating: 2, text: "Review 4 description")
@jurassicpark_review_5 = @jurassicpark.reviews.create(title: "JurassicPark_Review_5", rating: 3, text: "Review 5 description")
@user_1.reviews << @jurassicpark_review_1
@user_2.reviews << @jurassicpark_review_2
@user_3.reviews << @jurassicpark_review_3
@user_4.reviews << @jurassicpark_review_4
@user_5.reviews << @jurassicpark_review_5
@michaelcrighton.books << @jurassicpark


@risingson = Book.create(title: "Rising Son", pages: 385, year_published: 1992, book_img_url: "https://upload.wikimedia.org/wikipedia/en/1/15/Big-risingsun.jpg")
@risingson_review_1 = @risingson.reviews.create(title: "RisingSon_review_1", rating: 4, text: "Review 1 description")
@risingson_review_2 = @risingson.reviews.create(title: "RisingSon_review_2", rating: 5, text: "Review 2 description")
@risingson_review_3 = @risingson.reviews.create(title: "RisingSon_review_3", rating: 2, text: "Review 3 description")
@risingson_review_4 = @risingson.reviews.create(title: "RisingSon_review_4", rating: 4, text: "Review 4 description")
@user_1.reviews << @risingson_review_1
@user_2.reviews << @risingson_review_2
@user_3.reviews << @risingson_review_3
@user_4.reviews << @risingson_review_4
@michaelcrighton.books << @risingson

@fahrenheit451 = Book.create(title: "Fahrenheit 451", pages: 158, year_published: 1953, book_img_url: "https://upload.wikimedia.org/wikipedia/en/d/db/Fahrenheit_451_1st_ed_cover.jpg")
@fahrenheit451_review_1 = @fahrenheit451.reviews.create(title: "Fahrenheit451_review_1", rating: 5, text: "Review 1 description")
@fahrenheit451_review_2 = @fahrenheit451.reviews.create(title: "Fahrenheit451_review_2", rating: 2, text: "Review 2 description")
@fahrenheit451_review_3 = @fahrenheit451.reviews.create(title: "Fahrenheit451_review_3", rating: 4, text: "Review 3 description")
@user_1.reviews << @fahrenheit451_review_1
@user_2.reviews << @fahrenheit451_review_2
@user_3.reviews << @fahrenheit451_review_3
@raybradbury.books << @fahrenheit451

@creation = Book.create(title: "Creation", pages: 510, year_published: 1981, book_img_url: "https://upload.wikimedia.org/wikipedia/en/9/91/Creation.JPG")
@creation_review_1 = @creation.reviews.create(title: "Creation_review_1", rating: 2, text: "Review 1 description")
@creation_review_2 = @creation.reviews.create(title: "Creation_review_2", rating: 1, text: "Review 2 description")
@creation_review_3 = @creation.reviews.create(title: "Creation_review_3", rating: 3, text: "Review 3 description")
@creation_review_4 = @creation.reviews.create(title: "Creation_review_4", rating: 2, text: "Review 4 description")
@creation_review_5 = @creation.reviews.create(title: "Creation_review_5", rating: 1, text: "Review 5 description")
@creation_review_6 = @creation.reviews.create(title: "Creation_review_6", rating: 3, text: "Review 6 description")
@creation_review_7 = @creation.reviews.create(title: "Creation_review_7", rating: 2, text: "Review 7 description")
@creation_review_8 = @creation.reviews.create(title: "Creation_review_8", rating: 1, text: "Review 8 description")
@user_1.reviews << @creation_review_1
@user_2.reviews << @creation_review_2
@user_3.reviews << @creation_review_3
@user_4.reviews << @creation_review_4
@user_5.reviews << @creation_review_5
@user_3.reviews << @creation_review_6
@user_4.reviews << @creation_review_7
@user_5.reviews << @creation_review_8
@gorevidal.books << @creation


@lincoln = Book.create(title: "Lincoln", pages: 1984, year_published: 1984, book_img_url: "https://upload.wikimedia.org/wikipedia/commons/1/17/LincolnNovel.jpg")
@lincoln_review_1 = @lincoln.reviews.create(title: "Lincoln_review_1", rating: 5, text: "Review 1 description")
@lincoln_review_2 = @lincoln.reviews.create(title: "Lincoln_review_2", rating: 3, text: "Review 2 description")
@lincoln_review_3 = @lincoln.reviews.create(title: "Lincoln_review_3", rating: 4, text: "Review 3 description")
@lincoln_review_4 = @lincoln.reviews.create(title: "Lincoln_review_4", rating: 3, text: "Review 4 description")
@lincoln_review_5 = @lincoln.reviews.create(title: "Lincoln_review_5", rating: 2, text: "Review 5 description")
@lincoln_review_6 = @lincoln.reviews.create(title: "Lincoln_review_6", rating: 3, text: "Review 6 description")
@lincoln_review_7 = @lincoln.reviews.create(title: "Lincoln_review_7", rating: 1, text: "Review 7 description")
@lincoln_review_8 = @lincoln.reviews.create(title: "Lincoln_review_8", rating: 1, text: "Review 8 description")
@lincoln_review_9 = @lincoln.reviews.create(title: "Lincoln_review_9", rating: 5, text: "Review 9 description")
@user_1.reviews << @lincoln_review_1
@user_2.reviews << @lincoln_review_2
@user_3.reviews << @lincoln_review_3
@user_4.reviews << @lincoln_review_4
@user_5.reviews << @lincoln_review_5
@user_2.reviews << @lincoln_review_6
@user_3.reviews << @lincoln_review_7
@user_4.reviews << @lincoln_review_8
@user_5.reviews << @lincoln_review_9
@gorevidal.books << @lincoln


@canneryrow = Book.create(title: "Cannery Row", pages: 208, year_published: 1945, book_img_url: "https://images-na.ssl-images-amazon.com/images/I/41sK2DL-t7L._SX290_BO1,204,203,200_.jpg")
@canneryrow_review_1 = @canneryrow.reviews.create(title: "CanneryRow_review_1", rating: 1, text: "Review 1 description")
@canneryrow_review_2 = @canneryrow.reviews.create(title: "CanneryRow_review_2", rating: 3, text: "Review 2 description")
@canneryrow_review_3 = @canneryrow.reviews.create(title: "CanneryRow_review_3", rating: 4, text: "Review 3 description")
@canneryrow_review_4 = @canneryrow.reviews.create(title: "CanneryRow_review_4", rating: 2, text: "Review 4 description")
@canneryrow_review_5 = @canneryrow.reviews.create(title: "CanneryRow_review_5", rating: 2, text: "Review 5 description")
@canneryrow_review_6 = @canneryrow.reviews.create(title: "CanneryRow_review_6", rating: 1, text: "Review 6 description")
@canneryrow_review_7 = @canneryrow.reviews.create(title: "CanneryRow_review_7", rating: 3, text: "Review 7 description")
@canneryrow_review_8 = @canneryrow.reviews.create(title: "CanneryRow_review_8", rating: 4, text: "Review 8 description")
@canneryrow_review_9 = @canneryrow.reviews.create(title: "CanneryRow_review_9", rating: 2, text: "Review 9 description")
@canneryrow_review_10 = @canneryrow.reviews.create(title: "CanneryRow_review_10", rating: 2, text: "Review 10 description")
@user_1.reviews << @canneryrow_review_1
@user_2.reviews << @canneryrow_review_2
@user_3.reviews << @canneryrow_review_3
@user_4.reviews << @canneryrow_review_4
@user_5.reviews << @canneryrow_review_5
@user_1.reviews << @canneryrow_review_6
@user_2.reviews << @canneryrow_review_7
@user_3.reviews << @canneryrow_review_8
@user_4.reviews << @canneryrow_review_9
@user_5.reviews << @canneryrow_review_10
@johnsteinbeck.books << @canneryrow


@grapesofwrath = Book.create(title: "The Grapes of Wrath", pages: 464, year_published: 1939, book_img_url: "https://images-na.ssl-images-amazon.com/images/I/51zdzn8cO3L._SX323_BO1,204,203,200_.jpg")
@grapesofwrath_review_1 = @grapesofwrath.reviews.create(title: "CanneryRow_review_1", rating: 1, text: "Review 1 description")
@grapesofwrath_review_2 = @grapesofwrath.reviews.create(title: "CanneryRow_review_2", rating: 3, text: "Review 2 description")
@grapesofwrath_review_3 = @grapesofwrath.reviews.create(title: "CanneryRow_review_3", rating: 4, text: "Review 3 description")
@grapesofwrath_review_4 = @grapesofwrath.reviews.create(title: "CanneryRow_review_4", rating: 2, text: "Review 4 description")
@grapesofwrath_review_5 = @grapesofwrath.reviews.create(title: "CanneryRow_review_5", rating: 2, text: "Review 5 description")
@grapesofwrath_review_6 = @grapesofwrath.reviews.create(title: "CanneryRow_review_6", rating: 2, text: "Review 6 description")
@grapesofwrath_review_7 = @grapesofwrath.reviews.create(title: "CanneryRow_review_7", rating: 3, text: "Review 7 description")
@user_1.reviews << @grapesofwrath_review_1
@user_2.reviews << @grapesofwrath_review_2
@user_3.reviews << @grapesofwrath_review_3
@user_4.reviews << @grapesofwrath_review_4
@user_5.reviews << @grapesofwrath_review_5
@user_1.reviews << @grapesofwrath_review_6
@user_2.reviews << @grapesofwrath_review_7
@johnsteinbeck.books << @grapesofwrath
