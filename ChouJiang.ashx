<%@ WebHandler Language="C#" Class="ChouJiang" %>

using System;
using System.Web;
using BLL;
using Common;

public class ChouJiang : IHttpHandler {
    protected BLL.GamuStatuBLL bll = new BLL.GamuStatuBLL();
    protected BLL.UserBLL usrbll = new BLL.UserBLL();
    protected BLL.GRecoderBLL rbll = new BLL.GRecoderBLL();
    public void ProcessRequest (HttpContext context) {
        String type = context.Request.Params["type"];
        switch (type)
        { 
            case "s"://点击开始事件
                BeginGame();
                break;
            case "t":
                EndGate();
                break;
            case "q":
                QuaryGameState();
                break;
            case "d":
                Delete();
                break;
        }
    }
    
    //点击开始抽奖处理事件

    protected void BeginGame()
    {
    try
    {    //清除抽奖状态
        bll.ClearData();      
		bll.DoStart();
        AjaxMsgHelper.AjaxMsg("ok","活动开始了！");
	}
	catch (Exception)
	{
		 
		throw;
	}
       
    
    }

    protected void EndGate()
    {
        try
        {
            bll.EndGame();
            AjaxMsgHelper.AjaxMsg("ok", "抽奖停止了！");
        }
        catch (Exception)
        {
            
            throw;
        }
        
    
    }
    //查询游戏开始状态
    protected void QuaryGameState()
    {
        if (bll.IsGameStart())
        {
            AjaxMsgHelper.AjaxMsg("s","抽奖开始！");
        }
        else
        {
            AjaxMsgHelper.AjaxMsg("t", "抽奖还没开始奥！");
        }
    
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
    //执行删除
    public void Delete()
    {
        string phone = HttpContext.Current.Request["phone"];
        string jiangci = HttpContext.Current.Request["jiangci"];
        
        Model.GRecoder model=new Model.GRecoder();
        model.phone=phone;
        model.jiangci=jiangci;
        usrbll.Delete(phone);
        rbll.Add(model);
    
    
    }
    

}