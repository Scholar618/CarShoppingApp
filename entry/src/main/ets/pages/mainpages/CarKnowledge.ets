import MockData from '../../MockData/MockData'

@Builder function overBuilder($$: { information: string[] }) {
  List({ space: 20, initialIndex: 0 }) {
    ForEach(this.information, (item) => {
      ListItem() {
        Text('' + item)
          .width('100%')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor('#F0FFF0')
      }
      .backgroundColor('#00F5FF')
      .borderRadius("8")

    }, item => item)

  }
  .width('68%')
  .height("98%")
  .margin({left:5})
}

@Entry
@Component
struct CarKnowledge {
  @State arr :string[] =
    ['车身','基本信息',
      '发动机','变速箱',
      '地盘转向','电动机',
      '电池/补能','主动安全',
      '被动安全']
  @State information :string[] = []



  build() {

    Row() {

      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.arr, (item) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(100)
              .fontSize(25)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor('#DCDCDC')
              .borderRadius('15')

          }
          .backgroundColor('#DCDCDC')
          .borderRadius('15')
          .onClick(()=>{
            console.log("index",item)
            if(item == "车身"){
              this.information = MockData.bodywork
            }

          })

        }, item => item)

      }
      .width('30%')


      overBuilder({ information: this.information })

    }
    .height('100%')
    .width('100%')



  }
}