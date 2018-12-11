package com.bholdhealth.medicaid.database;

import android.content.ContentValues;
import android.database.Cursor;

import com.bholdhealth.medicaid.Models.Users;

import java.util.List;

/**
 * Created by dmitry on 15.08.17.
 */

public interface Dao<T> {

    void insert(T item);

    List<T> all();

    void clear();

    ContentValues prepare(T item);

    Users parseDb(Cursor cursor);
}
