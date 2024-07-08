import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import {ForgetUserPwd} from '../../common/utils/HttpUtil'

@Entry
@Component
struct ForgetPwd {
  @State username : string = ""
  @State email : string = ""
  @State phone : string = ""
  @State newPwd : string = ""

  build() {
    Column() {
      Text("修改密码")
        .fontSize(30)
        .margin({ top: 10 })
        .height(35)

      TextInput({ placeholder: '用户名：' })
        .margin(10)
        .height(45)
        .onChange((value: string) => {
          this.username = value;
        })
      TextInput({ placeholder: '邮箱：' })
        .margin(10)
        .height(45)
        .onChange((value: string) => {
          this.email = value;
        })
      TextInput({ placeholder: '手机：' })
        .margin(10)
        .height(45)
        .maxLength(11)
        .onChange((value: string) => {
          this.phone = value;
        })
      TextInput({ placeholder: '新密码：' })
        .margin(10)
        .height(45)
        .maxLength(11)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.newPwd = value;
        })

      Row({space : 40}){
        Button('取消', { type: ButtonType.Capsule })
          .width("40%")
          .margin({top:10})
          .onClick(() => {
            router.back({url : "pages/LoginPage" } )
          })

        Button('确认', { type: ButtonType.Capsule })
          .width("40%")
          .margin({top:10})
          .onClick(() => {
            if(!this.email || !this.phone || !this.username || !this.newPwd){
              prompt.showToast({
                message: '请填写完所有信息哦！'
              });
            } else{
              ForgetUserPwd(this.username, this.email, this.phone, this.newPwd, "/forgetpwd")
            }
          })
      }




    }


  }
}