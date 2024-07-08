import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import { updateUser } from '../../common/utils/HttpUtil';

@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#99182431')
    .height(50)
    .fontSize(25)
    .backgroundColor('#F1F3F5')
    .width('100%')
}

@Entry
@Component
struct UpdateImformation {
  @State data: string = router.getParams()?.["data"]
  @State flag: number = router.getParams()?.["flag"]

  build() {
    Column() {
      Row({space:90}){
        Image($r('app.media.back'))
          .height(30)
          .width(30)
          .onClick(() => {
              router.back({ url: 'pages/mainpages/User'})
            }
          )
        Text("更改信息")
          .fontSize(30)
          .margin({top:10})
          .height(35)
      }
      .width("100%")
      .height(50)
      .backgroundColor(0xE5E5E5)

      TextInput({text : this.data})
        .maxLength(20)
        .type(InputType.Normal)
        .inputStyle()
        .onChange((value :string) => {
          this.data = value
        })

      Button('确认', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .width(90)
        .onClick(() => {
          if(AppStorage.Get("username") == "Tourist") {
            // prompt.showToast({
            //   message: '游客不允许修改哦！请注册账号后重试！'
            // })
          } else {
            if (this.flag==1) {
              updateUser(AppStorage.Get("username"), this.data, "name", "/update")
              AppStorage.SetOrCreate("name", this.data)
            } else if(this.flag == 2) {
              updateUser(AppStorage.Get("username"), this.data, "email", "/update")
              AppStorage.SetOrCreate("email", this.data)
            } else if(this.flag == 3) {
              updateUser(AppStorage.Get("username"), this.data, "phone", "/update")
              AppStorage.SetOrCreate("phone", this.data)
            } else if(this.flag == 4) {
              updateUser(AppStorage.Get("username"), this.data, "address", "/update")
              AppStorage.SetOrCreate("address", this.data)
            }
            // prompt.showToast({
            //   message: '修改成功'
            // })
            router.pushUrl({ url: 'pages/mainpages/User'})
          }

        })

      }

  }
}