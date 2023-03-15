import axios from 'axios'
import router from "@/router";
import Cookies from 'js-cookie'

const request = axios.create({
    baseURL: 'http://localhost:9090/api',
    timeout: 5000
})

// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    const adminJson = Cookies.get('admin')  // （***）获取cookie(含admin对象属性+token)
    // 统一在请求前读取cookie,如果没有统一跳登录页(问题：输入不存在路由，不会有请求，就不能跳登录页面。这里最好用路由守卫)
    // if(!adminJson){
    //     router.push("/login")  
    // }
    if (adminJson) {
        // （***）请求前设置自定义请求头token，携带token请求
        config.headers['token'] = JSON.parse(adminJson).token
    }
    return config
}, error => {
    return Promise.reject(error)
});

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        if (res.code === '401') {  // （***）token 验证失败的专有错误码
            router.push('/login')
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)


export default request