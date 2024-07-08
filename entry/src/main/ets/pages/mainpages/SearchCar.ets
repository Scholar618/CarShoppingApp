@Entry
@Component
struct SearchCar {
  @State information :any[] = [
    {title:'1', img:$r('app.media.car1'), name: '宝马', price:'10.80-17.97万'},
    {title:'2', img:$r('app.media.car1'), text: ''},
    {title:'3', img:$r('app.media.car1'), text: ''},
    {title:'4', img:$r('app.media.car1'), text: ''},
  ]
  build() {
    Column() {
      Text("搜索")
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .margin(5)

      Divider().strokeWidth(2).width("100%")

      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.information, (item) => {
          ListItem() {
            Row(){
              Text('' + item.title)
                .fontSize(30)
                .textAlign(TextAlign.Center)
                .width("10%")
                .height("100%")
              Image(item.img)
                .width("35%")
                .height("100%")
              Column(){
                Text(item.name)
                  .textAlign(TextAlign.Start)
                  .width("30%")
                Text(item.price)
                  .textAlign(TextAlign.Start)
                  .width("30%")
              }
            }
            .width("100%")

          }
          .backgroundColor('#B0B0B0')
          .width("100%")
          .height("15%")

        }, item => item)

      }
      .width('100%')
      .height("98%")
      .margin({left:5})

    }
    .width('100%')



  }
}