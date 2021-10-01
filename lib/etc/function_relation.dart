//データ加工関数
int  periodPosition(String data)
{
  return data.indexOf('.');
}
int  collonPosition(String data)
{
  return data.indexOf(':');
}
String funcZeroAdd(String data)
{
  String retData = data;
  int pirid =  periodPosition(retData);
  int mojisu = retData.length;
  int tenP = mojisu - pirid;
  //整数一桁
  if (pirid == 0)
    retData = '00' + retData;
  else if (pirid == 1)
    retData = '0' + retData;
  //小数点以下
  if (tenP == 1)
    retData = retData + '00';
  else if (tenP == 2)
    retData = retData + '0';
  else if (tenP == 4) //切り捨て
    retData = retData.substring(0, mojisu-1);
  return retData;
}

String funcDataSCharAdd(String data)
{
  if (data == '')  return data;
  else
  {
    data = funcZeroAdd(data)  + 's';
    return data;
  }
}
