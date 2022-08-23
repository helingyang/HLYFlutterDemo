class CateModel{
  late List<CateItemModel> result;

  CateModel({required this.result});

  CateModel.fromJson(Map<String,dynamic> json){
    // print("CateModel$json");
    if(json["result"] != null){
      result = <CateItemModel>[];
      json["result"].forEach((v){
        // print("CateModel$v");
        result.add(CateItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CateItemModel{
  late String sId;//商品ID
  late String title;//标题
  late String status;//状态
  late String pic;//图片
  late String url;//链接

  CateItemModel({required this.sId,required this.title,
    required this.status,required this.pic,required this.url});
  CateItemModel.fromJson(Map<String,dynamic> json){
    sId = json["_id"];
    title = json["title"];
    status = json["status"];
    pic = json["pic"];
    url = json["url"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}
