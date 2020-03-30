import discord
from discord.ext import commands
from discord.ext.commands import context, errors
import requests
import logging
import os
import sys
import asyncio
from dotenv import load_dotenv
load_dotenv()

Bot = commands.Bot(command_prefix="!", description="bot", case_insensitive=True, owner_id=261401343208456192)

# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger('discord')
# logger.setLevel(logging.DEBUG)
# handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')
# handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
# logger.addHandler(handler)
@Bot.event
async def on_ready():
      print(
            f"Discord.py: {discord.__version__}\n"
            f"Python: {sys.version.split(' ')[0]}\n"
            f"Connected as {Bot.user}\n"
      )
      # Bot.load_extension('cogs.ping')

# @Bot.event
# async def on_message(message):
#       pass


def loadAllCogs(bot):
      # loads cogs
      for cog in os.listdir("cogs"):
            if cog.endswith("py"):
                  filename = cog.split(".")[0]
                  try:
                        bot.load_extension(f"cogs.{filename}")
                        print(f"[Cogs] Cog Loaded: {filename}")
                  except (errors.ExtensionNotFound, errors.ExtensionAlreadyLoaded, errors.NoEntryPointError,
                        errors.ExtensionFailed) as e:
                        print(f"[Cogs] Error loading cog: {filename}; Error: {e}")

loadAllCogs(Bot)
Bot.run(os.getenv("token"))
Bot.change_presence(activity=discord.ActivityType.playing, status="with my python")