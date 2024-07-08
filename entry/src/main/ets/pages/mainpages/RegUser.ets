import router from '@ohos.router'
import prompt from '@ohos.promptAction';
import {VerifyUser} from '../../common/utils/HttpUtil'

@Entry
@Component
struct RegUser {
  @State name : string = ""
  @State email : string = ""
  @State phone : string = ""
  @State address : string = "北京"
  private select: number = 0
  private areas: string[] =
    ["北京", "天津", "上海", "重庆", "新疆", "西藏", "宁夏", "内蒙古",
    "广西", "黑龙江", "吉林", "辽宁", "河北", "山东", "江苏", "安徽",
    "浙江", "福建", "广东", "海南", "云南", "贵州", "四川", "湖南",
    "湖北", "河南", "山西", "陕西", "甘肃", "青海", "江西", "台湾", "香港", "澳门"]
  @State isVisible: Boolean = false



  build() {
    Column() {
        Text("完善个人信息")
          .fontSize(30)
          .margin({ top: 10 })
          .height(35)

      TextInput({ placeholder: '名称：' })
        .margin(10)
        .height(45)
        .onChange((value: string) => {
          this.name = value;
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
      // TextInput({ placeholder: '地址：' })
      //   .margin(10)
      //   .height(45)
      //   .onChange((value: string) => {
      //     this.address = value;
      //   })


      Column({space:40}){
        // Button('地址', { type: ButtonType.Capsule })
        //   .width("40%")
        //   .margin({top:10})
        //   .onClick(() => {
        //     this.isVisible  = !this.isVisible
        //   })

        TextPicker({ range: this.areas, selected: this.select })
          .onChange((value: string, index: number) => {
            // console.info('Picker item changed, value: ' + value + ', index: ' + index)
            this.address = value
          })
          .visibility(Visibility.Visible)

        Button('登录', { type: ButtonType.Capsule })
          .width("40%")
          .margin({top:10})
          .onClick(() => {
            if(!this.name || !this.email || !this.phone || !this.address){
              prompt.showToast({
                message: '请完善信息后再确认哦！'
              });
            } else{
              VerifyUser(AppStorage.Get("username"), this.name, this.email, this.phone, this.address, "/refineinfo")

            }
          })
      }


    }


  }
}