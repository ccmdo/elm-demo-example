module Api exposing (get)

import Api.Endpoint as Endpoint exposing (Endpoint)
import Http
import Json.Decode as Decode exposing (Decoder)


get : Endpoint -> Decoder a -> Http.Request a
get url decoder =
    Endpoint.request
        { method = "GET"
        , url = url
        , expect = Http.expectJson decoder
        , headers = []
        , body = Http.emptyBody
        , timeout = Nothing
        , withCredentials = False
        }
