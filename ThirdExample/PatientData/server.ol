include "console.iol"
include "string_utils.iol"
include "../public/interfaces/PatientDataInterface.iol"
include "database.iol"
include "file.iol"
include "time.iol"

inputPort serverPort {
  Location: "socket://localhost:8002"
  Protocol: sodep
  Interfaces: PatientDataInterface , PatientDataReadInterface
}
execution{ concurrent}
init {
  scope( connectioScope )
  {
    install ( default=>  valueToPrettyString@StringUtils(connectioScope)(s);
              println@Console(s)());

  with (connectionInfo) {
    .host="localhost";
    .port= 5432;
    .driver = "postgresql";
    .database= "PatientData";
    .username="postgres";
    .password= "postgres"
  };

  connect@Database( connectionInfo )( void )
}
}


main{
[insertPatientImageData(request)(response){
  scope( insertPatientScope )
  {
   install (default=>  valueToPrettyString@StringUtils(insertPatientScope)(s);
             println@Console(s)());
      q << request;
      q= "insert into patient_image (  patient_id , image_name, image_type, exam_id, image_xpos, image_ypos ) values ( :patientId, :imageName , :imageType, :examId, :imageXpos,:imageYpos)";
      valueToPrettyString@StringUtils(q)(s);
      println@Console(s)();
      update@Database(q)()
 }


}]
[readPatientImageData(request)(response){
  scope( readPatientScope )
  {
   install (default=>  valueToPrettyString@StringUtils(readPatientScope)(s);
             println@Console(s)());

      if ( is_defined( request.patientId )){
        q = "select * from public.patient_image where patient_id = :patientId order by exam_id ";
        q.patientId = request.patientId
      };

      if ( is_defined( request.examId )){
        q = "select * from public.patient_image where exam_id = :examId";
        q.examId = request.examId
      };

      valueToPrettyString@StringUtils(q)(s);
      println@Console(s)();
      query@Database(q)(responseQ);
      valueToPrettyString@StringUtils(responseQ)(s);
      println@Console(s)();
     for (counterImage =0 , counterImage<#responseQ.row , counterImage++){
         with (response.image[counterImage]){
                .patientId = responseQ.row[counterImage].patient_id;
                .examId = responseQ.row[counterImage].exam_id;
                .imageName = responseQ.row[counterImage].image_name;
                .imageType = responseQ.row[counterImage].image_type;
                .imageXpos = responseQ.row[counterImage].image_xpos;
                .imageYpos = responseQ.row[counterImage].image_ypos
         }

     }
 }

}]

}
