use ("lab3func.sml");

fun test(fun_name : string, result_true, result_actual) =
if result_true = result_actual
then (fun_name, "Passed")
else (fun_name, "Failed");

print "\n******************** Task_1 ********************\n";
(*Test_Task_1a*)
print "\nTest_Task_1a:\n";
test("all_except_option", SOME ["a", "b", "d", "e"], all_except_option("c", ["a", "b", "c", "d", "e"]));
test("all_except_option", SOME [], all_except_option("a", ["a"]));
test("all_except_option", NONE, all_except_option("f", ["a", "b", "c", "d", "e"]));
test("all_except_option", NONE, all_except_option("f", []));

(*Test_Task_1b*)
print "\nTest_Task_1b:\n";
test("get_substitutions1", ["Fredrick","Freddie","F"], get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred"));
test("get_substitutions1", ["Jeffrey","Geoff","Jeffrey"], get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff"));

(*Test_Task_1c*)
print "\nTest_Task_1c:\n";
test("get_substitutions2", ["Fredrick","Freddie","F"], get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred"));
test("get_substitutions2", ["Jeffrey","Geoff","Jeffrey"], get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff"));

(*Test_Task_1d*)
print "\nTest_Task_1d:\n";
test("similar_names", 
    [{first="Fred", last="Smith", middle="W"}, 
    {first="Fredrick", last="Smith", middle="W"},
    {first="Freddie", last="Smith", middle="W"},
    {first="F", last="Smith", middle="W"}], 
    similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}));


print "\n******************* Task_2 ********************\n";
(* Test card variables *)
print "\nVariables:\n";
val card1 = (Diamonds, Jack);
val card2 = (Hearts, Num 10);
val card3 = (Clubs, Ace);
val card4 = (Spades, Num 6);

val list1_all = [card1, card2, card3, card4];
val list2_red = [card1, card2];
val list3_black = [card3, card4];
val list4_blank = [];

(*Test_Task_2a*)
print "\nTest_Task_2a:\n";
test("card_color", Red, card_color(card1));
test("card_color", Red, card_color(card2));
test("card_color", Black, card_color(card3));
test("card_color", Black, card_color(card4));

(*Test_Task_2b*)
print "\nTest_Task_2b:\n";
test("card_value", 10, card_value(card1));
test("card_value", 10, card_value(card2));
test("card_value", 11, card_value(card3));
test("card_value", 6, card_value(card4));

(*Test_Task_2c*)
print "\nTest_Task_2c:\n";
test("remove_card", [card2, card3, card4], remove_card(list1_all, card1, IllegalMove));
test("remove_card", [card2], remove_card(list2_red, card1, IllegalMove));

(*Test_Task_2d*)
print "\nTest_Task_2d:\n";
test("all_same_color", false, all_same_color(list1_all));
test("all_same_color", true, all_same_color(list2_red));
test("all_same_color", true, all_same_color(list3_black));

(*Test_Task_2e*)
print "\nTest_Task_2e:\n";
test("sum_cards", 37, sum_cards(list1_all));
test("sum_cards", 20, sum_cards(list2_red));
test("sum_cards", 17, sum_cards(list3_black));
test("sum_cards", 0, sum_cards(list4_blank));

(*Test_Task_2f*)
print "\nTest_Task_2f:\n";
test("score", 30, score(list1_all, 27));
test("score", 5, score(list2_red, 30));
test("score", 0, score(list3_black, 17));

(*Test_Task_2g*)
print "\nTest_Task_2g:\n";
test("officiate", 0, officiate(list1_all, [Draw, Draw, Draw, Draw], 37));
test("officiate", 3, officiate(list1_all, [Draw, Draw, Discard(Diamonds, Jack), Draw], 20));
test("officiate", 5, officiate(list2_red, [Draw, Draw], 30));
