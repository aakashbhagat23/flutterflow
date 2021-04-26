import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'recipe_record.g.dart';

abstract class RecipeRecord
    implements Built<RecipeRecord, RecipeRecordBuilder> {
  static Serializer<RecipeRecord> get serializer => _$recipeRecordSerializer;

  @nullable
  String get image;

  @nullable
  String get title;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  Timestamp get createdAt;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RecipeRecordBuilder builder) => builder
    ..image = ''
    ..title = ''
    ..description = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('recipe');

  static Stream<RecipeRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RecipeRecord._();
  factory RecipeRecord([void Function(RecipeRecordBuilder) updates]) =
      _$RecipeRecord;
}

Map<String, dynamic> createRecipeRecordData({
  String image,
  String title,
  String description,
  Timestamp createdAt,
  DocumentReference user,
}) =>
    serializers.serializeWith(
        RecipeRecord.serializer,
        RecipeRecord((r) => r
          ..image = image
          ..title = title
          ..description = description
          ..createdAt = createdAt
          ..user = user));

RecipeRecord get dummyRecipeRecord {
  final builder = RecipeRecordBuilder()
    ..image = dummyImagePath
    ..title = dummyString
    ..description = dummyString
    ..createdAt = dummyTimestamp;
  return builder.build();
}

List<RecipeRecord> createDummyRecipeRecord({int count}) =>
    List.generate(count, (_) => dummyRecipeRecord);
