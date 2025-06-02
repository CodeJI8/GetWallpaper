class PhotosModel {
  final String src;


  PhotosModel({
    required this.src,

  });

  factory PhotosModel.fromApi2App(Map<String, dynamic> json) {
    return PhotosModel(
      src: json['src']?['portrait'], // Provide fallback empty string
     // More user-friendly
    );
  }
}
