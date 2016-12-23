type InsertPatientImageDataRequest:void{
  .patientId:string
  .imageName:string
  .imageType:string
  .examId:string
  .imageYpos:double
  .imageXpos:double
}

type InsertPatientImageDataResponse:void


type ReadPatientImageDataRequest :void{
    .patientId?:string
    .examId?:string
}
type ReadPatientImageDataResponse:void{
    .image*:void{
      .patientId:string
      .imageName:string
      .imageType:string
      .examId:string
      .imageYpos:double
      .imageXpos:double
    }
}
interface PatientDataInterface {
RequestResponse:
insertPatientImageData(InsertPatientImageDataRequest )(InsertPatientImageDataResponse)

}

interface PatientDataReadInterface {
RequestResponse:
readPatientImageData(ReadPatientImageDataRequest )(ReadPatientImageDataResponse)

}
