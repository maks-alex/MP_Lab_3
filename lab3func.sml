(* Task_1*)
(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(*Task_1a*)
fun all_except_option(str, strList) =
let
    fun find_remove(blankList, str, strList) =
        case strList of
            [] => NONE
            |x::xs' => if same_string(x, str)                                    
                        then SOME (blankList @ xs')
                        else find_remove(blankList @ (x::[]), str, xs')     
in
    find_remove([], str, strList)
end;

(*Task_1b*)
fun get_substitutions1(strListList, s) =
    case strListList of
        [] => []
        |x::xs' => (case all_except_option(s, x) of
                        NONE => get_substitutions1(xs', s)
                        |SOME listResult => listResult @ get_substitutions1(xs', s));

(*Task_1c*)
fun get_substitutions2(strListList, s) =
    let
        fun tailRecursiveCall(lst, str, acc) =
            case lst of
                [] => acc
                |x::xs => (case all_except_option(s, x) of
                            NONE => tailRecursiveCall(xs, s, acc)
                            |SOME listResult => tailRecursiveCall(xs, s, acc @ listResult))
    in
        tailRecursiveCall(strListList, s, [])
    end;


(*Task_1d*)
fun similar_names(strListList, {first=firstName, middle=middleName, last=lastName}) =
    let
        fun find_mix_result(lst) =
            case lst of
            [] => []
            | x::xs => {first=x, middle=middleName, last=lastName}::find_mix_result(xs)
    in
        {first=firstName, middle=middleName, last=lastName}::find_mix_result(get_substitutions2(strListList, firstName))
    end;

(* Task_2*)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(*Task_2a*)
fun card_color(card) =
    case card of
    (Diamonds,_) => Red
    | (Hearts,_) => Red
    | (Clubs,_) => Black
    | (Spades,_) => Black;

(*Task_2b*)
fun card_value(card) =
    case card of
    (_,Num num) => num
    |(_,Ace) => 11
    |(_,_) => 10;

(*Task_2c*)
fun remove_card(cs, c, e) =
    let
        fun remove(cardList, card, listResult) =
            case cardList of
                [] => raise e
                |x::xs => (if (x = card)
                        then listResult @ xs
                        else remove(xs, card, listResult @ (x::[])))
    in
        remove(cs, c, [])
    end;

(*Task_2d*)
fun all_same_color(cs) =
   case cs of
   [] => true 
   |x::[] => true
   |(x::xs::xs') => if card_color(x) = card_color(xs) 
                    then all_same_color(xs::xs')
                    else false;

(* Task_2e *)
fun sum_cards(cs) = 
   let fun sum(cs,acc)=
      case cs of
         []=> acc 
         |(x::xs) => sum(xs, acc + card_value(x))
   in
      sum(cs,0)
   end;

(* Task_2f *)
fun score(cs, goal) = 
    let fun calculte_score(cs) = 
        case sum_cards(cs) > goal of
            true =>  3*(sum_cards(cs) - goal)
            |false =>  goal - sum_cards(cs)  
    in 
        case all_same_color(cs) of
            false => calculte_score(cs)
            |true => calculte_score(cs) div 2
    end;

(* Task_2g *)
fun officiate(cs, moveList, goal)=
    let fun move_next(cardDeck, moveList, cardsOnHand) = 
        case (sum_cards(cardsOnHand) > goal) of
            true => score(cardsOnHand, goal)
            |false => case moveList of
                    [] => score(cardsOnHand, goal)
                    |(headMoveList::tailMoveList) => case headMoveList of
                                Discard card => move_next(cardDeck, tailMoveList, remove_card(cardsOnHand, card, IllegalMove))     
                                |Draw => case cardDeck of 
                                        [] => score(cardsOnHand, goal)
                                        | (headDeck::tailDeck) => move_next(tailDeck, tailMoveList, headDeck::cardsOnHand)                       
   in
      move_next(cs,moveList, [])
   end;