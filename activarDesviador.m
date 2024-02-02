function m = activarDesviador(desviador,t)
%resetRotation(desviador);
desviador.Speed = 35;
start(desviador);
while abs(readRotation(desviador))<120*t
end

stop(desviador,1);
%readRotation(desviador)
%desviador.Speed = -10;
%start(desviador);
%while abs(readRotation(desviador))>122
%end
%stop(desviador,1);
%stop(desviador,0);
%readRotation(desviador);
m = NaN;
end