program miniPong;

uses crt;
var touche:char;
    position, position2, ballex,balley,directionx,directiony,boucle,s1,s2: integer;
    islaunch,stop: boolean;

//maj: couleurs, effets sur les raquettes


procedure mover(direction:integer);  // raquette 1
var i:integer;
begin
   if direction=-1 then    // limite haute
       if position=2 then
          exit
       else
       begin
           gotoxy(2,position+3);
           write(' ');
       end;
    if direction=1 then   // limite basse
       if position=17 then
          exit
       else
       begin
           gotoxy(2,position);
           write(' ');
       end;
   position:=position+direction;
   if islaunch=false then
   begin
       gotoxy(3,balley);
       write(' ');
       balley:=position+2;
       gotoxy(3,balley);
       write('o');
   end;
   for i:=0 to 3 do
   begin
	   textcolor(lightred);
       gotoxy(2,i+position);   // se positionne col 2 ligne 15 a 18
       write(#186);      // ecrit ASCII 221 (un bloc)
   end;
end;

procedure mover2(direction2:integer);  // raquette 2
var j:integer;
begin
   if direction2=-1 then
       if position2=2 then
          exit
       else
       begin
           gotoxy(44,position2+3);
           write(' ');
       end;
    if direction2=1 then
       if position2=17 then
          exit
       else
       begin
           gotoxy(44,position2);
           write(' ');
       end;
   position2:=position2+direction2;
   for j:=0 to 3 do
   begin
	   textcolor(lightgreen);
       gotoxy(44,j+position2);
       write(#186);
   end;
end;

procedure terr(i,j:integer);
begin
   textcolor(lightgray);
   gotoxy(1,1);
   write(#201);
   gotoxy(1,21);
   write(#200);
   gotoxy(45,1);
   write(#187);
   gotoxy(45,21);
   write(#188);
   for i:=1 to 43 do
   begin
       gotoxy(1+i,1);
       write(#205);
       gotoxy(1+i,21);
       write(#205);
   end;
   for j:=1 to 19 do
   begin
       gotoxy(1,1+j);
       write(#186);
       gotoxy(45,1+j);
       write(#186);
   end;
end;

procedure init;
begin
   clrscr;           // efface l'ecran
   cursoroff;        // supprime le curseur
   position:=5;
   position2:=10;
   islaunch:=false;
   ballex:=3;
   balley:=7;
   directionx:=1;
   directiony:=1;
   mover(0);
   mover2(0);
   stop:=false;
   terr(1,1);
end;


procedure moveb;    // balle et score
begin
	textcolor(lightgray);
    if islaunch=false then exit;
    gotoxy(ballex,balley);
    write(' ');
    ballex:=ballex+directionx;
    balley:=balley+directiony;
    gotoxy(ballex,balley);
    write('o');
    if (ballex=3) then
	begin
		if ((balley<=position+3) and (balley>=position)) then      // j1 renvoie
			directionx:=directionx*-1
		else
			if ((balley=position+4) or (balley=position-1)) then
				begin
					directionx:=directionx*-1;
					directiony:=directiony*-1;
				end
			else
			begin
				s2:=s2+1;                    // j2 marque
				init;
			end;
	end;
    if (ballex=43) then
    begin
		if ((balley>=position2) and (balley<=position2+3)) then     // j2 renvoie
			directionx:=directionx*-1
		else
			if ((balley=position2+4) or (balley=position2-1)) then
				begin
					directionx:=directionx*-1;
					directiony:=directiony*-1;
				end
			else
			begin
				s1:=s1+1;                   // j1 marque
				init;
			end;
	end;
    if ((balley=20) or (balley=2)) then directiony:=directiony*-1;	// rebond sur les cotes
	textcolor(lightred);
	gotoxy(16,21);
	write(' ');
	write(s1);
	write(' ');
	textcolor(lightgreen);
	gotoxy(28,21);
	write(' ');
	write(s2);
	write(' ');
end;
	
BEGIN
   init;
   textcolor(lightred);
 	gotoxy(16,21);
	write(' ');
	write('0');
	write(' ');
	textcolor(lightgreen);
	gotoxy(28,21);
	write(' ');
	write('0');
	write(' ');
   while stop=false do
   begin
      if keypressed then
      begin
          touche:=readkey;
          if touche=#27 then stop:=true;
          if touche=#122 then
              mover(-1)
          else if touche=#115 then
              mover(1);
          if touche=#0 then               // utilisateur a util une touche etendue
          begin
              touche:=readkey;            // on lit la seconde partie de la sequence
              if touche=#72 then          // fleche vers le haut
                  mover2(-1)
              else if touche=#80 then     // fleche vers le bas
                  mover2(1);
          end;
          if touche=#32 then
             islaunch:=true;
      end;
      delay(100);
      moveb;                             // balle
   end;
END.

