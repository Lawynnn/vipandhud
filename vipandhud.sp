#define PLUGIN_AUTHOR "Lawyn"
#define PLUGIN_VERSION "1.3"

#include <sourcemod>
#include <sdktools>

#define MODEL_VIP "models/player/custom_player/monsterko/inori_yuzuriha/inori.mdl"

public Plugin myinfo = 
{
	name = "[NEVERGO] VIP+HUD",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = "https://nevergo.ro"
};

public void OnPluginStart()
{
	Handle hudtimer = CreateTimer(1.0, timerhud, _, TIMER_REPEAT);
	HookEvent("player_spawn", eventspawn);
}

public Action eventspawn(Handle event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if(GetUserFlagBits(client) & ADMFLAG_CUSTOM1)
	{
		SetEntityHealth(client, 150);
		SetEntProp(client, Prop_Data, "m_ArmorValue", 110, 1 );
		AddFileToDownloadsTable(MODEL_VIP);
		PrecacheModel(MODEL_VIP ,true);
		SetEntityModel(client, MODEL_VIP);
	}
}

public Action timerhud(Handle hudtimer)
{
	for (int i = 1; i < MaxClients; i++)
	{
		if(IsClientInGame(i))
		{
			if(GetUserFlagBits(i) & ADMFLAG_CUSTOM1 == ADMFLAG_CUSTOM1)
			{
				SetHudTextParams(-1.0, 0.1, 5.0, 196, 0, 0, 255, 0, 0.1, 0.1, 0.1);
				ShowHudText(i, 5, "ARENA.NEVERGO.RO\nVIP: Ai vip");
			}
			else
			{
				SetHudTextParams(-1.0, 0.1, 5.0, 196, 0, 0, 255, 0, 0.1, 0.1, 0.1);
				ShowHudText(i, 5, "ARENA.NEVERGO.RO\nVIP: Nu ai vip");
			}
		}
	}
}
