package com.tshop.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.tshop.model.DataLayoutMaster;
import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class DashboardController {
	
	@Autowired
	SessionService sessionService;
	
	static DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	
	static {
		dataLayoutAdmin.setHeading_text("Dashboard");
		dataLayoutAdmin.setTitle("Tshop");
	}
	
	@GetMapping("")
	public String admin(Model model) {
		
		Map<String, Object> objs = new HashMap<String, Object>();		
		objs.put("dashboardActive", "active");
		dataLayoutAdmin.setView("dashboard/dashboard.jsp");
		dataLayoutAdmin.setObjs(objs);
		
		model.addAttribute("content", dataLayoutAdmin);
		return "admin/dashboard_layout";
	}
}
