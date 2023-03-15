<template>
  <div style="width: 80%">
    <!-- <div style="margin-bottom: 30px">编辑管理员</div> -->
    <!-- 面包屑 -->
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/adminList' }">管理员列表</el-breadcrumb-item>
      <el-breadcrumb-item>编辑管理员</el-breadcrumb-item>
    </el-breadcrumb>
    <br>
    <br>

    <el-form :inline="true" :model="form" label-width="100px">
      <el-form-item label="用户名" prop="username">
        <el-input v-model="form.username" placeholder="请输入姓名"></el-input>
      </el-form-item>

      <el-form-item label="联系方式" prop="phone">
        <el-input v-model="form.phone" placeholder="请输入联系方式"></el-input>
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="form.email" placeholder="请输入地址"></el-input>
      </el-form-item>
    </el-form>

    <div style="text-align: center; margin-top: 30px">
      <el-button type="primary" @click="save" size="medium">提交</el-button>
      <!--  点击取消回到上一页 -->
      <el-button type="" @click="$router.go(-1)" size="medium">取消</el-button>

    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: 'EditAdmin',
  data() {
    return {
      form: {}
    }
  },
  created() {
    const id = this.$route.query.id
    request.get("/admin/" + id).then(res => {
      this.form = res.data
    })
  },
  methods: {
    save() {
      request.put('/admin/update', this.form).then(res => {
        if (res.code === '200') {
          this.$notify.success('更新成功')
          this.$router.push("/adminList")
        } else {
          this.$notify.error(res.msg)
        }
      })
    },
    // 点击取消回到上一页
    back() {
      this.$router.go(-1)
    }
  }
}

</script>

