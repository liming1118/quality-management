<template>
  <div style="width: 80%">
    <div style="margin-bottom: 30px">新增需求</div>
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
        <el-input v-model="form.author" placeholder="请输入开发测试"></el-input>
      </el-form-item>
      <el-form-item label="PM" prop="publisher">
        <el-input v-model="form.publisher" placeholder="请输入PM"></el-input>
      </el-form-item>
      <!-- 级联目录 数据来源:options="categories， 同时被选中的传参以数组["历史","科技"] 带给后端sava()方法-->
      <el-form-item label="需求分类" prop="category">
        <el-cascader style="width: 220px" :props="{ value: 'name', label: 'name' }" v-model="form.categories"
          :options="categories"></el-cascader>
      </el-form-item>
      <!-- <el-form-item label="标准码" prop="bookNo">
        <el-input v-model="form.bookNo" placeholder="请输入标准码"></el-input>
      </el-form-item> -->
      <el-form-item label="预估工时" prop="score">
        <el-input-number v-model="form.score" :min="1" :max="10" label="所需工时xx天"></el-input-number>
      </el-form-item>
      <!-- <el-form-item label="预估人力" prop="nums">
        <el-input v-model="form.nums" placeholder="请输入xx人"></el-input>
      </el-form-item> -->
      <br>

    </el-form>

    <div style="text-align: center; margin-top: 30px">
      <el-button type="primary" @click="save" size="medium">提交</el-button>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import Cookies from "js-cookie";

export default {
  name: 'AddBook',
  data() {
    const checkNums = (rule, value, callback) => {
      // 前端获取的都是字符串，数字比较要转化
      value = parseInt(value)
      if (value < 0 || value >= 1000) {
        callback(new Error('请输入大于等于0小于1000的整数'));
      }
      callback()
    };
    return {
      // 当前用户cookie,里面有token
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')) : {},
      form: { score: 1, cover: '' },
      categories: [], // 版本级联目录,前端是个数组形式
      rules: {
        name: [
          { required: true, message: '请输入需求名称', trigger: 'blur' }
        ],
        score: [
          { required: true, validator: checkNums, trigger: 'blur' }
        ],
        publishDate: [
          { required: true, message: '请选择发版日期', trigger: 'blur' }
        ],
        author: [
          { required: true, message: '请输入开发测试', trigger: 'blur' }
        ],
        // publisher: [
        //   { required: true, message: '请输入PM', trigger: 'blur' }
        // ],
        // category: [
        //   { required: true, message: '请选择需求分类', trigger: 'blur' }
        // ],
      }
    }
  },
  created() {
    // 获取版本级联目录  分类是级联菜单，需要先获取1级目录和子集数据 在Controller service 新增方法 递归获取
    request.get('/category/tree').then(res => {
      this.categories = res.data
    })
  },
  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          request.post('/book/save', this.form).then(res => {
            if (res.code === '200') {
              this.$notify.success('新增成功')
              this.$refs['ruleForm'].resetFields()
              this.$router.push("/bookList")
            } else {
              this.$notify.error(res.msg)
            }
          })
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
