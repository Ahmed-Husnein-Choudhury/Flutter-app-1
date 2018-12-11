package com.bholdhealth.medicaid.database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by dmitry on 15.08.17.
 */

public class UsersHelper extends SQLiteOpenHelper {

    private static final String CREATE_USERS_TABLE = "CREATE TABLE " + com.bholdhealth.medicaid.Models.Users.TABLE_NAME
            + " (" + com.bholdhealth.medicaid.Models.Users.ID + " INTEGER PRIMARY KEY, "
            + com.bholdhealth.medicaid.Models.Users.NAME + " TEXT, "
            + com.bholdhealth.medicaid.Models.Users.PATH + " TEXT, "
            + com.bholdhealth.medicaid.Models.Users.PHRASE + " TEXT, "
            + com.bholdhealth.medicaid.Models.Users.TIME + " LONG"
            + " )";

    private static final int VERSION = 1;
    private static final String DB_NAME = "MainDatabase.db";
    private static final String SQL_DELETE_ENTRIES =
            "DROP TABLE IF EXISTS " + com.bholdhealth.medicaid.Models.Users.TABLE_NAME;

    public UsersHelper(Context context) {
        super(context, DB_NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL(CREATE_USERS_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        sqLiteDatabase.execSQL(SQL_DELETE_ENTRIES);
        onCreate(sqLiteDatabase);
    }
}
