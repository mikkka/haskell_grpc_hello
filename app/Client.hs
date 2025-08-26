module Client (main) where

import Network.GRPC.Client
import Network.GRPC.Client.StreamType.IO
import Network.GRPC.Common
import Network.GRPC.Common.Protobuf

import Proto.API.Helloworld

main :: IO ()
main =
    withConnection def server $ \conn -> do
      let req = defMessage & #name .~ "you"
      resp <- nonStreaming conn (rpc @(Protobuf Greeter "sayHello")) req
      print resp
      resp2 <- nonStreaming conn (rpc @(Protobuf Greeter "sayHelloAgain")) req
      print resp2
  where
    server :: Server
    server = ServerInsecure $ Address "127.0.0.1" defaultInsecurePort Nothing
