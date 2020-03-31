import json
import time
import asyncio
import discord
import contextlib
from discord import utils
from discord.ext import commands
from discord.ext.commands.errors import NoPrivateMessage
from discord.ext.commands import core as check
# import globals

# globalvars = json.load('..global.json', indent=6)

class Core(commands.Cog, name="Core"):
      def __init__(self, bot):
            self.bot = bot

      @commands.command(name="hello")
      @check.guild_only()
      async def hello(self, ctx):
            """a basic hello command"""
            await ctx.send(f"Hello, {ctx.author}! suck my pp")
            print('also suck the console''s pp.')

      @commands.command(name="shutdown")
      @check.is_owner()
      async def shutdown(self, ctx, silently = False):
            """Kills the bot"""
            with contextlib.suppress(discord.HTTPException):
                  if not silently:
                        await ctx.send("Shutting down...")
            await ctx.bot.change_presence(status=discord.Status.offline)
            await ctx.bot.close()


      @commands.command(name="uptime")
      async def uptime(self, ctx):
            if ctx.guild is None:
                  if ctx.message.author.id != ctx.bot.owner.id:
                        await ctx.send("you're not winter.")
                        raise Exception("Someone tried to use uptime in DMs that wasn't you.")
            uptime = time.time() - globals.up_since
            await ctx.send(f"Bot has been running since {uptime}")

      @commands.command(name='nsfwcheck')
      @check.guild_only()
      async def checknsfw(self, ctx):
            _nsfw = ctx.is_nsfw()
            if _nsfw:
                  await ctx.send("Channel is set to NSFW.")
            elif _nsfw is False:
                  await ctx.send("Channel is not set to NSFW.")
            else:
                  await ctx.send("error while checking.")

      @commands.command(name="game")
      @check.is_owner()
      async def set_game(self, ctx, *, game):
            """Set's bot's playing status"""
            text = discord.Game(name=game)
            status = discord.Status.online
            await ctx.bot.change_presence(activity=text, status=status)
            await ctx.send(f"Set game to '{text}''")

      @commands.command(name="ping")
      async def ping(self, ctx):
            """Ping pong."""
            latency = self.bot.latency
            msg = "Pong!\n"
            msg += f"{round(latency, 4)}ms from Discord API"
            msg += "\n", globalvars['bot']['username']
            await ctx.send(msg)

def setup(bot):
      bot.add_cog(Core(bot))