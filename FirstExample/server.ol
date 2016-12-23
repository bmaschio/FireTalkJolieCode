include "console.iol"
include "string_utils.iol"
include "ImageInterface.iol"
include "file.iol"
include "time.iol"
execution{ concurrent }

inputPort serverPort {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: ImageInterface
}

main{

[setImage(request)(response){
  if (is_defined( request.imageName )){
          fileName = "./serverData/"+ request.imageName
  }else{
    getCurrentTimeMillis@Time()(currentTime);
    fileName="./serverData/"+ currentTime +".jpg"
  };
  with (fileWriteRequest){
    .content = request.image;
    .filename = fileName;
    .format = "binary"
  };
  writeFile@File(fileWriteRequest)();
  response.imageName = fileName
  }]
[getImage(request)(response){
      with (fileReadRequest){
         .filename = "./server/"+ request.imageName;
         .format = "binary"
       };
       readFile@File(fileReadRequest)(response.image)
    }]

}
