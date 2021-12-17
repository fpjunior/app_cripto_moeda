import 'package:flutter_aula1/models/produto.dart';
import 'package:hive/hive.dart';

class MoedaHiveAdapter extends TypeAdapter<Produto> {
  @override
  final typeId = 0;

  @override
  Produto read(BinaryReader reader) {
    return Produto(
      urlImage: reader.readString(),
      nome: reader.readString(),
      descricao: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Produto obj) {
    writer.writeString(obj.urlImage);
    writer.writeString(obj.nome);
    writer.writeString(obj.descricao);
    writer.writeDouble(obj.preco);
  }
}
