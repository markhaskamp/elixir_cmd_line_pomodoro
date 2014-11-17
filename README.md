# Pomodoro

Pomodoro timer, written with Elixir

## Design Notes

- Timer window
  - State
    - Pomodoro
      - can run overtime
      - on stop, writes a record to (somewhere)
    - break
      - stops after 5 or 15 appropriately
  - message
    - start
      - start a new Pomodoro
    - stop
      - stop Pomodoro timer
    - show
      - list Pomodoro, reverse sorted by date-time

- Command window


## me talking things out

### spawn, send, receive

__spawn__

Start a process.  
Not necessarily related to messaging.  
With messaging, a spawned process can be used to implement a _receive_ clause.

__receive__

a module that listens for a message

__send__

send a message
