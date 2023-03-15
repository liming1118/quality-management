<template>
  <div style="color: #666;font-size: 14px;">
    <div style="padding-bottom: 20px">
      <b>欢迎你！{{ admin.username }}</b>
    </div>

  </div>
</template>

<script>
import Cookies from 'js-cookie'

export default {
  name: "Home",
  data() {
    return {
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')) : {},  // 取出当前登录用户信息
    }
  }
}
</script>
