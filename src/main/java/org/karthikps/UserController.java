package org.karthikps;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {
	
	private List<User> Users;
	public UserController() {
		Users = new ArrayList<User>();
	}

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();
    @Autowired
    UserRepository userRepository;

    @RequestMapping(method = RequestMethod.POST)
    public String post(@RequestBody User user) {
    	//User newUser = new User(user.getFirstname(),user.getFirstname(),user.getDob(),user.getPhonenumber(), user.getEmail());
    	//Users.add(newUser);
    	//System.out.println("New Object added. Total size:" + Users.size());
    	userRepository.save(user);
    	return "Executed";
    }
}