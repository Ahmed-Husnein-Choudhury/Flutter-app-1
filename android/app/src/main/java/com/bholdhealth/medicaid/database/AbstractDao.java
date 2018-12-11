package com.bholdhealth.medicaid.database;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.bholdhealth.medicaid.Models.Users;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by dmitry on 15.08.17.
 */

abstract public class AbstractDao<Model> implements com.bholdhealth.medicaid.database.Dao<Model> {

    protected final com.bholdhealth.medicaid.database.UsersHelper helper;

    public AbstractDao(Context context) {
        helper = new com.bholdhealth.medicaid.database.UsersHelper(context);
    }

    @Override
    public void insert(Model item) {
        SQLiteDatabase db = helper.getWritableDatabase();
        db.insert(Users.TABLE_NAME, null, prepare(item));
        db.close();
    }

    abstract protected String[] fields();

    abstract protected String tableName();

    @Override
    public List<Model> all() {
        List<Model> models = new ArrayList<>();
        SQLiteDatabase db = helper.getReadableDatabase();

        Cursor cursor = db.query(
                tableName(),  // The table to query
                fields(),                               // The columns to return
                null,                                // The columns for the WHERE clause
                null,                            // The values for the WHERE clause
                null,                                     // don't group the rows
                null,                                     // don't filter by row groups
                null                                 // The sort order
        );
        if (cursor.moveToFirst()) {
            do {
                models.add((Model) parseDb(cursor));
            } while (cursor.moveToNext());
        }
        db.close();
        return models;
    }

    @Override
    public void clear() {
        SQLiteDatabase db = helper.getWritableDatabase();
        db.delete(tableName(), null, null);
        db.close();
    }

    public abstract ContentValues prepare(Users item);

    public abstract Users parseDb(Cursor cursor);
}
