parser grammar MingoXDParser;
options {
    tokenVocab=MingoXDLexer;
}
literal
    :    IntegerLiteral
    |    FloatingPointLiteral
    |    BooleanLiteral
    |    CharacterLiteral
    |    StringLiteral
    |    NullLiteral
    ;
primitiveType
    :    annotation* numericType
    |    annotation* 'boolean'
    ;
numericType
    :    integralType
    |    floatingPointType
    ;
integralType
    :    'int'
    |    'long'
    |    'char'
    ;
floatingPointType
    :    'float'
    |    'double'
    ;
referenceType
    :    classOrInterfaceType
    |    typeVariable
    |    arrayType
    ;
classOrInterfaceType
    :    (classType_lfno_classOrInterfaceType
    |    interfaceType_lfno_classOrInterfaceType)
        (classType_lf_classOrInterfaceType
    |    interfaceType_lf_classOrInterfaceType)*
    ;
classType
    :    annotation* Identifier typeArguments?
    |    classOrInterfaceType '.' annotation* Identifier typeArguments?
    ;
classType_lf_classOrInterfaceType
    :    '.' annotation* Identifier typeArguments?
    ;
classType_lfno_classOrInterfaceType
    :    annotation* Identifier typeArguments?
    ;
interfaceType
    :    classType
    ;
interfaceType_lf_classOrInterfaceType
    :    classType_lf_classOrInterfaceType
    ;
interfaceType_lfno_classOrInterfaceType
    :    classType_lfno_classOrInterfaceType
    ;
typeVariable
    :    annotation* Identifier
    ;
arrayType
    :    primitiveType dims
    |    classOrInterfaceType dims
    |    typeVariable dims
    ;
typeParameter
    :    typeParameterModifier* Identifier typeBound?
    ;
typeParameterModifier
    :    annotation
    ;
typeBound
    :    'extends' typeVariable
    |    'extends' classOrInterfaceType additionalBound*
    ;
additionalBound
    :    '&' interfaceType
    ;
typeArguments
    :    '<' typeArgumentList '>'
    ;
typeArgumentList
    :    typeArgument (',' typeArgument)*
    ;
typeArgument
    :    referenceType
    |    wildcard
    ;
packageName
    :    Identifier
    |    packageName '.' Identifier
    ;
typeName
    :    Identifier
    |    packageOrTypeName '.' Identifier
    ;
packageOrTypeName
    :    Identifier
    |    packageOrTypeName '.' Identifier
    ;

expressionName
    :    Identifier
    |    ambiguousName '.' Identifier
    ;
methodName
    :    Identifier
    ;
classDeclaration
    :    normalClassDeclaration
    ;
normalClassDeclaration
    :    classModifier* 'class' Identifier typeParameters?
superclass? superinterfaces? classBody
    ;
classModifier
    :    annotation
    |    'public'
    |    'protected'
    |    'private'
    |    'abstract'
    |    'static'
    |    'final'
    ;
typeParameters
    :    '<' typeParameterList '>'
    ;
typeParameterList
    :    typeParameter (',' typeParameter)*
    ;
superclass
    :    'extends' classType
    ;
superinterfaces
    :    'implements' interfaceTypeList
    ;
interfaceTypeList
    :    interfaceType (',' interfaceType)*
    ;
classBody
    :    '{' classBodyDeclaration* '}'
    ;
classBodyDeclaration
    :    classMemberDeclaration
    |    instanceInitializer
    |    staticInitializer
    |    constructorDeclaration
    ;





classMemberDeclaration
    :    fieldDeclaration
    |    methodDeclaration
    |    classDeclaration
    |    interfaceDeclaration
    |    ';'
    ;
fieldDeclaration
    :    fieldModifier* unannType variableDeclaratorList ';'
    ;
fieldModifier
    :    annotation
    |    'public'
    |    'protected'
    |    'private'
    |    'static'
    |    'final'
    ;
variableDeclaratorList
    :    variableDeclarator (',' variableDeclarator)*
    ;
variableDeclarator
    :    variableDeclaratorId ('=' variableInitializer)?
    ;
variableDeclaratorId
    :    Identifier dims?
    ;
variableInitializer
    :    expression
    |    arrayInitializer
    ;
methodDeclaration
    :    methodModifier* methodHeader methodBody
    ;
methodModifier
    :    annotation
    |    'public'
    |    'protected'
    |    'private'
    |    'abstract'
    |    'static'
    |    'final'
    ;
methodHeader
    :    result methodDeclarator throws_?
    |    typeParameters annotation* result methodDeclarator
