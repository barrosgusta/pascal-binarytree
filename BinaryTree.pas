Program BinaryTree ;

type
	PNode = ^Node;
	Node = Record
	Content: Integer;
	LeftChild, RightChild, Parent: PNode;
End;


//Função que filtra as letras da string e deixa só os números
{O objetivo dessa função é implementar-lo nas escolhas das opções, afim de não "estourar" exception quando uma letra(string) é informada nos campos de número(integer)"}
function GetNumbersFromString(S : string): integer;
var I, Result : integer;
    sAux : string;
begin
	for I := 1 to Length(S) do
	begin
		if S[I] in ['0'..'9'] then
			sAux := sAux + S[I];
	end;

	val(sAux, Result, I);
	
	if S[1] = '-' then
		Result := Result * -1;
		
	GetNumbersFromString := Result;
end;

Procedure PreOrder(root: PNode);
begin
	if root <> nil then 
	begin
		write(root^.Content, '||');
		PreOrder(root^.LeftChild);
		PreOrder(root^.RightChild);
	end;    
end;

Procedure InOrder(root: PNode);
begin
	if root <> nil then 
	begin
		InOrder(root^.LeftChild);
		write(root^.Content, '||');
		InOrder(root^.RightChild);
	end;
end;

Procedure PostOrder(root: PNode);
begin
	if root <> nil then
	begin
		PostOrder(root^.LeftChild);
		PostOrder(root^.RightChild);
		write(root^.Content, '||');
	end;
end;

procedure InitBinTree(var root: PNode);
begin
	root := Nil;
end;

Procedure ShowLeafNodes(root: PNode);
begin
	if root <> nil then 
	begin
		if (root^.LeftChild = NIL) and (root^.RightChild = NIL) then 
			write(root^.Content, '||');
			ShowLeafNodes(root^.LeftChild);
			ShowLeafNodes(root^.RightChild);
	end;
end;

procedure DisposeTree(root:PNode);
begin
	if root <> nil then 
	begin
		DisposeTree(root^.LeftChild);
		DisposeTree(root^.RightChild);
		Dispose(root);
	end;
end;

procedure CountNodes(root:PNode;var Cont:Integer);
begin
	if root <> nil then 
	begin
		inc(cont);
		CountNodes(root^.LeftChild,Cont);
		CountNodes(root^.RightChild,Cont);
	end;
end;

procedure SumNodes(root:PNode;var sum:Integer);
begin
	if root <> nil then 
	begin
		sum := sum + root^.Content;
		CountNodes(root^.LeftChild,sum);
		CountNodes(root^.RightChild,sum);
	end;
end;

function SearchBinTree(root:PNode;x:Integer):PNode;
var AuxNode:PNode;
begin
	AuxNode:=root;
	while (AuxNode <> nil) and (AuxNode^.Content <> x) do
		if x > AuxNode^.Content then 
			AuxNode := AuxNode^.RightChild
		else 
			AuxNode := AuxNode^.LeftChild;
			
	SearchBinTree := AuxNode;
end;

function GetMinValue(root:PNode):PNode;
begin
	if root^.LeftChild <> nil then 
		GetMinValue := GetMinValue(root^.LeftChild)
	else 
		GetMinValue := root;
end;

function GetMaxValue(root:PNode):PNode;
begin
	if root^.RightChild <> nil then 
		GetMaxValue := GetMaxValue(root^.RightChild)
	else 
		GetMaxValue := root;
end;

function GetAction(S: string): integer;
begin
	GetAction := GetNumbersFromString(S);	
end;


Procedure InsertIntoTree(var root: PNode; data: integer);
var
	AuxNode: PNode;
begin
	if root <> nil then
	begin
		if data > root^.Content then
		begin
			if root^.RightChild <> nil then
				InsertIntoTree(root^.RightChild, data)
			else
			begin
				new(AuxNode);
				AuxNode^.Parent     := root;
				AuxNode^.LeftChild  := nil;
				AuxNode^.RightChild := nil;
				AuxNode^.Content    := data;
				
				root^.RightChild := AuxNode;
			end
		end
		else if data < root^.Content then
		begin
		  if root^.LeftChild <> nil then
				InsertIntoTree(root^.LeftChild, data)
			else
			begin
				new(AuxNode);
				AuxNode^.Parent     := root;
				AuxNode^.LeftChild  := nil;
				AuxNode^.RightChild := nil;
				AuxNode^.Content    := data;
				
				root^.LeftChild := AuxNode;
			end
		end
		else 
			writeln('O valor já está na árvore!');
	end
	else
	begin
		new(AuxNode);
		AuxNode^.Parent     := nil;
		AuxNode^.LeftChild  := nil;
		AuxNode^.RightChild := nil;
		AuxNode^.Content    := data;
		
		root := AuxNode;
	end;
		
end;

procedure HandleInsert(var root: PNode);
var sValue: string;
		iValue: integer;
begin
	writeln('Qual o valor?');
	read(svalue);
	iValue := GetNumbersFromString(sValue);
	InsertIntoTree(root, iValue);
end;

procedure RemoveFromTree(var root: PNode; iValue: integer);
begin
	if root <> nil then
	begin
		if root^.Content = iValue then
		begin
			DisposeTree(root);
			root := nil;
		end
		else if iValue > root^.Content then
			RemoveFromTree(root^.RightChild, iValue)
		else
			RemoveFromTree(root^.LeftChild, iValue);
	end;
end;

procedure HandleDelete(var root: PNode);
var sValue: string;
		iValue: integer;
begin
	writeln('Qual o valor?');
	read(svalue);
	iValue := GetNumbersFromString(sValue);
	RemoveFromTree(root, iValue);
end;

var
 sAction: string;
 iAction: integer;
 BinTree: PNode;


Begin
  InitBinTree(BinTree);
  
	while iAction <> 10 do
	begin
		writeln('Qual ação?:');
		writeln('1 - Mostrar Em-Ordem;');
		writeln('2 - Mostrar Pós-Ordem;');
		writeln('3 - Mostrar Pré-Ordem;');
		writeln('4 - Inserir Valor;');
		writeln('5 - Remover Valor;');
		writeln('10 - Encerrar programa;');
		read(sAction);
		
		iAction := GetNumbersFromString(sAction);
		
		case iAction of
			1: InOrder(BinTree);
			2: PostOrder(BinTree);
			3: PreOrder(BinTree);
			4: HandleInsert(BinTree);
			5: HandleDelete(BinTree);
		end;
		
		readkey;
		
		clrscr;
	end; 
End.