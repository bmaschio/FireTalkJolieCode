
type CreatePatientImageRequest:void{
    .patientId:string
    .image:raw
    .imageType:string
    .examId:string
    .imageYpos:double
    .imageXpos:double
}

type CreatePatientImageResponse:void

interface OrchestratorInterface {
RequestResponse:
 createPatientImage(CreatePatientImageRequest)(CreatePatientImageResponse)
}
