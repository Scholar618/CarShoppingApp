import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import {updatePwd} from '../../common/utils/HttpUtil';

@Entry
@Component
struct UpdatePwd {
  @State oldPassword: string = ""
  @State newPassword: string = ""
  @State confirmPassword: string = ""

  build() {
    Column() {
      Row({space:90}){
        Image($r('app.media.back'))
          .height(30)
          .width(30)
          .onClick(() => {
            router.back({ url: 'pages/MainPage'})
          })
        Text("修改密码")
          .fontSize(30)
          .margin({top:10})
          .height(35)
      }
      .width("100%")
      .height(50)
      .backgroundColor(0xE5E5E5)

      TextInput({ placeholder: '原密码：' })
        .margin(10)
        .height(45)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.oldPassword = value;
        })
      TextInput({ placeholder: '新密码：' })
        .margin(10)
        .height(45)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.newPassword = value;
        })
      TextInput({ placeholder: '确认密码：' })
        .margin(10)
        .height(45)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.confirmPassword = value;
        })



      Button('确认', { type: ButtonType.Capsule })
        .width("40%")
        .onClick(() => {
          if(!this.newPassword || !this.oldPassword || !this.confirmPassword) {
            prompt.showToast({
              message: '请填写完所有数据！'
            });
          }
          else if(this.newPassword != this.confirmPassword){
              prompt.showToast({
                message: '密码不一致，请重新输入！'
              });
          } else{
              updatePwd(AppStorage.Get("username"), this.newPassword, this.oldPassword, "/updatepwd")
          }
        })

    }

  }
}