throws_?
    ;



methodDeclarator
    :    Identifier '(' formalParameterList? ')' dims?
    ;
throws_
    :    'throws' exceptionTypeList
    ;
exceptionTypeList
    :    exceptionType (',' exceptionType)*
    ;
exceptionType
    :    classType
    |    typeVariable
    ;
methodBody
    :    block
    |    ';'
    ;
instanceInitializer
    :    block
    ;
staticInitializer
    :    'static' block
    ;
constructorDeclaration
    :    constructorModifier* constructorDeclarator
throws_? constructorBody
    ;
constructorModifier
    :    annotation
    |    'public'
    |    'protected'
    |    'private'
    ;
constructorDeclarator
    :    typeParameters? simpleTypeName '('
formalParameterList? ')'
    ;
simpleTypeName
    :    Identifier
    ;
constructorBody
    :    '{' explicitConstructorInvocation?
blockStatements? '}'
    ;
explicitConstructorInvocation
    :    typeArguments? 'this' '(' argumentList? ')' ';'
    |    typeArguments? 'super' '(' argumentList? ')' ';'
    |    expressionName '.' typeArguments? 'super' '('
argumentList? ')' ';'
    |    primary '.' typeArguments? 'super'
'(' argumentList? ')' ';'
    ;

interfaceDeclaration
    :    normalInterfaceDeclaration
    |    annotationTypeDeclaration
    ;
normalInterfaceDeclaration
    :    interfaceModifier* 'interface' Identifier
typeParameters? extendsInterfaces? interfaceBody
    ;
interfaceModifier
    :    annotation
    |    'public'
    |    'protected'
    |    'private'
    |    'abstract'
    |    'static'
    ;
extendsInterfaces
    :    'extends' interfaceTypeList
    ;
interfaceBody
    :    '{' interfaceMemberDeclaration* '}'
    ;
interfaceMemberDeclaration
    :    constantDeclaration
    |    interfaceMethodDeclaration
    |    classDeclaration
    |    interfaceDeclaration
    |    ';'
    ;
constantDeclaration
    :    constantModifier* unannType
variableDeclaratorList ';'
    ;
constantModifier
    :    annotation
    |    'public'
    |    'static'
    |    'final'
    ;
interfaceMethodDeclaration
    :    interfaceMethodModifier* methodHeader
methodBody
    ;
interfaceMethodModifier
    :    annotation
    |    'public'
    |    'abstract'
    |    'static'
    ;



annotationTypeDeclaration
    :    interfaceModifier* '@' 'interface' Identifier
annotationTypeBody
    ;
annotationTypeBody
    :    '{' annotationTypeMemberDeclaration* '}'
    ;
annotationTypeMemberDeclaration
    :    annotationTypeElementDeclaration
    |    constantDeclaration
    |    classDeclaration
    |    interfaceDeclaration
    |    ';'
    ;
annotationTypeElementDeclaration
    :    annotationTypeElementModifier* unannType
Identifier '(' ')' dims? defaultValue? ';'
    ;
annotationTypeElementModifier
    :    annotation
    |    'public'
    |    'abstract'
    ;
defaultValue
    :    'default' elementValue
    ;
annotation
    :    normalAnnotation
    |    markerAnnotation
    |    singleElementAnnotation
    ;
normalAnnotation
    :    '@' typeName '(' elementValuePairList? ')'
    ;
elementValuePairList
    :    elementValuePair (',' elementValuePair)*
    ;
elementValuePair
    :    Identifier '=' elementValue
    ;
elementValue
    :    conditionalExpression
    |    elementValueArrayInitializer
    |    annotation
    ;
elementValueArrayInitializer
    :    '{' elementValueList? ','? '}'
    ;
elementValueList
    :    elementValue (',' elementValue)*
    ;


markerAnnotation
    :    '@' typeName
    ;
singleElementAnnotation
    :    '@' typeName '(' elementValue ')'
    ;
arrayInitializer
    :    '{' variableInitializerList? ','? '}'
    ;
variableInitializerList
    :    variableInitializer (',' variableInitializer)*
    ;
block
    :    '{' blockStatements? '}'
    ;
blockStatements
    :    blockStatement+
    ;
blockStatement
    :    localVariableDeclarationStatement
    |    classDeclaration
    |    statement
    ;
localVariableDeclarationStatement
    :    localVariableDeclaration ';'
    ;
localVariableDeclaration
    :    variableModifier* unannType variableDeclaratorList
    ;
