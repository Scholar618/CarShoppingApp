
import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import App from '@system.app';
import { loginUser } from '../common/utils/HttpUtil';
@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#99182431')
  .height(48)
  .fontSize(45)
  .backgroundColor('#F1F3F5')
  .width('100%')
  .padding({ left: 0 })
  .margin({ top: 12 })
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height(1)
  .backgroundColor('#33182431')
}

@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
}

/**
 * Login page
 */
@Entry
@Component
struct LoginPage {
  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;
  @State isRegister: boolean = false;

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height(48)
    .width(48)
    .backgroundColor('#F1F3F')
  }

  login(): void {
    if (this.account === '' || this.password === '') {
      prompt.showToast({
        message: '输入不能为空'
      })
    } else {
      //  后端判断账户密码
      // 调用 registerUser 函数进行注册
      loginUser(this.account, this.password, "/login");
      // if (null) {
      //   prompt.showToast({
      //     message: '用户名或密码不正确，请重新核对后输入'
      //   })
      // } else {
      //   this.isShowProgress = true;
      //   if (this.timeOutId === -1) {
      //     this.timeOutId = setTimeout(() => {
      //       this.isShowProgress = false;
      //       this.timeOutId = -1;
      //       prompt.showToast({
      //         message: '登录成功！！！欢迎您' + this.account
      //       })
      //       router.pushUrl({ url: 'pages/MainPage' });
      //     }, 2000);
      //   }
      // }
      // if (this.timeOutId === -1) {
      //   this.timeOutId = setTimeout(() => {
      //     this.isShowProgress = false;
      //     this.timeOutId = -1;
      //     prompt.showToast({
      //       message: '登录成功！！！欢迎您' + this.account
      //     })
      //     router.pushUrl({ url: 'pages/MainPage' });
      //   }, 2000);
      // }
    }
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Column() {
      Image($r('app.media.logo'))
        .width(80)
        .height(80)
        .margin({ top: 100, bottom: 8 })
      Text('汽车商城')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
      Text('登录以获取更多服务')
        .fontSize(16)
        .fontColor('#99182431')
        .margin({ bottom: 30, top: 8 })

      TextInput({ placeholder: '账号' })
        .maxLength(11)
        .type(InputType.Normal)
        .inputStyle()
        .onChange((value: string) => {
          this.account = value;
        })
      Line().lineStyle()

      TextInput({ placeholder: '密码' })
        .maxLength(8)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => {
          this.password = value;
        })
      Line().lineStyle()

      Row() {
        Text('游客登陆').blueTextStyle()
          .onClick(() => {
            AppStorage.SetOrCreate("username", "Tourist")
            AppStorage.SetOrCreate("email", "buy@car.com")
            AppStorage.SetOrCreate("name", "游客")
            AppStorage.SetOrCreate("phone", "123456789")
            AppStorage.SetOrCreate("address", "中国武汉")
            router.pushUrl({ url: 'pages/MainPage'})
          })
        Text('忘记密码').blueTextStyle()
          .onClick(() => {
            router.pushUrl({url : "pages/mainpages/ForgetPwd"})
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 8 })

      Button('登录', { type: ButtonType.Capsule })
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#007DFF')
        .margin({ top: 87, bottom: 12 })
        .onClick(() => {
          this.login();
        })
      Text('注册账号')
        .fontColor('#007DFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          router.pushUrl({ url: 'pages/RegisterPage'})
        })

      if (this.isShowProgress) {
        LoadingProgress()
          .color('#182431')
          .width(30)
          .height(30)
          .margin({ top: 20 })
      }

      Blank()
      Text('其他登录方式')
        .fontColor('#838D97')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 50, bottom: 12 })
      Row({ space: 44 }) {
        this.imageButton($r('app.media.qq'))
        this.imageButton($r('app.media.weixin'))
        this.imageButton($r('app.media.douyin'))
      }
    }
    .backgroundColor('#F1F3F5')
    .height('100%')
    .width('100%')
    .padding({
      left: 12,
      right: 12,
      bottom: 24
    })
  }
}