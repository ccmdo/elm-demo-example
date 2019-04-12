module Character exposing (Character, fetch, level, name)

import Api
import Api.Endpoint as Endpoint
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom, required)


type Character
    = Character CharacterData


type alias CharacterData =
    { id : Int
    , level : Int
    , name : String
    }


level : Character -> Int
level (Character data) =
    data.level


name : Character -> String
name (Character data) =
    data.name ++ "#" ++ String.fromInt data.id


fetch : String -> Http.Request Character
fetch characterName =
    Decode.field "character" decoder
        |> Api.get (Endpoint.character characterName)


decoder : Decoder Character
decoder =
    Decode.succeed Character
        |> custom dataDecoder


dataDecoder : Decoder CharacterData
dataDecoder =
    Decode.succeed CharacterData
        |> required "id" Decode.int
        |> required "level" Decode.int
        |> required "name" Decode.string