statement
    :    statementWithoutTrailingSubstatement
    |    labeledStatement
    |    ifThenStatement
    |    ifThenElseStatement
    |    whileStatement
    |    forStatement
    ;
statementNoShortIf
    :    statementWithoutTrailingSubstatement
    |    labeledStatementNoShortIf
    |    ifThenElseStatementNoShortIf
    |    whileStatementNoShortIf
    |    forStatementNoShortIf
    ;
statementWithoutTrailingSubstatement
    :    block
    |    emptyStatement
    |    expressionStatement
    |    assertStatement
    |    switchStatement
    |    doStatement
    |    breakStatement
    |    continueStatement
    |    returnStatement
    |    synchronizedStatement
    |    throwStatement
    |    tryStatement
    ;
emptyStatement
    :    ';'
    ;
labeledStatement
    :    Identifier ':' statement
    ;
labeledStatementNoShortIf
    :    Identifier ':' statementNoShortIf
    ;
expressionStatement
    :    statementExpression ';'
    ;
statementExpression
    :    assignment
    |    preIncrementExpression
    |    preDecrementExpression
    |    postIncrementExpression
    |    postDecrementExpression
    |    methodInvocation
    |    classInstanceCreationExpression
    ;
ifThenStatement
    :    'if' '(' expression ')' statement
    ;
ifThenElseStatement
    :    'if' '(' expression ')' statementNoShortIf 'else'
statement
    ;
ifThenElseStatementNoShortIf
    :    'if' '(' expression ')' statementNoShortIf 'else'
statementNoShortIf
    ;
whileStatement
    :    'while' '(' expression ')' statement
    ;
whileStatementNoShortIf
    :    'while' '(' expression ')' statementNoShortIf
    ;
doStatement
    :    'do' statement 'while' '(' expression ')' ';'
    ;
forStatement
    :    basicForStatement
    |    enhancedForStatement
    ;
forStatementNoShortIf
    :    basicForStatementNoShortIf
    |    enhancedForStatementNoShortIf
    ;
basicForStatement
    :    'for' '(' forInit? ';' expression? ';' forUpdate? ')'
statement
    ;
basicForStatementNoShortIf
    :    'for' '(' forInit? ';' expression? ';' forUpdate? ')'
statementNoShortIf
    ;
breakStatement
    :    'break' Identifier? ';'
    ;
continueStatement
    :    'continue' Identifier? ';'
    ;
returnStatement
    :    'return' expression? ';'
    ;
throwStatement
    :    'throw' expression ';'
    ;
tryStatement
    :    'try' block catches
    |    'try' block catches? finally_
    |    tryWithResourcesStatement
    ;
catches
    :    catchClause catchClause*
    ;
catchClause
    :    'catch' '(' catchFormalParameter ')' block
    ;
catchFormalParameter
    :    variableModifier* catchType variableDeclaratorId
    ;
catchType
    :    unannClassType ('|' classType)*
    ;
finally_
    :    'finally' block
    ;
tryWithResourcesStatement
    :    'try' resourceSpecification block catches? finally_?
    ;
resourceSpecification
    :    '(' resourceList ';'? ')'
    ;
resourceList
    :    resource (';' resource)*
    ;
resource
    :    variableModifier* unannType variableDeclaratorId
'=' expression
    ;



primary
    :    (primaryNoNewArray_lfno_primary
|    arrayCreationExpression)
        (primaryNoNewArray_lf_primary)*
    ;
primaryNoNewArray
    :    literal
    |    typeName ('[' ']')* '.' 'class'
    |    'void' '.' 'class'
    |    'this'
    |    typeName '.' 'this'
    |    '(' expression ')'
    |    classInstanceCreationExpression
    |    fieldAccess
    |    arrayAccess
    |    methodInvocation
    |    methodReference
    ;
primaryNoNewArray_lf_arrayAccess
    :
    ;
primaryNoNewArray_lfno_arrayAccess
    :    literal
    |    typeName ('[' ']')* '.' 'class'
    |    'void' '.' 'class'
    |    'this'
    |    typeName '.' 'this'
    |    '(' expression ')'
    |    classInstanceCreationExpression
    |    fieldAccess
    |    methodInvocation
    |    methodReference
    ;
primaryNoNewArray_lf_primary
    :    classInstanceCreationExpression_lf_primary
    |    fieldAccess_lf_primary
    |    arrayAccess_lf_primary
    |    methodInvocation_lf_primary
    |    methodReference_lf_primary
    ;
primaryNoNewArray_lf_primary_lf_arrayAccess_lf_primary
    :
    ;
