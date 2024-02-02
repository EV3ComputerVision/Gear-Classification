function resultado=fxor(a,b)
resultado=or(and(not(logical(a)),logical(b)),and(logical(a),not(logical(b))));
end