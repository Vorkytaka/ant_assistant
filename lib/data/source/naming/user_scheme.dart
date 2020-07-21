class UsersScheme {
  static const String TABLE_NAME = "credentials";
  static const String COLUMN_NAME_ID = "id";
  static const String COLUMN_NAME_LOGIN = "login";
  static const String COLUMN_NAME_PASSWORD = "password";

  static const String EXECUTE_CREATE_TABLE = """
        CREATE TABLE ${UsersScheme.TABLE_NAME}(
          ${UsersScheme.COLUMN_NAME_ID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          ${UsersScheme.COLUMN_NAME_LOGIN} TEXT NOT NULL, 
          ${UsersScheme.COLUMN_NAME_PASSWORD} TEXT NOT NULL
          );
        """;
}
