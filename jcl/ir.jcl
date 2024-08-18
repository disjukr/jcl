struct JclIr {
  modules: Module[string], // key: module path (jcl.ast, jcl.ir, ...)
  defs: Def[string], // key: def path (jcl.ast.JclAst, jcl.ir.JclIr, ...)
}

struct Attribute {
  id: string,
  content: string,
}

struct Module {
  fileUrl?: string,
  attributes: Attribute[],
  defPaths: string[],
  imports: Import[],
}

struct Import {
  attributes: Attribute[],
  modulePath: string,
  items: ImportItem[],
}

struct ImportItem {
  name: string,
  as?: string,
}

struct Def {
  attributes: Attribute[],
  name: string,
  body: DefBody,
}

union DefBody {
  Enum(
    items: EnumItem[],
  ),
  Rpc(
    items: RpcItem[],
  ),
  Scalar(
    scalarType: Type,
  ),
  Socket(
    serverToClient: SocketItem,
    clientToServer: SocketItem,
  ),
  Struct(
    fields: StructField[],
  ),
  Union(
    discriminatorKey?: string,
    items: UnionItem[],
  ),
}

struct EnumItem {
  attributes: Attribute[],
  name: string,
  value: string,
}

struct RpcItem {
  attributes: Attribute[],
  name: string,
  stream: boolean,
  inputFields: StructField[],
  outputType: Type,
  errorType?: Type,
}

struct SocketItem {
  attributes: Attribute[],
  messageType: Type,
}

struct StructField {
  attributes: Attribute[],
  name: string,
  itemType: Type,
  nullPolicy: StructFieldNullPolicy,
}

union StructFieldNullPolicy {
  UseDefaultValue,
  Throw,
  Allow,
}

union Type {
  Plain(valueTypePath: string),
  Array(valueTypePath: string),
  Dictionary(valueTypePath: string, keyTypePath: string),
}

struct UnionItem {
  attributes: Attribute[],
  jsonKey?: string,
  name: string,
  fields: StructField[],
}
