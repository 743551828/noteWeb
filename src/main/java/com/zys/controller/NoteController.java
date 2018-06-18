package com.zys.controller;

import com.zys.entity.Note;
import com.zys.service.NoteService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class NoteController {

    @Resource
    private NoteService noteService;

    @ResponseBody
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public List save(@RequestBody Note event) {
        try {
            noteService.save(event);
            return noteService.findDataSource();
        } catch (Exception e) {
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "findAll", method = RequestMethod.GET)
    public List findDataSource() {
        try {
            return noteService.findDataSource();
        } catch (Exception e) {
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public List update(@RequestBody Note event) {
        try {
            noteService.update(event);
            return noteService.findDataSource();
        } catch (Exception e) {
            return null;

        }
    }

    @ResponseBody
    @RequestMapping(value = "delete",method = RequestMethod.POST)
    public List delete(@RequestBody Note event){
        try {
            noteService.delete(event);
            return noteService.findDataSource();
        }catch (Exception e){
            return null;
        }
    }
}
