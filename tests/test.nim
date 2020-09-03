import unittest
import cenum

template checkValues(a, b, c, d: untyped): untyped =
  check First == a
  check Second == b
  check Third == c
  check Fourth == d

test "automatic values":
  cenum int:
    First
    Second
    Third
    Fourth
  
  checkValues 0, 1, 2, 3

test "explicit values":
  cenum int:
    First = 1
    Second = 3
    Third = 5
    Fourth = 99
  
  checkValues 1, 3, 5, 99

test "mixed explicit and automatic values (1)":
  cenum int:
    First = 1
    Second
    Third
    Fourth
  
  checkValues 1, 2, 3, 4

test "mixed explicit and automatic values (2)":
  cenum int:
    First = 1
    Second
    Third = 8
    Fourth
  
  checkValues 1, 2, 8, 9

test "explicit expression values":
  cenum int:
    First = 1 shl 3
    Second = 1 shl 5
    Third = 1 shl 7
    Fourth = 1 shl 9
  
  checkValues 1 shl 3, 1 shl 5, 1 shl 7, 1 shl 9

test "mixed expression values and automatic values":
  const Base = 69

  cenum int:
    First = Base + 1
    Second
    Third = 2 * Base + 3
    Fourth
  
  checkValues Base + 1, Base + 2, 2 * Base + 3, 2 * Base + 4

test "types - builtin number type":
  cenum float64:
    First = 97
    Second
    Third
    Fourth
  
  checkValues 97, 98, 99, 100
  check First is float64
  check Fourth is float64

test "types - type alias":
  type Word = uint16

  cenum Word:
    First = 1
    Second
    Third
    Fourth
  
  checkValues Word(1), Word(2), Word(3), Word(4)
  check First is Word
  check Fourth is Word
