import http from '@ohos.net.http';
import router from '@ohos.router';
import { BASE_URL } from './Constants';
import prompt from '@ohos.promptAction';

// 发送 POST 请求进行用户注册
export function registerUser(account: string, password: string, url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.POST,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "password": password
      },
    },(err, data) => {
      if(!err) {
        if(data.responseCode == 200) {
          console.info("传递成功")

          // @ts-ignore
          let json = JSON.parse(data.result)

          // @ts-ignore
          console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg
                        + " code : " +json.code)

          // @ts-ignor
          if(json.code == 1){
            AppStorage.SetOrCreate("username", account)
            router.pushUrl(
              {
                url : 'pages/mainpages/RegUser',
              }
            )
          }else{
            prompt.showToast({
              message: json.msg
            });
          }
        } else {
          console.info('error:' + JSON.stringify(data));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 当该请求使用完毕时，调用destroy方法主动销毁。
          httpRequest.destroy();
        }
      }
  }
  );
}

// 发送 Get 请求并接受account,password,phone
export function loginUser(account: string, password: string, url : string) {
  // 构建登录请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.GET,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "password": password
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg)
        console.info("code : " +json.code)
        // @ts-ignor
        if(json.code == 1){
          AppStorage.SetOrCreate("username", json.data.username)
          AppStorage.SetOrCreate("name", json.data.name)
          AppStorage.SetOrCreate("email", json.data.email)
          AppStorage.SetOrCreate("phone", json.data.phone)
          AppStorage.SetOrCreate("address", json.data.address)
          router.pushUrl({url: 'pages/MainPage'});
        }else{
          prompt.showToast({
            message: json.msg
          });
        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );

}

// 发送 Post 请求修改用户信息
export function updateUser(account: string, data1: string, type : string, url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.POST,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "key" : type+";"+data1
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg)
        console.info("code : " +json.code)

        // @ts-ignor
        if(json.code == 1){} else{
          prompt.showToast({
            message: json.msg
          });

        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );
}

// 发送 Post 请求修改用户密码
export function updatePwd(account: string, newPassword: string, oldPassword: string,url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.POST,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "newPassword" : newPassword,
        "oldPassword" : oldPassword
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg)
        console.info("code : " +json.code)

        // @ts-ignor
        if(json.code == 1){
          prompt.showToast({
            message: "修改成功！"
          });
          router.pushUrl({url: 'pages/LoginPage'});
          AppStorage.Clear()
          console.info("username : " +AppStorage.Get("username"))
        } else{
          prompt.showToast({
            message: json.msg
          });

        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );
}

// 发送 POST 请求完善用户信息
export function VerifyUser(account: string, name: string, email: string, phone: string, address: string,url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.POST,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg
        + " code : " +json.code)

        // @ts-ignor
        if(json.code == 1){
          router.pushUrl(
            {
              url : 'pages/LoginPage',
            }
          )
          AppStorage.Clear()
        }else{
          prompt.showToast({
            message: json.msg
          });
        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );
}

// 发送 POST 请求进行忘记密码
export function ForgetUserPwd(account: string, email: string, phone: string, newPwd: string,url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.POST,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "newPassword" : newPwd,
        "email": email,
        "phone": phone,
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg
        + " code : " +json.code)

        // @ts-ignor
        if(json.code == 1){
          router.pushUrl(
            {
              url : 'pages/LoginPage',
            }
          )
        }else{
          prompt.showToast({
            message: json.msg
          });
        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );
}


// 发送 DEL 请求进行用户注销
export function DELUser(account: string,password: string ,url : string) {
  // 构建注册请求的 URL
  url = BASE_URL + url;
  let httpRequest = http.createHttp();
  httpRequest.request(
    url,
    {
      method : http.RequestMethod.DELETE,
      header : {
        'Content-Type': 'application/json'
      },
      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "username": account,
        "password" : password,
      },
    },(err, data) => {
    if(!err) {
      if(data.responseCode == 200) {
        console.info("传递成功")

        // @ts-ignore
        let json = JSON.parse(data.result)

        // @ts-ignore
        console.info("从服务器返回接口数据成功，传递参数msg : " + json.msg
        + " code : " +json.code)

        // @ts-ignor
        if(json.code == 1){
          router.pushUrl(
            {
              url : 'pages/LoginPage',
            }
          )
          AppStorage.Clear()
        }else{
          prompt.showToast({
            message: json.msg
          });
        }
      } else {
        console.info('error:' + JSON.stringify(data));
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
  }
  );
}
