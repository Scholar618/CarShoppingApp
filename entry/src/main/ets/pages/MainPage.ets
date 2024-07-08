
import prompt from '@ohos.prompt';
import Prompt from '@system.prompt';
import router from '@ohos.router';
/**
 * Main page
 */
@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0;
  @State currentState: boolean = false;
  private tabsController: TabsController = new TabsController();
  private swiperController: SwiperController = new SwiperController();
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()

  @State pictures: any[] = [
    { Simg:$r('app.media.superCar1')},
    { Simg:$r('app.media.superCar2')},
    { Simg:$r('app.media.superCar3')},
    { Simg:$r('app.media.superCar4')}
  ]
  @State othersItems: any[] = [
    {title:'收藏', img:$r('app.media.love'), url:'pages/mainpages/MyFavoritePage'},
    {title:'热度排行', img:$r('app.media.hot'), url:'pages/mainpages/Heat'},
    {title:'新车上市', img:$r('app.media.newCar'), url:'pages/mainpages/NewCar'},
    {title:'订单', img:$r('app.media.shopping'), url:'pages/mainpages/Shopping'},
    {title:'汽车百科', img:$r('app.media.carKnowledge'), url:'pages/mainpages/CarKnowledge'},
    {title:'新能源', img:$r('app.media.newEnergy'), url:'pages/mainpages/NewEnergy'},
    {title:'卖车', img:$r('app.media.saleCar'), url:'pages/mainpages/SaleCar'},
    {title:'用户反馈', img:$r('app.media.feedback'), url:'pages/mainpages/FeedBack'}
  ]
  @State listItems: any[] = [
    {title:'ModelY', img:$r('app.media.car1'), text: '厦门站，我们不见不散'},
    {title:'奥迪Q5L', img:$r('app.media.car2'), text: '厦门站，我们不见不散'},
    {title:'途观L', img:$r('app.media.car3'), text: '大牌闪购'},
    {title:'问界M9', img:$r('app.media.car4'), text: '厦门站，我们不见不散'},
    {title:'宝马X5', img:$r('app.media.car5'), text: '大牌闪购'},
    {title:'宋PLUS新能源', img:$r('app.media.car6'), text: '厦门站，我们不见不散'},
    {title:'理想L6', img:$r('app.media.car7'), text: '大牌闪购'},
    {title:'奔驰GLC', img:$r('app.media.car8'), text: '厦门站，我们不见不散'}
  ]
  @State setItems: any[] = [
    {title:'修改密码', img:$r('app.media.news'), url: 'pages/mainpages/UpdatePwd'},
    {title:'注销管理', img:$r('app.media.data'), url: 'pages/mainpages/DelUser'},
    {title:'菜单设置', img:$r('app.media.menu'), url:''},
    {title:'关于', img:$r('app.media.about'), url:''},
    {title:'清除缓存', img:$r('app.media.storage'), url:''},
    {title:'隐私协议', img:$r('app.media.privacy'), url:''}
  ]

  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width(25)
        .height(25)
      Text(title)
        .margin({ top: 4 })
        .fontSize(10)
        .fontColor(this.currentIndex === index ? '#1698CE' : '#6B6B6B')
    }
    .justifyContent(FlexAlign.Center)
    .height(56)
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  @Builder settingCell(sI) {
    Row() {
      Row({ space: 12 }) {
        Image(sI.img)
          .width(22)
          .height(22)
        Text(sI.title)
          .fontSize(16)
      }

      if (sI.textF === null) {
        Image($r('app.media.right_grey'))
          .width(12)
          .height(24)
      } else {

      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: 8,
      right: 22
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        Scroll() {
          Column({ space: 12 }) {
            Column() {
              Text('首页')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
                .margin({ top: 12 })
                .padding({ left: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Search({ value: this.changeValue, placeholder: 'Type to search...', controller: this.controller })
              .searchButton('搜索')
              .width(350)
              .height(20)
              .backgroundColor('#F5F5F5')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 17, weight: 350 })
              .textFont({ size: 15, weight: 350 })
              .onSubmit((value: string) => {
                this.submitValue = value
                router.pushUrl({url : "pages/mainpages/SearchCar"})
              })
              .onChange((value: string) => {
                this.changeValue = value
              })
              .margin({top : 2})

            // 轮播图
            Swiper(this.swiperController) {
              ForEach(this.pictures, (img) => {
                Image(img.Simg).borderRadius(16)
              },)
            }
            .margin({ top: 10 })
            .autoPlay(true)
            .height(160)
            .width("99%")


            // 功能图标
            Grid() {
              ForEach(this.othersItems, (oI) => {
                GridItem() {
                  Column() {
                    Column() {
                      Image(oI.img)
                        .width(24)
                        .height(24)
                      Text(oI.title)
                        .fontSize(12)
                        .margin({ top: 4 })
                    }
                    .onClick(() => {
                      router.pushUrl({url: oI.url})
                    })
                  }
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .padding({ top: 12, bottom: 12 })
            .height(124)
            .backgroundColor(Color.White)
            .borderRadius(24)

            Text('列表')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .margin({ top: 12 })

            Grid() {
              ForEach(this.listItems, (lI) => {
                GridItem() {}
                .padding({ top: 8, left: 8 })
                .borderRadius(12)
                .align(Alignment.TopStart)
                .backgroundImage(lI.img)
                .backgroundImageSize(ImageSize.Cover)
                .width('100%')
                .height('100%')
                .overlay(lI.title, { align: Alignment.Bottom, offset: { x: 0, y: 2 } })
                // .borderStyle(BorderStyle.Solid)   // 直接设置边框样式
                // .borderWidth(3)
                // .onTouch((event: TouchEvent) => {
                //   if(event.touches){
                //     this
                //       .borderStyle(BorderStyle.Solid)   // 直接设置边框样式
                //       .borderWidth(3)
                //       .borderColor('#ffec063d')
                //       .borderRadius(10)
                //       .width(120)
                //       .height(120)
                //   }
                // })
              })
            }
            .width('100%')
            .height(500)
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .margin({ bottom: 55 })
          }
        }
        .height('100%')
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('首页', 0,
        $r('app.media.home_selected'), $r('app.media.home_normal')))

      TabContent() {
        Scroll() {
          Column({ space: 12 }) {
            Column(){
              Text('我的')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
                .margin({ top: 12 })
                .padding({ left: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Row() {
              Image($r('app.media.account'))
                .width(48)
                .height(48)
              Column() {
                Text(AppStorage.Get("name"))
                  .fontSize(20)
                Text(AppStorage.Get("email"))
                  .fontSize(12)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 24 })
            }
            .margin({ top: 24 })
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .height(96)
            .backgroundColor(Color.White)
            .padding({ left: 24 })
            .borderRadius(16)
            .onClick(() => {
              router.pushUrl({url: 'pages/mainpages/User'})
            })

            List() {
              ForEach(this.setItems, (sI) => {
                ListItem() {
                  this.settingCell(sI)
                }
                .height(48)
                .onClick(() => {
                  router.pushUrl({url: sI.url})
                })
              })
            }
            .backgroundColor(Color.White)
            .width('100%')
            .height('42%')
            .divider({
              strokeWidth: 0.25,
              color: Color.Grey,
              startMargin: 42,
              endMargin: 24
            })
            .borderRadius(16)
            .padding({ top: 4, bottom: 4 })

            Blank()

            Button('退出登录', { type: ButtonType.Capsule })
              .width('90%')
              .height(40)
              .fontSize(16)
              .fontColor('#FA2A2D')
              .fontWeight(FontWeight.Medium)
              .backgroundColor('#E5E8EA')
              .margin({ bottom: 55})
              .onClick(() => {
                AlertDialog.show({
                  title:'提示消息',
                  message: '确定退出登录吗？',
                  offset:{ dx:0, dy: -20},
                  alignment: DialogAlignment.Bottom,
                  gridCount:4,
                  autoCancel:true,
                  primaryButton:{
                    value:'取消',
                    action:() => {
                      //取消操作
                    }
                  },
                  secondaryButton:{
                    value:'确定',
                    action:() => {
                      // router.back({ url: 'pages/LoginPage'})
                      router.pushUrl({url: 'pages/LoginPage'})
                    }
                  },
                  cancel:() => {
                    //取消操作
                  }
                })
              })
          }
          .height('100%')
        }
      }
      .padding({ left: 12, right: 12 })
      .backgroundColor('#F1F3F5')
      .tabBar(this.TabBuilder('我的', 1,
        $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }
    .width('100%')
    .backgroundColor(Color.White)
    .barHeight(56)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}