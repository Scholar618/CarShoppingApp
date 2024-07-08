import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import {DELUser} from '../../common/utils/HttpUtil';

@Entry
@Component
struct DelUser {
  @State username : string = AppStorage.Get("username")
  @State oldPassword: string = ""

  build() {
    Column() {

      Text("注销账户")
        .fontSize(30)
        .margin({top:10})
        .height(35)
        .width("100%")
        .textAlign(TextAlign.Center)


      TextInput({ placeholder: '密码：' })
        .margin(10)
        .height(45)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.oldPassword = value;
        })


      Row({space:50}){
        Button('取消', { type: ButtonType.Capsule })
          .width("35%")
          .onClick(() => {
            router.back({url : "pages/MainPage" } )
          })
        Button('确认', { type: ButtonType.Capsule })
          .width("35%")
          .onClick(() => {
            if(!this.oldPassword) {
              prompt.showToast({
                message: '请填写密码！'
              });
            } else {
              AlertDialog.show(
                {
                  title: '注销账户',
                  message: '确认注销吗？',
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  gridCount: 4,
                  offset: { dx: 0, dy: -20 },
                  primaryButton: {
                    value: 'No',
                    action: () => {
                    }
                  },
                  secondaryButton: {
                    value: 'Yes',
                    action: () => {
                      DELUser(this.username, this.oldPassword, "/logout")
                    }
                  },
                  cancel: () => {
                    console.info('Closed callbacks')
                  }
                }
              )
            }

          })
      }


    }

  }
}