primaryNoNewArray_lf_primary_lfno_arrayAccess_lf_primary
    :    classInstanceCreationExpression_lf_primary
    |    fieldAccess_lf_primary
    |    methodInvocation_lf_primary
    |    methodReference_lf_primary
    ;




primaryNoNewArray_lfno_primary
    :    literal
    |    typeName ('[' ']')* '.' 'class'
    |    unannPrimitiveType ('[' ']')* '.' 'class'
    |    'void' '.' 'class'
    |    'this'
    |    typeName '.' 'this'
    |    '(' expression ')'
    |    classInstanceCreationExpression_lfno_primary
    |    fieldAccess_lfno_primary
    |    arrayAccess_lfno_primary
    |    methodInvocation_lfno_primary
    |    methodReference_lfno_primary
    ;
primaryNoNewArray_lfno_primary_lf_arrayAccess_lfno_primary
    :
    ;
primaryNoNewArray_lfno_primary_lfno_arrayAccess_lfno_primary
    :    literal
    |    typeName ('[' ']')* '.' 'class'
    |    unannPrimitiveType ('[' ']')* '.' 'class'
    |    'void' '.' 'class'
    |    'this'
    |    typeName '.' 'this'
    |    '(' expression ')'
    |    classInstanceCreationExpression_lfno_primary
    |    fieldAccess_lfno_primary
    |    methodInvocation_lfno_primary
    |    methodReference_lfno_primary
    ;
classInstanceCreationExpression
    :    'new' typeArguments? annotation* Identifier ('.'
annotation* Identifier)* typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    |    expressionName '.' 'new' typeArguments?
annotation* Identifier typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    |    primary '.' 'new' typeArguments? annotation*
Identifier typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    ;
classInstanceCreationExpression_lf_primary
    :    '.' 'new' typeArguments? annotation* Identifier
typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    ;
classInstanceCreationExpression_lfno_primary
    :    'new' typeArguments? annotation* Identifier ('.'
annotation* Identifier)* typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    |    expressionName '.' 'new' typeArguments?
annotation* Identifier typeArgumentsOrDiamond? '(' argumentList? ')' classBody?
    ;






typeArgumentsOrDiamond
    :    typeArguments
    |    '<' '>'
    ;
fieldAccess
    :    primary '.' Identifier
    |    'super' '.' Identifier
    |    typeName '.' 'super' '.' Identifier
    ;
fieldAccess_lf_primary
    :    '.' Identifier
    ;
fieldAccess_lfno_primary
    :    'super' '.' Identifier
    |    typeName '.' 'super' '.' Identifier
    ;
arrayAccess
    :    (expressionName '[' expression ']'
    |    primaryNoNewArray_lfno_arrayAccess '['
expression ']') (primaryNoNewArray_lf_arrayAccess
'[' expression ']')*
    ;
arrayAccess_lf_primary
    :    ( primaryNoNewArray_lf_primary_lfno_
arrayAccess_lf_primary '[' expression ']')
        (primaryNoNewArray_lf_primary_lf_
arrayAccess_lf_primary '[' expression ']')*
    ;
arrayAccess_lfno_primary
    :    (expressionName '[' expression ']'
    |    primaryNoNewArray_lfno_primary_lfno_
arrayAccess_lfno_primary '[' expression ']')
        (primaryNoNewArray_lfno_primary_lf_
arrayAccess_lfno_primary '[' expression ']')*
    ;
methodInvocation
    :    methodName '(' argumentList? ')'
    |    typeName '.' typeArguments? Identifier '('
argumentList? ')'
    |    expressionName '.' typeArguments? Identifier '('
argumentList? ')'
    |    primary '.' typeArguments? Identifier '('
argumentList? ')'
    |    'super' '.' typeArguments? Identifier '(' argumentList?
')'
    |    typeName '.' 'super' '.' typeArguments? Identifier '('
argumentList? ')'
    ;
methodInvocation_lf_primary
    :    '.' typeArguments? Identifier '(' argumentList? ')'
    ;






methodInvocation_lfno_primary
    :    methodName '(' argumentList? ')'
    |    typeName '.' typeArguments? Identifier '('
argumentList? ')'
    |    expressionName '.' typeArguments? Identifier '('
argumentList? ')'
    |    'super' '.' typeArguments? Identifier '(' argumentList?
')'
    |    typeName '.' 'super' '.' typeArguments? Identifier '('
argumentList? ')'
    ;
argumentList
    :    expression (',' expression)*
    ;
