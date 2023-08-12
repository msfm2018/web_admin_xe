// 树配置


final List<DataBean> data = <DataBean>[
  DataBean('照片'),
  DataBean('留言薄'),
  DataBean('大西洋'),
  DataBean('直辖市', [ ...zxs]),
  DataBean('自治区', [...zzq ]),
  DataBean('省级行政单位', [    DataBean('黑龙江', [...hlj]),    ...sjxz  ]),
  DataBean('特别行政区', <DataBean>[    DataBean(      '香港',    ),    DataBean(      '澳门',    ),  ]),
  DataBean(    '澳大利亚',  ),
];



final List<DataBean> zxs=[  DataBean('北京'),  DataBean(    '上海' ),  DataBean(    '天津' ),  DataBean(    '重庆'  ),];
final List<DataBean> zzq=[  DataBean(  '新疆',),  DataBean(    '西藏',  ),  DataBean(    '广西',  ),  DataBean(    '宁夏',  ),  DataBean(    '内蒙古',  ),];
final List<DataBean> hlj=[ DataBean(  '哈尔滨',),  DataBean(    '大庆',  ),  DataBean(    '齐齐哈尔',  ),  DataBean(    '佳木斯',  ),];
final List<DataBean> sjxz=[
  DataBean(    '吉林',  ),
  DataBean(    '辽宁',  ),
  DataBean(    '河北',  ),
  DataBean(    '山东',  ),
  DataBean(    '江苏',  ),
  DataBean(    '安徽',  ),
  DataBean(    '浙江',  ),
  DataBean(    '福建',  ),
  DataBean(    '广东',  ),
  DataBean(    '海南',  ),
  DataBean(    '云南',  ),
  DataBean(    '湖南',  ),
  DataBean(    '贵州',  ),
  DataBean(    '四川',  ),
  DataBean(    '湖北',  ),
  DataBean(    '河南',  ),
  DataBean(    '山西',  ),
  DataBean(    '河南',  ),
  DataBean(    '陕西',  ),
  DataBean(    '甘肃',  ),
  DataBean(    '青海',  ),
  DataBean(    '江西',  ),
  DataBean(    '台湾',  ),
];
class DataBean {
  final String name;
  final List<DataBean> children;

  // children 默认初始化
  DataBean(this.name, [this.children = const <DataBean>[]]);
}
