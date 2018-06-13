package com.zys.service;

import com.zys.dao.NoteDao;
import com.zys.entity.Note;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Transactional
@Service
public class NoteService {

    @Resource
    private NoteDao noteDao;

    /**
     * 添加一个note
     * @param note
     */
    public void save(Note note){
        noteDao.save(note);
    }

}
