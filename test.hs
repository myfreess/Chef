import Parse
import Tactic
import Fmt


main = putStrLn $ fmtBracket $ draw $ fst . head $ parse bracket "(([]{()()})[()(()())()()()]())"