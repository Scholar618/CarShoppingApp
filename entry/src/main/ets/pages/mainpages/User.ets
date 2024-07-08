import router from '@ohos.router'
@Entry
@Component
struct User {
  build() {
    Column() {
      Row({space:90}){
        Image($r('app.media.back'))
          .height(30)
          .width(30)
          .onClick(() => {
            router.pushUrl({ url: 'pages/MainPage'})
          }
          )
        Text("个人信息")
          .fontSize(30)
          .margin({top:10})
          .height(35)
      }
      .width("100%")
      .height(50)
      .backgroundColor(0xE5E5E5)


      Row({space:190}){
        Text("头像")
          .fontSize(25)
          .margin({left:10})
        Image($r('app.media.account'))
          .height(100)
          .width(100)

          .padding(20)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      .height("10%")

      Divider().strokeWidth(2).width("100%")

      Row(){
        Text("账号")
          .fontSize(25)
          .margin({left:10})

        Text(AppStorage.Get("username"))
          .fontSize(25)
          .fontColor("#CECECE")
          .margin({right:10})
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().strokeWidth(2).width("100%")

      Row(){
        Text("名称")
          .fontSize(25)
          .margin({left:10})
        Text(AppStorage.Get("name"))
          .fontSize(25)
          .margin({right:10})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/mainpages/UpdateImformation',
              params: {flag : 1, data : AppStorage.Get("name")}
            })
          })
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().strokeWidth(2).width("100%")

      Row(){
        Text("邮箱")
          .fontSize(25)
          .margin({left:10})

        Text(AppStorage.Get("email"))
          .fontSize(25)
          .margin({right:10})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/mainpages/UpdateImformation',
              params: {flag:2, data : AppStorage.Get("email")}
            })
          })
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().strokeWidth(2).width("100%")

      Row(){
        Text("手机")
          .fontSize(25)
          .margin({left:10})

        Text(AppStorage.Get("phone"))
          .fontSize(25)
          .margin({right:10})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/mainpages/UpdateImformation',
              params: {flag: 3, data : AppStorage.Get("phone")}
            })
          })

      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().strokeWidth(2).width("100%")

      Row(){
        Text("地址")
          .fontSize(25)
          .margin({left:10})

        Text(AppStorage.Get("address"))
          .fontSize(25)
          .margin({right:10})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/mainpages/UpdateImformation',
              params: {flag: 4, data : AppStorage.Get("address")}
            })
          })
      }
      .width("100%")
      .height("10%")
      .justifyContent(FlexAlign.SpaceBetween)

      Divider().strokeWidth(2).width("100%")

    }


  }
}