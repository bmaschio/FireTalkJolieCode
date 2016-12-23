include "console.iol"
include "string_utils.iol"
include "ImageInterface.iol"
include "file.iol"
include "time.iol"

outputPort ImagePort {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: ImageInterface
}

main{

  with (fileReadRequest){
     .filename = "ImageOne.jpg";
     .format = "binary"
   };
   readFile@File(fileReadRequest)(setImageRequest.image);
   setImage@ImagePort(setImageRequest)(setImageResponse);
   valueToPrettyString@StringUtils(setImageResponse)(s);
   println@Console(s)()
}
