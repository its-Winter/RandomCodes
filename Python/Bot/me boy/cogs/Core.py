import discord
from discord.ext import commands
from discord.ext.commands import errors
from discord.ext.commands.core import is_nsfw

class Core(commands.Cog):
      def __init__(self, bot):
            self.bot = bot

      def guild_only():
            async def predicate(ctx):
                  if ctx.guild is None:
                        await ctx.send('Hey no DMs!')
                        return False
                  else:
                        return True
            return commands.check(predicate)
      
      @commands.command(name="hello")
      @guild_only()
      async def examplecog(self, ctx):
            await ctx.send(f"Hello, {ctx.author}! This is an example cog!")
            print('example')

      @commands.command(name='math')
      @guild_only()
      async def math(self, ctx, *, math):
            """A bad example of a math command"""
            evaled = eval(math)
            await ctx.send(int(evaled))

      @commands.command(name='nsfwcheck')
      @guild_only()
      async def checknsfw(ctx):
            _nsfw = is_nsfw()
            if _nsfw:
                  await ctx.send("Channel is set to NSFW.")
            elif _nsfw is False:
                  await ctx.send("Channel is not set to NSFW.")
            else:
                  await ctx.send("error while checking.")


def setup(bot):
      bot.add_cog(Core(bot))