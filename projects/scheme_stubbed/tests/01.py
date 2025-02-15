test = {
  'name': 'Problem 2',
  'points': 3,
  'suites': [
    {
      'cases': [
        {
          'code': r"""
          >>> src = Buffer(tokenize_lines(["(1 . 2)"]))
          >>> scheme_read(src)
          Pair(1, 2)
          >>> src.current()
          """,
          'hidden': False,
          'locked': False
        },
        {
          'code': r"""
          >>> read_line('(1 2 . 3)')
          Pair(1, Pair(2, 3))
          >>> read_line('(1 . 2 3)')
          SyntaxError
          >>> scheme_read(Buffer(tokenize_lines(['(1', '2 .', "(quote (3 4)))", '4'])))
          Pair(1, Pair(2, Pair('quote', Pair(Pair(3, Pair(4, nil)), nil))))
          >>> read_line("(2 . 3 4 . 5)")
          SyntaxError
          >>> read_line("(2 (3 . 4) 5)")
          Pair(2, Pair(Pair(3, 4), Pair(5, nil)))
          >>> read_line("(1 2")
          SyntaxError
          """,
          'hidden': False,
          'locked': False
        },
        {
          'code': r"""
          >>> read_tail(Buffer(tokenize_lines(['. 1)'])))
          1
          >>> read_tail(Buffer(tokenize_lines(['. 1'])))
          SyntaxError
          >>> read_tail(Buffer(tokenize_lines(['. (1 2 3))'])))
          Pair(1, Pair(2, Pair(3, nil)))
          >>> read_line("(1 . (quote (2 . (quote (3 4)))))")
          Pair(1, Pair('quote', Pair(Pair(2, Pair('quote', Pair(Pair(3, Pair(4, nil)), nil))), nil)))
          >>> read_line("(1 . (quote (2 (3 4))) 6)")
          SyntaxError
          """,
          'hidden': False,
          'locked': False
        }
      ],
      'scored': True,
      'setup': r"""
      >>> from scheme_reader import *
      """,
      'teardown': '',
      'type': 'doctest'
    }
  ]
}
