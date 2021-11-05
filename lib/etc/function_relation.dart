//
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

  if (pirid == 0)
    retData = '00' + retData;
  else if (pirid == 1)
    retData = '0' + retData;

  if (tenP == 1)
    retData = retData + '00';
  else if (tenP == 2)
    retData = retData + '0';
  else if (tenP == 4)
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
