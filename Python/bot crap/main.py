import discord
from discord.ext import commands
from discord.ext.commands import context, errors
import requests
import logging
import os
import sys
import asyncio
from dotenv import load_dotenv

def get_token():
      load_dotenv()
      token = os.getenv("token")
      return token

Bot = commands.Bot(command_prefix="!", description="bot", case_insensitive=True, owner_id=261401343208456192)

# logging.basicConfig(level=logging.INFO)
# logger = logging.getLogger('discord')
# logger.setLevel(logging.DEBUG)
# handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')
# handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
# logger.addHandler(handler)
@Bot.event
async def on_ready():
      print(f"Connected as {Bot.user}")
      # Bot.load_extension('cogs.ping')

@Bot.event
async def on_message(message):
      if message.author.id != Bot.user.id:
            try:
                  await message.channel.send('i see the message')
            except:
                  print('bruv')

def loadAllCogs(bot):
      # loads cogs
      for cog in os.listdir("cogs"):
            if cog.endswith("py"):
                  filename = cog.split(".")[0]
                  try:
                        bot.load_extension(f"cogs.{filename}")
                        print(f"[Cog Management] Cog Loaded: {filename}")
                  except (errors.ExtensionNotFound, errors.ExtensionAlreadyLoaded, errors.NoEntryPointError,
                        errors.ExtensionFailed) as e:
                        print(f"[Cog Management] Error loading cog: {filename}; Error: {e}")

loadAllCogs(Bot)
token = get_token()
Bot.run(token)