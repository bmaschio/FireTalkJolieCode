include "console.iol"
include "string_utils.iol"
include "ImageInterface.iol"
include "file.iol"
include "time.iol"

outputPort ImagePortUCLA {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: ImageInterface
}

outputPort ImagePortMayoCLinic {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: ImageInterface
}

main{

  with (fileReadRequest){
     .filename = "ImageOne.jpg";
     .format = "binary"
   };
   readFile@File(fileReadRequest)(setImageRequest.image);
   setImage@ImagePortUCLA(setImageRequest)(setImageResponseUCLA); 
   //setImage@ImagePortUCLA(setImageRequest)(setImageResponseUCLA) | setImage@ImagePortMayoCLinic(setImageRequest)(setImageResponseMayo);
   valueToPrettyString@StringUtils(setImageResponseUCLA)(s);
   println@Console(s)();
   setImage@ImagePortMayoCLinic(setImageRequest)(setImageResponseMayo);
   valueToPrettyString@StringUtils(setImageResponseUCLA)(s);
   println@Console(s)()
}
