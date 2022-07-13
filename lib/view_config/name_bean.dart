class NameBean {
  final String name;
  final List<NameBean> children;

  // children 默认初始化
  NameBean(this.name, [this.children = const <NameBean>[]]);
}

final List<NameBean> data = <NameBean>[
  NameBean('中国'),
  NameBean('老挝'),
  NameBean('越南'),
  NameBean('直辖市', [
    NameBean('北京'),
    NameBean(
      '上海',
    ),
    NameBean(
      '天津',
    ),
    NameBean(
      '重庆',
    ),
  ]),
  NameBean('自治区', [
    NameBean(
      '新疆',
    ),
    NameBean(
      '西藏',
    ),
    NameBean(
      '广西',
    ),
    NameBean(
      '宁夏',
    ),
    NameBean(
      '内蒙古',
    ),
  ]),
  NameBean('省级行政单位', [
    NameBean('黑龙江', [
      NameBean(
        '哈尔滨',
      ),
      NameBean(
        '大庆',
      ),
      NameBean(
        '齐齐哈尔',
      ),
      NameBean(
        '佳木斯',
      ),
    ]),
    NameBean(
      '吉林',
    ),
    NameBean(
      '辽宁',
    ),
    NameBean(
      '河北',
    ),
    NameBean(
      '山东',
    ),
    NameBean(
      '江苏',
    ),
    NameBean(
      '安徽',
    ),
    NameBean(
      '浙江',
    ),
    NameBean(
      '福建',
    ),
    NameBean(
      '广东',
    ),
    NameBean(
      '海南',
    ),
    NameBean(
      '云南',
    ),
    NameBean(
      '湖南',
    ),
    NameBean(
      '贵州',
    ),
    NameBean(
      '四川',
    ),
    NameBean(
      '湖北',
    ),
    NameBean(
      '河南',
    ),
    NameBean(
      '山西',
    ),
    NameBean(
      '河南',
    ),
    NameBean(
      '陕西',
    ),
    NameBean(
      '甘肃',
    ),
    NameBean(
      '青海',
    ),
    NameBean(
      '江西',
    ),
    NameBean(
      '台湾',
    ),
  ]),
  NameBean('特别行政区', <NameBean>[
    NameBean(
      '香港',
    ),
    NameBean(
      '澳门',
    ),
  ]),
  NameBean(
    '澳大利亚',
  ),
];
