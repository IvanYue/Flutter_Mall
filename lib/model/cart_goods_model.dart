import 'package:json_annotation/json_annotation.dart';

part 'cart_goods_model.g.dart';

@JsonSerializable()
class CartGoodsModel extends Object {

	@JsonKey(name: 'name')
	String name;

	@JsonKey(name: 'price')
	double price;

	@JsonKey(name: 'id')
	int id;

	@JsonKey(name: 'count')
	String count;

	@JsonKey(name: 'imag')
	String imag;

  @JsonKey(name: 'selected')
	bool selected;

	CartGoodsModel(this.name,this.price,this.id,this.count,this.imag,this.selected);

	factory CartGoodsModel.fromJson(Map<String, dynamic> srcJson) => _$CartGoodsModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$CartGoodsModelToJson(this);

}
