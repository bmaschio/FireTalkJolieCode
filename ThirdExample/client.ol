include "console.iol"
include "string_utils.iol"
include "./public/interfaces/OrchestratorInterface.iol"
include "./public/interfaces/PatientDataInterface.iol"
include "file.iol"
include "time.iol"


outputPort OrchestrationPort {
  Location: "socket://localhost:8003"
  Protocol: sodep
  Interfaces: OrchestratorInterface, PatientDataReadInterface
}

main{

  with (fileReadRequest){
     .filename = "ImageOne.jpg";
     .format = "binary"
   };
   readFile@File(fileReadRequest)(createPatientImageRequest.image);

   createPatientImageRequest.imageXpos = 0.0000;
   createPatientImageRequest.imageYpos = 0.0001;
   createPatientImageRequest.imageType = "CT";
   createPatientImageRequest.patientId = "MASBAL01";
   createPatientImageRequest.examId    = "CT001";

   createPatientImage@OrchestrationPort(createPatientImageRequest)(createPatientImageResponse);

   readPatientImageDataRequest.examId    = "CT001";
   readPatientImageData@OrchestrationPort(readPatientImageDataRequest)(readPatientImageDataResponse);
   valueToPrettyString@StringUtils(readPatientImageDataResponse)(s);
   println@Console(s)()




 }
