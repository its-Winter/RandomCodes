import json
import arrow
import time
import asyncio
import discord
import contextlib
import platform
from discord import utils
from discord.ext import commands
from discord.ext.commands import errors, core
# from Settings import settings


class Core(commands.Cog, name="Core"):
      def __init__(self, bot):
            self.bot = bot

      @commands.command(name="hello")
      async def _hello(self, ctx):
            """a basic hello command"""
            if ctx.guild is None:
                  await ctx.send(f"Hello, {ctx.author.mention}! suck my peen and get out of my dms.")
            else:
                  await ctx.send(f"Hello, {ctx.author.mention}! suck my peen.")
            print('also suck the console''s pp.')

      @commands.command(name="shutdown")
      @commands.is_owner()
      async def _shutdown(self, ctx, silently = False):
            """Kills the bot"""
            with contextlib.suppress(discord.HTTPException):
                  if not silently:
                        await ctx.send("Shutting down...")
            await ctx.bot.change_presence(status=discord.Status.offline)
            await ctx.bot.close()


      @commands.command(name="uptime")
      async def _uptime(self, ctx):
            async with ctx.typing():
                  uptime = arrow.utcnow() - ctx.bot.start_time
                  totalseconds = uptime.total_seconds()
                  seconds = int(totalseconds)
                  periods = [
                        ("year", "years", 60 * 60 * 24 * 365),
                        ("month", "months", 60 * 60 * 24 * 30),
                        ("day", "days", 60 * 60 * 24),
                        ("hour", "hours", 60 * 60),
                        ("minute", "minutes", 60),
                        ("second", "seconds", 1),
                  ]

                  strings = []
                  for period_name, plural_period_name, period_seconds in periods:
                        if seconds >= period_seconds:
                              period_value, seconds = divmod(seconds, period_seconds)
                              if period_value == 0:
                                    continue
                              unit = plural_period_name if period_value > 1 else period_name
                              strings.append(f"{period_value} {unit}")

                  uptimestr = ", ".join(strings)
                  e = discord.Embed(title="Uptime", description=f"{ctx.bot.user.mention} has been online for ```{uptimestr}.```", color=discord.Color.green())
                  e.set_footer(text=f"summoned by {ctx.author}", icon_url=ctx.author.avatar_url)
            await ctx.send(embed=e)

      @commands.command(name='nsfwcheck')
      @commands.guild_only()
      async def _checknsfw(self, ctx):
            if ctx.channel.nsfw:
                  await ctx.send("Channel is set to NSFW.")
            else:
                  await ctx.send("Channel is not set to NSFW.")

      @commands.command(name="game")
      @commands.is_owner()
      async def _game(self, ctx, *, game):
            """Set's bot's playing status"""
            text = discord.Game(name=game)
            status = discord.Status.online
            await ctx.bot.change_presence(activity=text, status=status)
            await ctx.send(f"Set game to '{text}''")

      @commands.command(name="ping")
      async def _ping(self, ctx):
            """Ping pong."""
            async with ctx.typing():
                  latency = self.bot.latency * 1000
                  e = discord.Embed(title="Pong.", color=discord.Color.red())
                  e.add_field(name="Discord API", value=f"```{str(round(latency))} ms```")
                  e.add_field(name="Typing", value="```calculating ms```")

                  before = time.monotonic()
                  message = await ctx.send(embed=e)
                  typlatency = (time.monotonic() - before) * 1000

                  e = discord.Embed(title="Pong.", color=discord.Color.green())
                  e.add_field(name="Discord API", value=f"```{str(round(latency))} ms```")
                  e.add_field(name="Typing", value=f"```{str(round(typlatency))} ms```")

            await message.edit(embed=e)

      @commands.command(name="typing")
      @commands.is_owner()
      async def _typingtest(self, ctx):
            async with ctx.typing():
                  await asyncio.sleep(3.0)
                  await ctx.send('waited three seconds nerd.')

      @commands.command(name="embed")
      async def _embedtest(self, ctx):
            e = discord.Embed()
            e.set_author(name=ctx.bot.user, icon_url=ctx.bot.user.avatar_url)
            e.add_field(name="Discord.py", value=discord.__version__)
            e.add_field(name="Python Ver", value=platform.python_version())
            e.set_footer(text=f"called by {ctx.author}", icon_url=ctx.author.avatar_url)
            await ctx.send(embed=e)
      
      @commands.command(name="reload")
      @commands.is_owner()
      async def _reload(self, ctx, *cogs):
            if cogs is None:
                  await ctx.send("Please call with cogs to reload.")
                  return
            async with ctx.typing():
                  for cog in cogs:
                        try:
                              ctx.bot.reload_extension(f"cogs.{cog.lower()}")
                              await ctx.send(f"[Cogs] Reloaded {cog}")
                              print(f"[Cogs] Reloaded {cog}")
                        except (errors.ExtensionError, errors.ExtensionFailed, errors.ExtensionNotLoaded, errors.NoEntryPointError) as e:
                              await ctx.send(f"[Cogs] Failed to reload {cog}\nError: {e}")


      @commands.command(name="load")
      @commands.is_owner()
      async def _load(self, ctx, *cogs):
            if len(cogs) <= 0:
                  await ctx.send("Please call with cogs to reload.")
                  return
            async with ctx.typing():
                  for cog in cogs:
                        try:
                              ctx.bot.load_extension(f"cogs.{cog.lower()}")
                              await ctx.send(f"[Cogs] Loaded {cog}")
                              print(f"[Cogs] Loaded {cog}")
                        except (errors.ExtensionError, errors.ExtensionFailed, errors.ExtensionNotLoaded, errors.NoEntryPointError) as e:
                              await ctx.send(f"[Cogs] Failed to load {cog}\nError: {e}")


def setup(bot):
      bot.add_cog(Core(bot))