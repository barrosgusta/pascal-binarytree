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

Procedure CountLeafNodes(root: PNode; var Count: integer);
begin
	if root <> nil then 
	begin
		if (root^.LeftChild = NIL) and (root^.RightChild = NIL) then 
			Inc(Count);

	  CountLeafNodes(root^.LeftChild, Count);
		CountLeafNodes(root^.RightChild, Count);
	end;
end;

procedure HandleCountLeafNodes(root: PNode);
var 
	Count: Integer;
begin
	Count := 0;
	CountLeafNodes(root, Count);
	
	writeln('A quantidade de elementos folha é de: ', Count); 
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

procedure CountNodes(root:PNode;var Count: integer);
begin
	if root <> nil then 
	begin
		inc(Count);
		CountNodes(root^.LeftChild, Count);
		CountNodes(root^.RightChild, Count);
	end;
end;

function GetHeight(root: PNode): integer;
var
	LeftHeight, RightHeight: integer;
begin
	LeftHeight  := 0;
	RightHeight := 0;
	
	if root = nil then
		GetHeight := -1
	else
	begin
	  LeftHeight  := GetHeight(root^.LeftChild); 
		RightHeight := GetHeight(root^.RightChild);
	
		if LeftHeight > RightHeight then
			GetHeight := 1 + LeftHeight
		else
			GetHeight := 1 + RightHeight
	end
		
end;

procedure HandleGetHeight(root: PNode);
begin
	writeln('A altura desta árvore é de: ', GetHeight(root));
end;

procedure HandleShowNodesCount(root: PNode);
var Count: integer;
begin
	Count := 0;
	CountNodes(root, Count);
	
	writeln('A quantidade de elementos é de: ', Count);
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

function IsTreeFull(root: PNode): boolean;
begin
	if root = nil then
		isTreeFull := true
	else
	begin
		if (root^.LeftChild = nil) and (root^.RightChild = nil) then
			isTreeFull := true
		else if (root^.LeftChild <> nil) and (root^.RightChild <> nil) then
			isTreeFull := isTreeFull(root^.LeftChild) and isTreeFull(root^.RightChild)
		else
			isTreeFull := false;
	end;
end;

procedure HandleIsTreeFull(root: PNode);
begin
	if IsTreeFull(root) then
		writeln('A árvore é completa')
	else
		writeln('A árvore é incompleta')
end;

var
 sAction: string;
 iAction: integer;
 BinTree: PNode;


Begin
  InitBinTree(BinTree);
  
	while iAction <> 11 do
	begin
		writeln('Qual ação?:');
		writeln('1 - Inserir Valor;');
		writeln('2 - Remover Valor;');
		writeln('3 - Mostrar Em-Ordem;');
		writeln('4 - Mostrar Pós-Ordem;');
		writeln('5 - Mostrar Pré-Ordem;');
		writeln('6 - Mostrar Folhas;');
		writeln('7 - Contar Folhas;');
		writeln('8 - Contar Elementos;');
		writeln('9 - Verificar altura;');
		writeln('10 - Verificar se a árvore é completa;');
		writeln('11 - Encerrar programa;');
		read(sAction);
		
		iAction := GetNumbersFromString(sAction);
		
		case iAction of
			1: HandleInsert(BinTree);
			2: HandleDelete(BinTree);
			3: InOrder(BinTree);
			4: PostOrder(BinTree);
			5: PreOrder(BinTree);
			6: ShowLeafNodes(BinTree);
			7: HandleCountLeafNodes(BinTree);
			8: HandleShowNodesCount(BinTree);
			9: HandleGetHeight(BinTree);
			10: HandleIsTreeFull(BinTree);
		end;
		
		readkey;
		
		clrscr;
	end; 
End.