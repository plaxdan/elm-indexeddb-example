port module Services.Storage
    exposing
        ( saveArray
        , saveRecord
        , saveTuple
        )


type alias Key =
    String


type alias Value =
    String


type alias QuestionTuple =
    ( Key, Value )


type alias QuestionRecord =
    { key : String
    , value :
        { question : String
        , answer : String
        }
    }


type alias QuestionArray =
    { key : String
    , value : List String
    }


port saveArray : QuestionArray -> Cmd msg


port saveRecord : QuestionRecord -> Cmd msg


port saveTuple : QuestionTuple -> Cmd msg
