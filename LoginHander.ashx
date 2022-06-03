<%@ WebHandler Language="C#" Class="LoginHander" %>

using System;
using System.Web;
using Model;
using BLL;
using Common;
using System.Collections.Generic;
public class LoginHander : IHttpHandler {
    protected UserBLL bll = new UserBLL();
    public void ProcessRequest (HttpContext context) {
        String type = context.Request.Params["type"];
        switch (type)
        { 
            case "l"://判断当前用户是否已经提交信息
                IsExit(context);
                break;
            case "q":
              // LoadName();
              LoadName2(context);
                break;
        }
    }

    protected void IsExit(HttpContext context)
    {
        String uname = context.Request.Form["uname"];
        String uphone = context.Request.Form["uphone"];
        User model = bll.GetModel(uphone);
        if (model != null)//用户已经注册
        {
            AjaxMsgHelper.AjaxMsg("y","您的信息已经提交！");
            
            
        }
        else//用户未注册
        {
            User newmodel = new User();
            newmodel.uname = uname;
            newmodel.uphone = uphone;
            newmodel.shaknum = 0;
            bll.Add(newmodel);
            AjaxMsgHelper.AjaxMsg("n","提交成功!");
             
        }
    
    }
    //加载用户列表
    protected void LoadName()
    {
       
        List<User> list = bll.GetModelList("");
        if (list != null)
        {
            String listjson = DataHelper.ObjToJson(list);
            AjaxMsgHelper.AjaxMsg("ok","名单加载成功！",listjson);
        }
    
    }

    protected void LoadName2(HttpContext context)
    {
        List<User> list = bll.GetModelList("");
      
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
       // sb.Append("[");
   
      foreach(User model in list)
        {
          
            sb.Append(model.uphone+",");
            
        }
      // string s = sb.ToString().Substring(0, sb.Length - 1) + "]";
       context.Response.Write(sb.ToString().Substring(0,sb.Length-1));
    
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}