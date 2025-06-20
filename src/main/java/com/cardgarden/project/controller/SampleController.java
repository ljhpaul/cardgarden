package com.cardgarden.project.controller;

import com.cardgarden.project.model.sample.SampleDTO;
import com.cardgarden.project.model.sample.SampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/sample")
public class SampleController {

    @Autowired
    SampleService sampleService;
    
    // 0. 레이아웃 테스트
    @GetMapping("/testPage")
    public String testPage(Model model) {
        List<SampleDTO> list = sampleService.selectAll();
        model.addAttribute("list", list);
        return "";  // /WEB-INF/views/sample/list.jsp
    }
    
    // 1. 전체 리스트
    @GetMapping("/list")
    public String list(Model model) {
        List<SampleDTO> list = sampleService.selectAll();
        model.addAttribute("list", list);
        return "sample/list";  // /WEB-INF/views/sample/list.jsp
    }

    // 2. 상세조회 (id로)
    @GetMapping("/detail")
    public String detail(@RequestParam int id, Model model) {
        SampleDTO dto = sampleService.selectById(id);
        model.addAttribute("dto", dto);
        return "sample/detail"; // /WEB-INF/views/sample/detail.jsp
    }

    // 3. 등록 폼
    @GetMapping("/addForm")
    public String addForm() {
        return "sample/addForm"; // /WEB-INF/views/sample/addForm.jsp
    }

    // 3-1. 등록 처리
    @PostMapping("/add")
    public String add(@ModelAttribute SampleDTO dto) {
        sampleService.insert(dto);
        return "redirect:/sample/list";
    }

    // 4. 수정 폼
    @GetMapping("/editForm")
    public String editForm(@RequestParam int id, Model model) {
        SampleDTO dto = sampleService.selectById(id);
        model.addAttribute("dto", dto);
        return "sample/editForm"; // /WEB-INF/views/sample/editForm.jsp
    }

    // 4-1. 수정 처리
    @PostMapping("/edit")
    public String edit(@ModelAttribute SampleDTO dto) {
        sampleService.update(dto);
        return "redirect:/sample/list";
    }

    // 5. 삭제 처리
    @GetMapping("/delete")
    public String delete(@RequestParam int id) {
        sampleService.delete(id);
        return "redirect:/sample/list";
    }
}
