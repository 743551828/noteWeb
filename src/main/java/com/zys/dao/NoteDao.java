package com.zys.dao;

import com.zys.entity.Note;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoteDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void save(Note note){
        getSession().save(note);
    }

    public List findDataSource(){
        String hql="from Note ";
        return getSession().createQuery(hql).list();
    }

    public void update(Note note){
        getSession().update(note);
    }

    public void delete(Note note){
        getSession().delete(note);
    }
}
