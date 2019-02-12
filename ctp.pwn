/*
    IGTASAMP - CTP传送功能

    使用说明:
        /ctp : 开启/关闭CTP权限(当玩家进入服务器后自动设置为关闭CTP权限)
        /tp [玩家ID] TP到ID为[玩家ID]的玩家附近

    开发 By IGTA褪色

    最后修改时间: 2019.2.13 1:20
*/

#include <a_samp>
#include <izcmd>
#include <sscanf>

#define COLOR_GREEN 0x00FF40C8

public OnFilterScriptInit()
{
    printf("-----| CTP传送系统 |-----");
    printf("-----|   By 褪色   |-----");
    return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientMessage((playerid),COLOR_GREEN,"[CTP传送]服务器默认为您关闭CTP权限");
    return 1;
}

COMMAND:ctp(playerid)
{
    if(!GetPVarInt(playerid,"is_ctp"))
    {
        SetPVarInt(playerid,"is_ctp",!GetPVarInt(playerid,"is_ctp"));
        SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]您开启CTP传送权限");
        return 1;
    }
    DeletePVar(playerid,"is_ctp");
    SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]您关闭CTP传送权限"); 
    return 1;
}

COMMAND:tp(playerid,params[])
{
    new string[128],string1[128],name[64],name1[64],pid[18];
    if(sscanf(params,"s[18]",pid)) return SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]传送至一个玩家附近;/tp [玩家ID]");
    if(!GetPVarInt(playerid,"is_ctp")) return SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]您暂未开启CTP权限,请输入/ctp进行开启");
    if(!GetPlayerName(strval(pid),name1,sizeof(name1))) return SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]该玩家不在线");
    if(!GetPVarInt(strval(pid),"is_ctp")) return SendClientMessage(playerid,COLOR_GREEN,"[CTP传送]该玩家没有开启CTP权限,请私聊联系开启!(/ctp)");
    GetPlayerName(playerid,name,sizeof(name)); //获取传送者昵称
    GetPlayerName(strval(pid),name1,sizeof(name1)); //获取被传送者昵称
    format(string,sizeof(string),"[CTP传送]您已传送至玩家%s(%d)的附近",name1,strval(pid));
    format(string1,sizeof(string1),"[CTP传送]玩家%s(%d)传送至你的附近",name,playerid);
    new Float:x,Float:y,Float:z;
    GetPlayerPos(strval(pid),x,y,z);
    SetPlayerPos(playerid,x,y,z+10);
    SendClientMessage(playerid,COLOR_GREEN,string);
    SendClientMessage(strval(pid),COLOR_GREEN,string1);
    return 1;
}
