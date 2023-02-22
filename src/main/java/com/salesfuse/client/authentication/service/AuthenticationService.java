package com.salesfuse.client.authentication.service;

import com.salesfuse.client.authentication.payload.TokenResponse;
import com.salesfuse.client.authentication.payload.TokenRequest;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService implements UserDetailsService {

    @Autowired
    private ServletContext mcontext;

    @Autowired
    private AuthenticationServiceManager authManager;
    
    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

        String password = "";

        if (mcontext != null) {
            password = (String) mcontext.getAttribute("the_pass");
        }

        TokenRequest req = new TokenRequest();
        req.setUserName(userName);
        req.setPassword(password);
        
        TokenResponse resp = null;
        try {
            resp = authManager.login(req);
            
        } catch (Exception ex) {
            throw new UsernameNotFoundException("Exception occured while login : " + ex.getMessage());
        }

        if (resp == null || resp.getToken() == null || resp.getToken().isEmpty()) {
            throw new UsernameNotFoundException("User Not Found");
        }
        
        List<GrantedAuthority> grantList = new ArrayList<>();
       
        grantList.add(new SimpleGrantedAuthority("ROLE_" + resp.getRole()));
       
        //Defs.TOKEN = resp.getToken();
        CustomUser customUser=new CustomUser(resp.getUserId(), resp.getUserName(), passwordEncoder.encode(password), resp.getToken(), grantList, resp.getRole());
        
        return customUser;
    }
}
