class ContactRequest {
  late final String fullName;
  late final String email;
  late final String content;

  ContactRequest({required this.fullName, required this.email, required this.content});

  String toString(){
    return  '$fullName - $email $content';
  }
}
