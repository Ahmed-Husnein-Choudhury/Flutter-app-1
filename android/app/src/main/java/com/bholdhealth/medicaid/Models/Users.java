package com.bholdhealth.medicaid.Models;

public class Users {

    public static final String TABLE_NAME = "users";
    public static final String ID = "_ID";
    public static final String NAME = "name";
    public static final String PATH = "path";
    public static final String TIME = "time";
    public static final String PHRASE = "phrase";

    private long id;
    private String name;
    private String path;
    private String phrase;
    private long time;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public String getPhrase() {
        return phrase;
    }

    public void setPhrase(String phrase) {
        this.phrase = phrase;
    }
}
