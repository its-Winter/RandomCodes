import asyncio
import platform
import datetime
import arrow
import discord
from discord.ext import commands
from discord.ext.commands import core

class Dev(commands.Cog, name="Dev"):
      def __init__(self, bot):
            self.bot = bot


      @commands.command(name="germ")
      @commands.guild_only()
      async def _germ(self, ctx):
            germ = ctx.bot.get_user(216085324906889226)
            germstime = arrow.now("US/Pacific").strftime("%X")
            e = discord.Embed(title=germ.name, description=f"this is germ: {germ.mention}", color=discord.Color.gold())
            e.set_author(name=germ.name, icon_url=germ.avatar_url)
            e.set_footer(text=f"{ctx.author.name} has asked about Germ at {germstime} PST", icon_url=ctx.author.avatar_url)
            await ctx.send(embed=e)

      @commands.command(name="dm")
      @commands.guild_only()
      async def _dm(self, ctx, user, *message):
            user = ctx.guild.get_member_named(user)
            if user is None:
                  await ctx.send(f"Failed to find that user: {user}")
                  return

            if user.bot is True:
                  await ctx.send("I cannot send messages to other bots pandejo.")
                  return

            if not user.dm_channel:
                  await user.create_dm()
            try:
                  message = " ".join(message)
                  e = discord.Embed(description=message, color=discord.Colour.blurple())
                  e.set_author(name=f"Message from {ctx.author}!", icon_url=ctx.author.avatar_url)
                  e.set_footer(text=f"Sent at {arrow.now(tz='US/Eastern').strftime('%X')} EST", icon_url=ctx.bot.user.avatar_url)
                  await user.send(embed=e)
                  await ctx.send(f"Sent your message to {user}.")
            except Exception as e:
                  await ctx.send(f"Failed to send message to {user}. {e}")


      @commands.command(name="guilds")
      @commands.is_owner()
      async def guilds(self, ctx):
            pass


def setup(bot):
      bot.add_cog(Dev(bot))