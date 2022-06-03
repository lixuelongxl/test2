<%@ WebHandler Language="C#" Class="GameHelperHandler" %>

using System;
using System.Web;

public class GameHelperHandler : IHttpHandler {
    public BLL.GRecoderBLL bll = new BLL.GRecoderBLL();
    public void ProcessRequest (HttpContext context) {

        string type = context.Request.Params["type"];
        string phone=context.Request.Form["phone"];
        switch (type)
        { 
            
               case "q":
                IsNumberExit(phone);
                break;
                
        }
        
    }

    /// <summary>
    /// 判断是否已经获奖
    /// </summary>
    /// <param name="phone"></param>
    public void IsNumberExit(string phone)
    {

        
        if (bll.Exists(phone))
        {
            Common.AjaxMsgHelper.AjaxMsg("ok","当前已经获奖！");
        }
        else 
        {
            Common.AjaxMsgHelper.AjaxMsg("no", "当前没有该记录！");
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}