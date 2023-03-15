<template>
  <div style="height: 100vh; overflow: hidden; position: relative">
    <!--   v-if="loginAdmin.id  如果点击登录成功。cookies会存储id,就会显示出来滑动图像验证 -->
    <el-card class="cover" v-if="loginAdmin.id">
      <slide-verify :l="42" :r="10" :w="310" :h="155" :accuracy="5" :imgs="['https://cdn.pixabay.com/photo/2022/11/09/12/23/lotus-7580478_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/08/29/12/07/adult-2693054_960_720.jpg',
        'https://cdn.pixabay.com/photo/2022/11/16/15/52/mushrooms-7596258_960_720.jpg']" slider-text="向右滑动"
        @success="onSuccess" @fail="onFail" @refresh="onRefresh"></slide-verify>
    </el-card>

    <div style="width: 500px; height: 400px; background-color: white; border-radius: 10px;
                            margin: 150px auto; padding:50px">
      <div style="margin: 30px; text-align: center; font-size: 30px; font-weight: bold; color: dodgerblue">登 录</div>
      <el-form :model="admin" :rules="rules" ref="loginForm">
        <el-form-item prop="username">
          <el-input placeholder="请输入账号" prefix-icon="el-icon-user" size="medium" v-model="admin.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input placeholder="请输入密码" show-password prefix-icon="el-icon-lock" size="medium"
            v-model="admin.password"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%" size="medium" type="primary" @click="login">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
// 登录成功后，将登录接口返回的信息存到浏览器cookie中
import Cookies from 'js-cookie'

export default {
  name: 'LOGIN',
  data() {
    return {
      loginAdmin: {},
      admin: {},
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ]
      }
    }
  },
  methods: {
    login() {
      this.$refs['loginForm'].validate((valid) => {
        if (valid) {
          request.post('/admin/login', this.admin).then(res => {
            if (res.code === '200') {
              this.loginAdmin = res.data  // 滑块组件就出现了
            } else {
              this.$notify.error(res.msg)
            }
          })
        }
      })
    },
    onSuccess() { // 滑块验证通过之后触发的
      Cookies.set('admin', JSON.stringify(this.loginAdmin))  // 对象转json字符串 ,  存到cookie(有admin对象属性+token)
      this.$notify.success("登录成功")
      // 一定要先存储cookie,再跳转'/'。不然，先进入'/' 但没有cookie会被路由守卫到login页 死循环
      this.$router.push('/')
    },
    onFail() {
      console.log('onFail')
    },
    onRefresh() {
      console.log('refresh')
    }
  }
}
</script>

<style>
.cover {
  width: fit-content;
  background-color: white;
  position: absolute;
  top: 50%;
  left: 50%;
  /* 滑动模块垂直居中 */
  transform: translate(-50%, -50%);
  /* 并且置于登录表单上方 脱离文档流 权重大*/
  z-index: 1000;
}
</style>