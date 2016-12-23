type SetImageRequest:void{
  .image:raw
  .imageName?:string
}

type SetImageResponse:void{
  .imageName:string
}

type GetImageRequest:void{
  .imageName:string
}

type GetImageResponse:void{
  .image:raw
}

interface ImageInterface {
RequestResponse:
  setImage(SetImageRequest)(SetImageResponse),
  getImage(GetImageRequest)(GetImageResponse)
}
