package com.bholdhealth.medicaid.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.text.TextUtils;

import com.bholdhealth.medicaid.Models.Users;


public class UsersDao extends AbstractDao<Users> {

    public UsersDao(Context context) {
        super(context);
    }


    @Override
    public void insert(Users item) {
        SQLiteDatabase db = helper.getWritableDatabase();
        db.insert(Users.TABLE_NAME, null, prepare(item));
        db.close();
    }

    @Override
    protected String[] fields() {
        return new String[]{Users.ID, Users.NAME, Users.PATH, Users.TIME, Users.PHRASE};
    }

    @Override
    protected String tableName() {
        return Users.TABLE_NAME;
    }

    @Override
    public ContentValues prepare(Users item) {
        ContentValues values = new ContentValues();
        values.put(Users.NAME, item.getName());
        values.put(Users.PATH, item.getPath());
        values.put(Users.TIME, item.getTime());
        values.put(Users.PHRASE, item.getPhrase());
        return values;
    }

    @Override
    public Users parseDb(Cursor cursor) {
        Users users = new Users();
        users.setId(cursor.getLong(cursor.getColumnIndex(Users.ID)));
        users.setName(cursor.getString(cursor.getColumnIndex(Users.NAME)));
        users.setPath(cursor.getString(cursor.getColumnIndex(Users.PATH)));
        users.setTime(cursor.getLong(cursor.getColumnIndex(Users.TIME)));
        users.setPhrase(cursor.getString(cursor.getColumnIndex(Users.PHRASE)));
        return users;
    }

    public Users findByName(String name) {
        if (TextUtils.isEmpty(name)) {
            return null;
        }
        SQLiteDatabase db = helper.getReadableDatabase();
        String selection = Users.NAME + " = ?";
        String[] selectionArgs = {name};
        Cursor cursor = db.query(tableName(), fields(), selection, selectionArgs, null, null, null, "1");
        if (cursor.moveToFirst()) {
            return parseDb(cursor);
        }
        return null;
    }

    public void deleteUser(){
        SQLiteDatabase db=helper.getWritableDatabase();
        db.delete(Users.TABLE_NAME,null,null);
        db.execSQL("DROP TABLE IF EXISTS "+Users.TABLE_NAME);
    }
}
