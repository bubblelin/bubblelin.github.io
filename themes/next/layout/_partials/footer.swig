<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<span id="busuanzi_container_site_pv">
    本站总访问量<span id="busuanzi_value_site_pv"></span>次
</span>

<script>
var birthDay = new Date("22/5/2016");
var now = new Date();
var duration = now.getTime() - birthDay.getTime();
var total= Math.floor(duration / (1000 * 60 * 60 * 24));
document.getElementById("showDays").innerHTML = "本站已运行 "+total+" 天";
</script>
<span id="showDays"></span>

<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
本站访问总量 <span id="busuanzi_value_site_pv"></span> &nbsp|&nbsp
您是第<span id="busuanzi_value_site_uv"></span>个小伙伴了！
