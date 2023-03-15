<template>
  <div style="width: 80%">
    <div style="margin-bottom: 30px">编辑需求</div>
    <el-form :inline="true" :rules="rules" ref="ruleForm" :model="form" label-width="100px">
      <el-form-item label="需求名称" prop="name">
        <el-input v-model="form.name" placeholder="请输入需求名称"></el-input>
      </el-form-item>
      <el-form-item label="描述" prop="description">
        <el-input style="width: 400px" type="textarea" v-model="form.description" placeholder="请输入需求描述"></el-input>
      </el-form-item>
      <el-form-item label="发版日期" prop="publishDate">
        <!-- 日期控件 -->
        <el-date-picker v-model="form.publishDate" type="date" value-format="yyyy-MM-dd" placeholder="请选择发版日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="开发测试" prop="author">
        <el-input v-model="form.author" placeholder="请输入开发|测试"></el-input>
      </el-form-item>
      <el-form-item label="PM" prop="publisher">
        <el-input v-model="form.publisher" placeholder="请输入PM"></el-input>
      </el-form-item>
      <el-form-item label="需求分类" prop="category">
        <el-cascader style="width: 220px" :props="{ value: 'name', label: 'name' }" v-model="form.categories"
          :options="categories"></el-cascader>
      </el-form-item>

      <el-form-item label="预估工时" prop="score">
        <el-input-number v-model="form.score" :min="1" :max="10" label="所需工时"></el-input-number>
      </el-form-item>
      <br>
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
import Cookies from "js-cookie";

export default {
  name: 'EditBook',
  data() {
    return {
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')) : {},
      form: { score: 1 },
      categories: [], // 级联目录
      rules: {
        name: [
          { required: true, message: '请输入需求名称', trigger: 'blur' }
        ],
        score: [
          { required: true, message: '请输入工时', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    // 获取版本的版本目录数据
    request.get('/category/tree').then(res => {
      this.categories = res.data
    })

    const id = this.$route.query.id
    request.get("/book/" + id).then(res => {
      this.form = res.data
      if (this.form.category) {
        this.form.categories = this.form.category.split(' > ')  // 接口返回是字符串 "历史>科技"，需要还原数组[历史，科技]，不然显示不了级联控件
        console.log(this.form.categories)
      }
    })
  },
  methods: {
    handleCoverSuccess(res) {
      if (res.code === '200') {
        this.form.cover = res.data
      }
    },
    save() {
      request.put('/book/update', this.form).then(res => {
        if (res.code === '200') {
          this.$notify.success('更新成功')
          this.$router.push("/bookList")
        } else {
          this.$notify.error(res.msg)
        }
      })
    }
  }
}

</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>

