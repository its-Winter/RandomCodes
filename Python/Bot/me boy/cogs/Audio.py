import discord
from discord.ext import commands
from discord.ext.commands import core as check
import lavalink

class Audio(commands.Cog, name="Audio"):
      def __init__(self, bot):
            self.bot = bot

      