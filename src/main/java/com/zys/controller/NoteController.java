package com.zys.controller;

import com.zys.entity.Note;
import com.zys.service.NoteService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class NoteController {

    @Resource
    private NoteService noteService;

    @ResponseBody
    @RequestMapping(value = "save",method = RequestMethod.POST)
    public String save(Note note){
        noteService.save(note);
        return "ok";
    }

}
