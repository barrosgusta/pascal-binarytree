Program GuesserBinaryTree ;

type
	PNode = ^Node;
	Node = Record
	Content: String;
	LeftChild, RightChild, Parent: PNode;
End;

procedure InitBinTree(var root: PNode);
begin
	root := nil;
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

function GetNodeAddressByContent(root:PNode;x:String):PNode;
var AuxLeftNode, AuxRightNode:PNode;
begin
	if (root <> nil) then
	begin
		if (root^.Content <> x) then
		begin
			AuxLeftNode  := GetNodeAddressByContent(root^.LeftChild, x);
			AuxRightNode := GetNodeAddressByContent(root^.RightChild, x);
			
			if (AuxLeftNode <> nil) then
				GetNodeAddressByContent := AuxLeftNode
			else if (AuxRightNode <> nil) then
				GetNodeAddressByContent := AuxRightNode;
		end
		else
			GetNodeAddressByContent := root;	
	end
	else
		GetNodeAddressByContent := nil;	
end;

Procedure InsertIntoTree(var root: PNode; data: String; toRight: boolean);
var
	AuxNode: PNode;
begin
	if root <> nil then
	begin
		if toRight then
		begin
			new(AuxNode);
			AuxNode^.Parent     := root;
			AuxNode^.LeftChild  := nil;
			AuxNode^.RightChild := nil;
			AuxNode^.Content    := data;
			
			root^.RightChild := AuxNode;
		end
		else if not toRight then
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
	begin
		new(AuxNode);
		AuxNode^.Parent     := nil;
		AuxNode^.LeftChild  := nil;
		AuxNode^.RightChild := nil;
		AuxNode^.Content    := data;
		
		root := AuxNode;
	end;
end;

// N�o est� sendo usado
procedure PopulateTree(var root: PNode);
var	AuxNode: PNode;
begin
	//Adiciona a primeira pergunta � ra�z || o parametro true neste caso n�o ir� surtir efeito pois a �rvore est� vazia
	InsertIntoTree(root, '� negro?', False);
	//Busca pelo endere�o da pergunta para adicionar as respostas
	AuxNode := GetNodeAddressByContent(root, '� negro?');
	//Adiciona a pergunta/resposta que ir� aparecer caso a resposta for n�o
	InsertIntoTree(AuxNode, 'Foi famoso nos anos 2000?', False);
	//Adiciona a pergunta/resposta que ir� aparecer caso a resposta for sim
	InsertIntoTree(AuxNode, 'Tem tran�as?', True);
	
	//Prosseguindo pela esquerda da ra�z
	AuxNode := GetNodeAddressByContent(root, 'Foi famoso nos anos 2000?');
	InsertIntoTree(AuxNode, '� o Mac Miller?', False);
	InsertIntoTree(AuxNode, '� o Eminem?', True);

	AuxNode := GetNodeAddressByContent(root, '� o Mac Miller?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	AuxNode := GetNodeAddressByContent(root, '� o Eminem?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	//Prosseguindo pela direita da ra�z
	AuxNode := GetNodeAddressByContent(root, 'Tem tran�as?');
	InsertIntoTree(AuxNode, 'J� foi ou � gordo?', False);
	InsertIntoTree(AuxNode, '� trapper?', True);
	
	AuxNode := GetNodeAddressByContent(root, 'J� foi ou � gordo?');
	InsertIntoTree(AuxNode, 'Tem/tinha costume de andar com uma faixa na cabe�a?', False);
	InsertIntoTree(AuxNode, '� o Notorious B.I.G?', True);
	
	AuxNode := GetNodeAddressByContent(root, '� o Notorious B.I.G?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	AuxNode := GetNodeAddressByContent(root, 'Tem/tinha costume de andar com uma faixa na cabe�a?');
	InsertIntoTree(AuxNode, '� o Drake?', False);
	InsertIntoTree(AuxNode, '� o 2Pac?', True);
	
	AuxNode := GetNodeAddressByContent(root, '� o Drake?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	AuxNode := GetNodeAddressByContent(root, '� o 2Pac?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	AuxNode := GetNodeAddressByContent(root, '� trapper?');
	InsertIntoTree(AuxNode, '� o Snoop Dog?', False);
	InsertIntoTree(AuxNode, '� o Travis Scott?', True);
	
	AuxNode := GetNodeAddressByContent(root, '� o Snoop Dog?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);	
	
	AuxNode := GetNodeAddressByContent(root, '� o Travis Scott?');
	InsertIntoTree(AuxNode, 'N�o tenho informa��es o suficiente para saber quem �', False);
	InsertIntoTree(AuxNode, 'Acertei!!', True);
end;

procedure HandleShowBinTree(root: PNode);
var sValue: string;
begin	
	clrscr;
	
	writeln(root^.Content);
	if (root^.LeftChild <> nil) and (root^.RightChild <> nil) then
	begin
		while (sValue <> 's') and (sValue <> 'n') and (sValue <> 'r') do
		begin
			writeln('s/n? r para voltar a ra�z!');
			read(sValue);
		end;
		
		if (sValue = 's') then
			HandleShowBinTree(root^.RightChild)
		else if (sValue = 'n') then
			HandleShowBinTree(root^.LeftChild)
		else
			exit;
	end
	else
	begin
		while (sValue <> 's') and (sValue <> 'n') and (sValue <> 'r') do
		begin
			writeln('s/n? r para voltar a ra�z!');
			read(sValue);
		end;
	
		
		if (sValue = 's') and (root^.RightChild = nil) then
		begin
			writeln('N�o sei a resposta :(');
			writeln('D� continuidade com uma pergunta/resposta da afirmativa da �ltima pegunta:');
			read(sValue);
			
			InsertIntoTree(root, sValue, True);
			HandleShowBinTree(root^.RightChild);
		end
		else if (sValue = 'n') and (root^.LeftChild = nil) then
		begin
		  writeln('N�o sei a resposta :(');
			writeln('D� continuidade com uma pergunta/resposta da negativa da �ltima pegunta:');
			read(sValue);
			
			InsertIntoTree(root, sValue, False);
			HandleShowBinTree(root^.LeftChild);
		end
		else if (sValue = 's') and (root^.RightChild <> nil) then
		begin
			HandleShowBinTree(root^.RightChild);
		end
		else if (sValue = 'n') and (root^.LeftChild <> nil) then
		begin
			HandleShowBinTree(root^.LeftChild);
		end
		else
			exit;
	end;
end;

procedure MainLoop(var root: PNode);
var sVal : string;
begin
	while true do
	begin
		HandleShowBinTree(root);
		readkey;		
	end
end;

procedure HandleInsertRootQuestion(var root: PNode);
var sValue : string;
begin
	writeln('Qual a pergunta inicial?');
	read(sValue);
	InsertIntoTree(root, sValue, False);
end;

var
 BinTree: PNode;

Begin
  InitBinTree(BinTree);
// Preenche a arvero com perguntas e respostas predefinidas (RapperGuess)
//  PopulateTree(BinTree);
  HandleInsertRootQuestion(BinTree);
  MainLoop(BinTree);
End.