import discord
from discord import message
from discord.ext import commands
from discord.ext.commands import context, errors
from discord.ext.commands import core as check
import contextlib
import os
import json
import platform
import asyncio
import arrow
from Settings import settings

bot = commands.AutoShardedBot(command_prefix=settings.prefix, description="Bot", case_insensitive=True, owner_id=settings.ownerid)

@bot.event
async def on_ready():
      print(
            f"\nDiscord.py:       {discord.__version__}\n"
            f"Python:           {platform.python_version()}\n"
            f"Connected as:     {bot.user}\n"
            f"Prefix:           {bot.command_prefix}\n"
            f"Owner:            {(await bot.application_info()).owner}\n"
      )

      bot.start_time = arrow.utcnow()
      await bot.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, ))

@bot.event
async def on_connect():
      print(f"{bot.user} has been connected to Discord.")

@bot.event
async def on_disconnect():
      print(f"{bot.user} has been disconnected from Discord.")

@bot.event
async def on_message(message):
      if message.content.startswith(settings.prefix):
            msg = f"{arrow.now('US/Eastern').strftime('%x %X')} | {message.author} called {message.content}"
            if message.guild is None:
                  msg += " in DMs"
            print(msg)
      await bot.process_commands(message)

def loadallcogs():
      # loads cogs
      for cog in os.listdir("cogs"):
            if cog.endswith("py"):
                  filename = cog.split(".")[0]
                  if filename is None:
                        continue
                  try:
                        bot.load_extension(f"cogs.{filename}")
                        print(f"[Cogs] Cog Loaded: {filename}")
                  except (errors.ExtensionNotFound, errors.ExtensionAlreadyLoaded, errors.NoEntryPointError,
                        errors.ExtensionFailed) as e:
                        print(f"[Cogs] Error loading cog: {filename}; Error: {e}")

def getglobal(*args):
      pass

loadallcogs()
try:
      bot.run(settings.token)
except KeyboardInterrupt:
      print("How dare you..")