methodReference
    :    expressionName '::' typeArguments? Identifier
    |    referenceType '::' typeArguments? Identifier
    |    primary '::' typeArguments? Identifier
    |    'super' '::' typeArguments? Identifier
    |    typeName '.' 'super' '::' typeArguments? Identifier
    |    classType '::' typeArguments? 'new'
    |    arrayType '::' 'new'
    ;
methodReference_lf_primary
    :    '::' typeArguments? Identifier
    ;
methodReference_lfno_primary
    :    expressionName '::' typeArguments? Identifier
    |    referenceType '::' typeArguments? Identifier
    |    'super' '::' typeArguments? Identifier
    |    typeName '.' 'super' '::' typeArguments? Identifier
    |    classType '::' typeArguments? 'new'
    |    arrayType '::' 'new'
    ;
arrayCreationExpression
    :    'new' primitiveType dimExprs dims?
    |    'new' classOrInterfaceType dimExprs dims?
    |    'new' primitiveType dims arrayInitializer
    |    'new' classOrInterfaceType dims arrayInitializer
    ;
constantExpression
    :    expression
    ;
expression
    :    lambdaExpression
    |    assignmentExpression
    ;
lambdaExpression
    :    lambdaParameters '->' lambdaBody
    ;

lambdaParameters
    :    Identifier
    |    '(' formalParameterList? ')'
    |    '(' inferredFormalParameterList ')'
    ;
inferredFormalParameterList
    :    Identifier (',' Identifier)*
    ;
lambdaBody
    :    expression
    |    block
    ;
assignmentExpression
    :    conditionalExpression
    |    assignment
    ;
assignment
    :    leftHandSide assignmentOperator expression
    ;
leftHandSide
    :    expressionName
    |    fieldAccess
    |    arrayAccess
    ;
assignmentOperator
    :    '='
    |    '*='
    |    '/='
    |    '%='
    |    '+='
    |    '-='
    |    '<<='
    |    '>>='
    |    '>>>='
    |    '&='
    |    '^='
    |    '|='
    ;
conditionalExpression
    :    conditionalOrExpression
    |    conditionalOrExpression '?' expression ':'
conditionalExpression
    ;
conditionalOrExpression
    :    conditionalAndExpression
    |    conditionalOrExpression '||'
conditionalAndExpression
    ;




conditionalAndExpression
    :    inclusiveOrExpression
    |    conditionalAndExpression '&&'
inclusiveOrExpression
    ;
andExpression
    :    equalityExpression
    |    andExpression '&' equalityExpression
    ;
equalityExpression
    :    relationalExpression
    |    equalityExpression '==' relationalExpression
    |    equalityExpression '!=' relationalExpression
    ;
relationalExpression
    :    shiftExpression
    |    relationalExpression '<' shiftExpression
    |    relationalExpression '>' shiftExpression
    |    relationalExpression '<=' shiftExpression
    |    relationalExpression '>=' shiftExpression
    |    relationalExpression 'instanceof' referenceType
    ;
additiveExpression
    :    multiplicativeExpression
    |    additiveExpression '+' multiplicativeExpression
    |    additiveExpression '-' multiplicativeExpression
    ;
multiplicativeExpression
    :    unaryExpression
    |    multiplicativeExpression '*' unaryExpression
    |    multiplicativeExpression '/' unaryExpression
    |    multiplicativeExpression '%' unaryExpression
    ;
unaryExpression
    :    preIncrementExpression
    |    preDecrementExpression
    |    '+' unaryExpression
    |    '-' unaryExpression
    |    unaryExpressionNotPlusMinus
    ;
preIncrementExpression
    :    '++' unaryExpression
    ;
preDecrementExpression
    :    '--' unaryExpression
    ;
unaryExpressionNotPlusMinus
    :    postfixExpression
    |    '~' unaryExpression
    |    '!' unaryExpression
    |    castExpression
    ;

postfixExpression
    :    (primary
    |    expressionName)
        (postIncrementExpression_lf_ postfixExpression
    |    postDecrementExpression_lf_postfixExpression)*
    ;
postIncrementExpression
    :    postfixExpression '++'
    ;
postIncrementExpression_lf_postfixExpression
    :    '++'
    ;
postDecrementExpression
    :    postfixExpression '--'
    ;
postDecrementExpression_lf_postfixExpression
    :    '--'
    ;
castExpression
    :    '(' primitiveType ')' unaryExpression
    |    '(' referenceType additionalBound* ')'
unaryExpressionNotPlusMinus
    |    '(' referenceType additionalBound* ')'
lambdaExpression
    ;
