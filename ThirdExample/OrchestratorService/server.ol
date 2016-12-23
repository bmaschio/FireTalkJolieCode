include "console.iol"
include "string_utils.iol"
include "../public/interfaces/OrchestratorInterface.iol"
include "../public/interfaces/ImageInterface.iol"
include "../public/interfaces/PatientDataInterface.iol"
include "file.iol"
include "time.iol"
execution{ concurrent }



outputPort ImagePortPet {
  Location: "socket://localhost:8000"
  Protocol: sodep
  Interfaces: ImageInterface
}

outputPort ImagePortCT {
  Location: "socket://localhost:8001"
  Protocol: sodep
  Interfaces: ImageInterface
}

outputPort PatientData {
  Location: "socket://localhost:8002"
  Protocol: sodep
  Interfaces: PatientDataInterface
}

outputPort PatientReadData {
  Location: "socket://localhost:8002"
  Protocol: sodep
  Interfaces: PatientDataReadInterface
}

inputPort serverPort {
  Location: "socket://localhost:8003"
  Protocol: sodep
  Interfaces: OrchestratorInterface
  Aggregates: PatientReadData
}

inputPort serverPortHttp {
  Location: "socket://localhost:8004"
  Protocol: http{
    .format -> format;
    .contentType -> mime
  }
  Interfaces: OrchestratorInterface
  Aggregates: PatientReadData
}

main{

[createPatientImage(request)(response){


   setImageRequest.image = request.image;

   if (request.imageType == "PET"){
      setImage@ImagePortPet(setImageRequest)(setImageResponse)
   };

   if (request.imageType == "CT"){
      setImage@ImagePortCT(setImageRequest)(setImageResponse)
   };

   valueToPrettyString@StringUtils(setImageResponse)(s);
    println@Console(s)();

   insertPatientImageDataRequest.patientId = request.patientId;
   insertPatientImageDataRequest.imageType = request.imageType;
   insertPatientImageDataRequest.imageName = setImageResponse.imageName;
   insertPatientImageDataRequest.examId    = request.examId;
   insertPatientImageDataRequest.imageXpos = request.imageXpos;
   insertPatientImageDataRequest.imageYpos = request.imageYpos;
   valueToPrettyString@StringUtils(insertPatientImageDataRequest)(s);
   println@Console(s)();
   insertPatientImageData@PatientData(insertPatientImageDataRequest)()

  }]


}
