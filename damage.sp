public Action Hook_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
  if (!g_EnableFriendlyFire && (C5_PUG_IsMatchLive() || g_GameState == GameState_KnifeRound))
  {
    if (attacker < 1 || attacker > MaxClients || attacker == victim || weapon < 1)
    {
      return Plugin_Continue;
    }
    
    if (GetClientTeam(victim) == GetClientTeam(attacker))
    {
      return Plugin_Handled;
    }
    
    return Plugin_Continue;
  }
  if(C5_PUG_IsWarmup()) return Plugin_Handled;

  return Plugin_Continue;
}

public void OnClientDisconnect(int client)
{
  UnHookOnTakeDamage(client);
}

public void OnClientPutInServer(int client)
{
  HookOnTakeDamage(client);
}

void HookOnTakeDamage(int client)
{
  if (!IsValidClient(client)) return;
  SDKHook(client, SDKHook_OnTakeDamage, Hook_OnTakeDamage);
}

void UnHookOnTakeDamage(int client)
{
  if (!IsValidClient(client)) return;
  SDKUnhook(client, SDKHook_OnTakeDamage, Hook_OnTakeDamage);
}
