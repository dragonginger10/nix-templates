from loguru import logger
from rich.console import Console

console = Console()


def main():
  logger.info("Hello World")
  console.print("Hello World")

if __name__ == "__main__":
  main()
