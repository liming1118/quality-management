import Vue from 'vue'
import App from './App.vue'
import router from './router'
// vue2 引入element-ui
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
// main.js 中引入全局样式
import '@/assets/global.css'
// 滑块验证
import SlideVerify from 'vue-monoplasty-slide-verify';

Vue.use(SlideVerify);
Vue.config.productionTip = false
Vue.use(ElementUI, { size: 'small' });  // 输入框、按钮太大可以修改为samll, medium  mini

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
