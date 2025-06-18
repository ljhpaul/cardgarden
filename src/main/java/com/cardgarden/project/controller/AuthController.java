package com.cardgarden.project.controller;

import com.cardgarden.project.model.sample.SampleDTO;
import com.cardgarden.project.model.sample.SampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    SampleService sampleService;
    
    // 0. �����̿� �׽�Ʈ
    @GetMapping("/testPage")
    public String testPage(Model model) {
        List<SampleDTO> list = sampleService.selectAll();
        model.addAttribute("list", list);
        return "";  // /WEB-INF/views/sample/list.jsp
    }
    
    // 1. ��ü ����Ʈ
    @GetMapping("/list")
    public String list(Model model) {
        List<SampleDTO> list = sampleService.selectAll();
        model.addAttribute("list", list);
        return "sample/list";  // /WEB-INF/views/sample/list.jsp
    }

    // 2. ����ȸ (id��)
    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        SampleDTO dto = sampleService.selectById(id);
        model.addAttribute("dto", dto);
        return "sample/detail"; // /WEB-INF/views/sample/detail.jsp
    }

    // 3. ��� ��
    @GetMapping("/addForm")
    public String addForm() {
        return "sample/addForm"; // /WEB-INF/views/sample/addForm.jsp
    }

    // 3-1. ��� ó��
    @PostMapping("/add")
    public String add(@ModelAttribute SampleDTO dto) {
        sampleService.insert(dto);
        return "redirect:/sample/list";
    }

    // 4. ���� ��
    @GetMapping("/editForm")
    public String editForm(@RequestParam int id, Model model) {
        SampleDTO dto = sampleService.selectById(id);
        model.addAttribute("dto", dto);
        return "sample/editForm"; // /WEB-INF/views/sample/editForm.jsp
    }

    // 4-1. ���� ó��
    @PostMapping("/edit")
    public String edit(@ModelAttribute SampleDTO dto) {
        sampleService.update(dto);
        return "redirect:/sample/list";
    }

    // 5. ���� ó��
    @GetMapping("/delete")
    public String delete(@RequestParam int id) {
        sampleService.delete(id);
        return "redirect:/sample/list";
    }
}
