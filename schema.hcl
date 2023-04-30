schema "public" {}
schema "imdb" {}

table "movies" {
    schema = schema.imdb
    column "movie_id" {
        type = int not null
    }
    column "name" {
        type = varchar
    }
    column "certificate" {
        type = varchar
    }
    column "playtime" {
        type = int
    }
    column "release_date" {
        type = date
    }
    column "details" {
        type = varchar
    }

}