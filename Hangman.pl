#!/usr/local/bin/perl

@list=("computer", "radio", "calculator", "teacher", "bureau", "police", "geometry", "president", "subject", "country",
       "enviroment", "classroom", "animals", "province", "month", "politics", "puzzle", "instrument", "kitchen", 
	   "language", "vampire", "ghost", "solution", "service", "software", "virus", "security", "phonenumber", "expert",
	   "website", "agreement", "support", "compatibility", "advanced", "search", "triathlon", "immediately", "encyclopedia",
	   "endurance", "distance", "nature", "history", "organization", "international", "championship", "government", "popularity",
	   "thousand", "feature", "wetsuit", "fitness", "legendary", "variation", "equal", "approximately", "segment", "priority",
	   "physics", "branch", "science", "mathematics", "lightning", "dispersion", "accelerator", "detector", "terminology", "design", 
	   "operation", "foundation", "application", "prediction", "reference", "measurement", "concept", "perspective", "overview", "position", 
	   "airplane", "symmetry", "dimension", "toxic", "algebra", "illustration", "classic", "verification", "citation", "unusual", 
	   "resource", "analysis", "license", "comedy", "screenplay", "production", "release", "emphasis", "director", "trademark", 
	   "vehicle", "aircraft", "experiment");
	   

$index=int rand(99); #to choose a random word from the given words list
$word=uc($list[$index]); #converting the chosen word to upper case


#*************ALL THE SUB-ROUTINES USED*****************


#the display() subroutine that displays the hangman
sub displayHangman
{ 
	($choice)=@_;
	
		if ($choice==1) {
			print "---------------- \n";
			print "|              | \n";
			print "|              O \n";
			print "| \n";
			print "| \n";
			print "|  ";
			print "\n|\n";
			print "| \n"; }
			
	    elsif ($choice==2){
			print "---------------- \n";
			print "|              | \n";
			print "|              O \n";
			print "|              |   \n";
			print "|              |  \n";
			print "|              ";
			print "\n|\n";
			print "| \n" ;}
		
		elsif ($choice==3) {
			print "---------------- \n";
			print "|              | \n";
			print "|              O \n";
			print "|             \\|   \n";
			print "|              |  \n";
			print "|              ";
			print "\n|\n";
		    print "| \n"; }
		
		elsif ($choice==4){
			print "---------------- \n";
			print "|              | \n";
			print "|              O \n";
			print "|             \\|/   \n";
			print "|              |  \n";
			print "|              ";
			print "\n|\n";
		    print "| \n";}
			
		elsif ($choice==5){
			print "---------------- \n";
			print "|              | \n";
			print "|              O \n";
			print "|             \\|/   \n";
			print "|              |  \n";
			print "|             /  ";
			print "\n|\n";
		    print "| \n";}
			
		elsif ($choice==6) {
			print "---------------- \n";
            print "|              | \n";
            print "|              O \n";
			print "|             \\|/   \n";
			print "|              |  \n";
			print "|             / \\ ";
			print "\n|\n";
			print "| \n";
		}
		
	}
	
	
	#subroutine that prints the current status of the word
sub PrintCurrentWord
{
		($aref)=@_;
		
		foreach (@$aref){
			print "$_ ";
		}
		
		print "\n";
}
	
	
	#subroutine that prints all the earlier guesses
sub PrintGuessed
{
		($aref)=@_;
		
		print "GUESSED SO FAR: ";
		foreach(@$aref){
			print "$_ ";
		}
		
		print "\n";
}
	
	
	#subroutine that checks if the entered letter has been guessed earlier or not
sub CheckAlreadyGuessed
{
		my ($aref, $guess) = @_;
		my $c=0;
		
		foreach ( @$aref) #checking if input letter has been guessed earlier or not
	   {
		if($_ eq $guess){
			$c+=1;
		  }
		
	   }
	   
	return $c;
}
	
	
	#subroutine checks if the enetered letter occurs in the main word
sub CheckLetter
{
		$letters=$_[0];
		$res=$_[1];
		
		$len=$_[4];
		
		$count=0;
		
		foreach $i (0..$len-1)
	   {
		if($letters->[$i] eq $_[2]) #checking if input letter occurs in the original word 
		{
			$_[3]+=1; #updating number of times any letter is guessed correct overall in all guesses
			$count+=1; #counting the number of times guessed letter occurs in word
			
			$res->[$i]=$_[2]; #updating resulant word with the guessed correct letter in correct places
		}
		
	   }
	   
	   return $count;
}




$len=length($word);
@letters=(); 

for $c (split //, $word)
{
	push @letters, $c; #storing all the individual letters of the selected word
}

$correct=0;
$failed=0;

@res=(); 
@guessed=();


foreach $_ (1..$len) #putting all the letters as '_' that is, unguessed
{
	push @res, '_';
}

while($correct<$len && $failed<6)
{
	print "\n\nWORD: ";
	
	PrintCurrentWord(\@res);  #subroutine that prints the current status of word 
	PrintGuessed(\@guessed);  #subroutine that displays the guesses made by user so far
	
	print "Enter your guess ?";
	$g=<STDIN>;  #taking user input
	
	$guess=uc($g);
	$A=chomp($guess);
	
	
	$chk= &CheckAlreadyGuessed(\@guessed, $guess); #subroutine checks if letter entered has been entered earlier or not
	
	
	if ($chk>0) #if the letter taken as input has already been guessed once
	{
	    print "You've already entered $guess !\n";
		$chk=0;
		next;
	}
	else
	{
		push @guessed, $guess;
	}
	
	
	if($guess eq $word) #if user enters the entire correct word as guess
	{
		print "\nYou guessed the correct word $word!";
		exit;
	}
	
	$count= &CheckLetter(\@letters, \@res, $guess, $correct, $len); #subroutine checks if entered letter is in the word
	
	if($count==0) #if the letter guessed doesn't occur in the original word
	{
		$failed=$failed + 1;
		print "Wrong guess!";
	}
	else
	{
		print "Good guess!";
	}
	
	$left=6-$failed;  #counting number of wrong attempts left
	print " You have $left body parts left.\n";
	displayHangman($failed); #display() subroutine displays the current hangman
	
	$count=0;

}

if($failed==6) #if user has made 6 incorrect letter guesses
{
	print "\nYou've made 6 wrong guesses. You lost :(\nThe correct word was $word. ";
}

elsif ($correct==$len) #if all the letters have been guessed correctly, one by one
{
	print "\nYou guessed the correct word $word !";
}










