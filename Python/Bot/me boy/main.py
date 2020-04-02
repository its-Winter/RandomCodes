import discord
from discord import message
from discord.ext import commands
from discord.ext.commands import context, errors
from dotenv import load_dotenv
import json
import os
import platform
import asyncio
import time

load_dotenv()

Bot = commands.Bot(command_prefix="!", description="bot", case_insensitive=True, owner_id=261401343208456192)

globalvars = {
      "bot": {
            "user": "",
            "username": "",
            "token": os.getenv("token"),
            "appinfo": "",
            "owner": ""
      },
      "discord": {
            "name": "discord",
            "version": discord.__version__,
      },
      "python": {
            "name": "python",
            "version": platform.python_version()
      }
}

@Bot.event
async def on_ready():
      global globalvars
      globalvars['bot']['user'] = Bot.user
      globalvars['bot']['username'] = Bot.user.name + "#" + Bot.user.discriminator
      globalvars['bot']['appinfo'] = await Bot.application_info()
      globalvars['bot']['owner'] = globalvars['bot']['appinfo'].owner
      print(
            "\n"
            f"Discord.py:   {globalvars['discord']['version']}\n"
            f"Python:       {globalvars['python']['version']}\n"
            f"Connected as  {globalvars['bot']['username']}\n"
            f"Owner:        {globalvars['bot']['owner']}\n"
      )
      # json.dump(globalvars, 'global.json', indent=6)


      # print('Bot is ready to go.. What do you want the status of the bot to start out as?')
      # activity = input('> ')
      # print('Any message?')
      # message = input('> ')
      await Bot.change_presence(activity=discord.Activity(type=discord.ActivityType.playing, name="with myself."))



@Bot.event
async def on_message(message):

      await Bot.process_commands(message)


def loadallcogs(bot):
      # loads cogs
      for cog in os.listdir("cogs"):
            if cog.endswith("py"):
                  filename = cog.split(".")[0]
                  if filename in ["globals", "Audio", "decorators"]:
                        continue
                  try:
                        bot.load_extension(f"cogs.{filename}")
                        print(f"[Cogs] Cog Loaded: {filename}")
                  except (errors.ExtensionNotFound, errors.ExtensionAlreadyLoaded, errors.NoEntryPointError,
                        errors.ExtensionFailed) as e:
                        print(f"[Cogs] Error loading cog: {filename}; Error: {e}")

def getglobal(*args):
      pass


def checkGlobals():
      if os.path.exists('global.json') is False:
            print("Globals.json is not found. Writing...")
            with open('global.json', 'r+') as j:
                  json.dump(globalvars, j, indent=6)
      with open('globals.json', 'r+') as j:
            try:
                  data = json.load(j, indent=6)
            except FileNotFoundError:
                  print("Globals.json is not found. Writing...")
                  json.dump(globalvars, j, indent=6)


loadallcogs(Bot)
token = globalvars['bot']['token']
Bot.run(token)
