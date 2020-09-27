



/**
 *  根据条件设置图标类型
 */
Uri selectImagesByType(int tYPE, double brightness, int warningState) {
  if (tYPE == 1) {
    /// 电箱
    return Uri.parse('images/ebox.png');
  } else if (tYPE == 2) {
    /// 路灯
    // 检查报警
    if (warningState != 0) {
      return Uri.parse('images/light_warning.png');
    }
    // 检查亮灯
    if (brightness != 0) {
      return Uri.parse('images/light_on.png');
    } else {
      return Uri.parse('images/light_off.png');
    }
  } else if (tYPE == 3) {
    // 未知
    return Uri.parse('images/ebox.png');
  } else {
    /// 报警器
    return Uri.parse('images/test_icon.png');
  }
}





/**
 * 设备被选中时根据设备类型设置图标
 */
selectIcon(int type) {



}

