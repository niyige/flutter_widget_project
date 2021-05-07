/**
 * 工具
 */

Map queryToMap(String args) {
  // Log('args ======  $args');
  if (null == args || args.isEmpty) return Map<String, String>();
  var array = args.split('&');
  Map result = Map();
  array
      .asMap()
      .forEach((index, ele) => {result[ele.split('=')[0]] = ele.split('=')[1]});
  return result;
}

isEmpty(value) {
  if (value is List) return null == value || value.length == 0;
  if (value is String) return null == value || '' == value;
  return null == value;
}

notEmpty(value) {
  if (value is List) return null != value && value.length > 0;
  if (value is String) return null != value && '' != value;
  return null != value;
}
