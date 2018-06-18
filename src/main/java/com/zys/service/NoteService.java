package com.zys.service;

import com.zys.dao.NoteDao;
import com.zys.entity.Note;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

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

    /**
     * 查找所有
     * @return
     */
    public List findDataSource(){
        return noteDao.findDataSource();
    }

    /**
     * 更新
     * @param note
     */
    public void update(Note note){
        noteDao.update(note);
    }

    /**
     * 删除
     * @param note
     */
    public void delete(Note note){
        noteDao.delete(note);
    }

}
