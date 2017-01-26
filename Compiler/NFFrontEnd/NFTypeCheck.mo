/*
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-2014, Open Source Modelica Consortium (OSMC),
 * c/o Linköpings universitet, Department of Computer and Information Science,
 * SE-58183 Linköping, Sweden.
 *
 * All rights reserved.
 *
 * THIS PROGRAM IS PROVIDED UNDER THE TERMS OF GPL VERSION 3 LICENSE OR
 * THIS OSMC PUBLIC LICENSE (OSMC-PL) VERSION 1.2.
 * ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES
 * RECIPIENT'S ACCEPTANCE OF THE OSMC PUBLIC LICENSE OR THE GPL VERSION 3,
 * ACCORDING TO RECIPIENTS CHOICE.
 *
 * The OpenModelica software and the Open Source Modelica
 * Consortium (OSMC) Public License (OSMC-PL) are obtained
 * from OSMC, either from the above address,
 * from the URLs: http://www.ida.liu.se/projects/OpenModelica or
 * http://www.openmodelica.org, and in the OpenModelica distribution.
 * GNU version 3 is obtained from: http://www.gnu.org/copyleft/gpl.html.
 *
 * This program is distributed WITHOUT ANY WARRANTY; without
 * even the implied warranty of  MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
 * IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS OF OSMC-PL.
 *
 * See the full OSMC Public License conditions for more details.
 *
 */

encapsulated package NFTypeCheck
" file:        NFTypeCheck.mo
  package:     NFTypeCheck
  description: SCodeInst type checking.


  Functions used by SCodeInst for type checking and type conversion where needed.
"

import DAE;
import Dimension = NFDimension;
import NFExpression.Expression;

protected
import Debug;
import DAEExpression = Expression;
import Error;
import ExpressionDump;
import List;
import Types;
import Operator = NFOperator;
import Type = NFType;

public
//
//
//public function checkClassComponents
//  input Class inClass;
//  input Context inContext;
//  input SymbolTable inSymbolTable;
//  output Class outClass;
//  output SymbolTable outSymbolTable;
//algorithm
//  (outClass, outSymbolTable) :=
//    checkClass(inClass, NONE(), inContext, inSymbolTable);
//end checkClassComponents;
//
//public function checkClass
//  input Class inClass;
//  input Option<Component> inParent;
//  input Context inContext;
//  input SymbolTable inSymbolTable;
//  output Class outClass;
//  output SymbolTable outSymbolTable;
//algorithm
//  (outClass, outSymbolTable) := match(inClass, inParent, inContext, inSymbolTable)
//    local
//      list<Element> comps;
//      list<Equation> eq, ieq;
//      list<list<Statement>> al, ial;
//      SymbolTable st;
//      Absyn.Path name;
//
//    case (NFInstTypes.BASIC_TYPE(_), _, _, st) then (inClass, st);
//
//    case (NFInstTypes.COMPLEX_CLASS(name, comps, eq, ieq, al, ial), _, _, st)
//      equation
//        (comps, st) = List.map2Fold(comps, checkElement, inParent, inContext, st);
//      then
//        (NFInstTypes.COMPLEX_CLASS(name, comps, eq, ieq, al, ial), st);
//
//  end match;
//end checkClass;
//
//protected function checkElement
//  input Element inElement;
//  input Option<Component> inParent;
//  input Context inContext;
//  input SymbolTable inSymbolTable;
//  output Element outElement;
//  output SymbolTable outSymbolTable;
//algorithm
//  (outElement, outSymbolTable) :=
//  match(inElement, inParent, inContext, inSymbolTable)
//    local
//      Component comp;
//      Class cls;
//      Absyn.Path name;
//      SymbolTable st;
//      SourceInfo info;
//      String str;
//
//    case (NFInstTypes.ELEMENT(NFInstTypes.UNTYPED_COMPONENT(name = name, info = info), _),
//        _, _, _)
//      equation
//        str = "Found untyped component: " + Absyn.pathString(name);
//        Error.addSourceMessage(Error.INTERNAL_ERROR, {str}, info);
//      then
//        fail();
//
//    case (NFInstTypes.ELEMENT(comp, cls), _, _, st)
//      equation
//        (comp, st)= checkComponent(comp, inParent, inContext, st);
//        (cls, st) = checkClass(cls, SOME(comp), inContext, st);
//      then
//        (NFInstTypes.ELEMENT(comp, cls), st);
//
//    case (NFInstTypes.CONDITIONAL_ELEMENT(_), _, _, _)
//      then (inElement, inSymbolTable);
//
//  end match;
//end checkElement;
//
//protected function checkComponent
//  input Component inComponent;
//  input Option<Component> inParent;
//  input Context inContext;
//  input SymbolTable inSymbolTable;
//  output Component outComponent;
//  output SymbolTable outSymbolTable;
//algorithm
//  (outComponent, outSymbolTable) :=
//  match(inComponent, inParent, inContext, inSymbolTable)
//    local
//      Absyn.Path name;
//      Type ty;
//      Binding binding;
//      SymbolTable st;
//      Component comp, inner_comp;
//      Context c;
//      String str;
//      SourceInfo info;
//
//    case (NFInstTypes.UNTYPED_COMPONENT(name = name,  info = info),
//        _, _, _)
//      equation
//        str = "Found untyped component: " + Absyn.pathString(name);
//        Error.addSourceMessage(Error.INTERNAL_ERROR, {str}, info);
//      then
//        fail();
//
//    // check and convert if needed the type of
//    // the binding vs the type of the component
//    case (NFInstTypes.TYPED_COMPONENT(), _, _, st)
//      equation
//        comp = NFInstUtil.setComponentParent(inComponent, inParent);
//        comp = checkComponentBindingType(comp);
//      then
//        (comp, st);
//
//    case (NFInstTypes.OUTER_COMPONENT(innerName = SOME(name)), _, _, st)
//      equation
//        comp = NFInstSymbolTable.lookupName(name, st);
//        (comp, st) = checkComponent(comp, inParent, inContext, st);
//      then
//        (comp, st);
//
//    case (NFInstTypes.OUTER_COMPONENT( innerName = NONE()), _, _, st)
//      equation
//        (_, SOME(inner_comp), st) = NFInstSymbolTable.updateInnerReference(inComponent, st);
//        (inner_comp, st) = checkComponent(inner_comp, inParent, inContext, st);
//      then
//        (inner_comp, st);
//
//    case (NFInstTypes.CONDITIONAL_COMPONENT(name = name), _, _, _)
//      equation
//        print("Trying to type conditional component " + Absyn.pathString(name) + "\n");
//      then
//        fail();
//
//    case (NFInstTypes.DELETED_COMPONENT(), _, _, st)
//      then (inComponent, st);
//
//  end match;
//end checkComponent;
//
//protected function checkComponentBindingType
//  input Component inC;
//  output Component outC;
//algorithm
//  outC := matchcontinue (inC)
//    local
//      Type ty, propagatedTy, convertedTy;
//      Absyn.Path name, eName;
//      Option<Component> parent;
//      DaePrefixes prefixes;
//      Binding binding;
//      SourceInfo info;
//      Expression bindingExp;
//      Type bindingType;
//      Integer propagatedDims "See NFSCodeMod.propagateMod.";
//      SourceInfo binfo;
//      String nStr, eStr, etStr, btStr;
//      DAE.Dimensions parentDimensions;
//
//    // nothing to check
//    case (NFInstTypes.TYPED_COMPONENT(binding = NFInstTypes.UNBOUND()))
//      then
//        inC;
//
//    // when the component name is equal to the component type we have a constant enumeration!
//    // StateSelect = {StateSelect.always, StateSelect.prefer, StateSelect.default, StateSelect.avoid, StateSelect.never}
//    case (NFInstTypes.TYPED_COMPONENT(name = name, ty = DAE.T_ENUMERATION(path = eName)))
//      equation
//        true = Absyn.pathEqual(name, eName);
//      then
//        inC;
//
//    case (NFInstTypes.TYPED_COMPONENT(name, ty, parent, prefixes, binding, info))
//      equation
//        NFInstTypes.TYPED_BINDING(bindingExp, bindingType, propagatedDims, binfo) = binding;
//        parentDimensions = getParentDimensions(parent, {});
//        propagatedTy = liftArray(ty, parentDimensions, propagatedDims);
//        (bindingExp, convertedTy) = Types.matchType(bindingExp, bindingType, propagatedTy, true);
//        binding = NFInstTypes.TYPED_BINDING(bindingExp, convertedTy, propagatedDims, binfo);
//      then
//        NFInstTypes.TYPED_COMPONENT(name, ty, parent, prefixes, binding, info);
//
//    case (NFInstTypes.TYPED_COMPONENT(name, ty, parent, _, binding, info))
//      equation
//        NFInstTypes.TYPED_BINDING(bindingExp, bindingType, propagatedDims, _) = binding;
//        parentDimensions = getParentDimensions(parent, {});
//        propagatedTy = liftArray(ty, parentDimensions, propagatedDims);
//        failure((_, _) = Types.matchType(bindingExp, bindingType, propagatedTy, true));
//        nStr = Absyn.pathString(name);
//        eStr = ExpressionDump.printExpStr(bindingExp);
//        etStr = Types.unparseTypeNoAttr(propagatedTy);
//        etStr = etStr + " propDim: " + intString(propagatedDims);
//        btStr = Types.unparseTypeNoAttr(bindingType);
//        Error.addSourceMessage(Error.VARIABLE_BINDING_TYPE_MISMATCH,
//        {nStr, eStr, etStr, btStr}, info);
//      then
//        fail();
//
//    else
//      equation
//        //name = NFInstUtil.getComponentName(inC);
//        //nStr = "Found untyped component: " + Absyn.pathString(name);
//        //Error.addMessage(Error.INTERNAL_ERROR, {nStr});
//      then
//        fail();
//
//  end matchcontinue;
//end checkComponentBindingType;
//
//protected function getParentDimensions
//"get the dimensions from the parents of the component up to the root"
//  input Option<Component> inParentOpt;
//  input DAE.Dimensions inDimensionsAcc;
//  output DAE.Dimensions outDimensions;
//algorithm
//  outDimensions := matchcontinue(inParentOpt, inDimensionsAcc)
//    local
//      Component c;
//      DAE.Dimensions dims;
//
//    case (NONE(), _) then inDimensionsAcc;
//
//    case (SOME(c), _)
//      equation
//        dims = NFInstUtil.getComponentTypeDimensions(c);
//        dims = listAppend(dims, inDimensionsAcc);
//        dims = getParentDimensions(NFInstUtil.getComponentParent(c), dims);
//      then
//        dims;
//    // for other...
//    case (SOME(_), _) then inDimensionsAcc;
//  end matchcontinue;
//end getParentDimensions;
//
//protected function liftArray
// input Type inTy;
// input DAE.Dimensions inParentDimensions;
// input Integer inPropagatedDims;
// output Type outTy;
//algorithm
// outTy := matchcontinue(inTy, inParentDimensions, inPropagatedDims)
//   local
//     Integer pdims;
//     Type ty;
//     DAE.Dimensions dims;
//     TypeSource ts;
//
//   case (_, _, -1) then inTy;
//   // TODO! FIXME! check if we can actually have propagated dims of 0
//   case (_, {}, 0) then inTy;
//   // we have some parent dims
//   case (_, _::_, 0)
//     equation
//       ts = Types.getTypeSource(inTy);
//       ty = DAE.T_ARRAY(inTy, inParentDimensions, ts);
//     then ty;
//   // we can take the lastN from the propagated dims!
//   case (_, _, pdims)
//     equation
//       false = Types.isArray(inTy);
//       ts = Types.getTypeSource(inTy);
//       dims = List.lastN(inParentDimensions, pdims);
//       ty = DAE.T_ARRAY(inTy, dims, ts);
//     then
//       ty;
//   // we can take the lastN from the propagated dims!
//   case (_, _, pdims)
//     equation
//       true = Types.isArray(inTy);
//       ty = Types.unliftArray(inTy);
//       ts = Types.getTypeSource(inTy);
//       dims = listAppend(inParentDimensions, Types.getDimensions(inTy));
//       dims = List.lastN(dims, pdims);
//       ty = DAE.T_ARRAY(ty, dims, ts);
//     then
//       ty;
//    case (_, {}, _) then inTy;
//    else DAE.T_ARRAY(inTy, inParentDimensions, DAE.emptyTypeSource);
//  end matchcontinue;
//end liftArray;
//
//public function checkExpEquality
//  input Expression inExp1;
//  input Type inTy1;
//  input Expression inExp2;
//  input Type inTy2;
//  input String inMessage;
//  input SourceInfo inInfo;
//  output Expression outExp1;
//  output Type outTy1;
//  output Expression outExp2;
//  output Type outTy2;
//algorithm
//  (outExp1, outTy1, outExp2, outTy2) := matchcontinue(inExp1, inTy1, inExp2, inTy2, inMessage, inInfo)
//    local
//      Expression e;
//      Type t;
//      String e1Str, t1Str, e2Str, t2Str, s1, s2;
//
//    // Check if the Rhs matchs/can be converted to match the Lhs
//    case (_, _, _, _, _, _)
//      equation
//        (e, t) = Types.matchType(inExp2, inTy2, inTy1, true);
//      then
//        (inExp1, inTy1, e, t);
//
//    // the other way arround just for equations!
//    case (_, _, _, _, "equ", _)
//      equation
//        (e, t) = Types.matchType(inExp1, inTy1, inTy2, true);
//      then
//        (e, t, inExp2, inTy2);
//
//    // not really fine!
//    case (_, _, _, _, "equ", _)
//      equation
//        e1Str = ExpressionDump.printExpStr(inExp1);
//        t1Str = Types.unparseTypeNoAttr(inTy1);
//        e2Str = ExpressionDump.printExpStr(inExp2);
//        t2Str = Types.unparseTypeNoAttr(inTy2);
//        s1 = stringAppendList({e1Str,"=",e2Str});
//        s2 = stringAppendList({t1Str,"=",t2Str});
//        Error.addSourceMessage(Error.EQUATION_TYPE_MISMATCH_ERROR, {s1,s2}, inInfo);
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.checkExpEquality failed with type mismatch: " + s1 + " tys: " + s2);
//      then
//        fail();
//
//    case (_, _, _, _, "alg", _)
//      equation
//        e1Str = ExpressionDump.printExpStr(inExp1);
//        t1Str = Types.unparseTypeNoAttr(inTy1);
//        e2Str = ExpressionDump.printExpStr(inExp2);
//        t2Str = Types.unparseTypeNoAttr(inTy2);
//        s1 = stringAppendList({e1Str,":=",e2Str});
//        s2 = stringAppendList({t1Str,":=",t2Str});
//        Error.addSourceMessage(Error.ASSIGN_TYPE_MISMATCH_ERROR, {e1Str,e2Str,t1Str,t2Str}, inInfo);
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.checkExpEquality failed with type mismatch: " + s1 + " tys: " + s2);
//      then
//        fail();
//  end matchcontinue;
//end checkExpEquality;
//
//
//
//
// ************************************************************** //
//   BEGIN: Operator typing helper functions
// ************************************************************** //


function checkLogicalBinaryOperation
  "mahge:
  Type checks logical binary operations. operations on scalars are handled
  simply by using Types.matchType().
  Operations involving Complex types are handled differently."
  input Expression exp1;
  input Type type1;
  input Operator operator;
  input Expression exp2;
  input Type type2;
  output Expression exp;
  output Type ty;
protected
  Expression e1, e2;
  Operator op;
  //TypeSource ty_src;
  String e1_str, e2_str, ty1_str, ty2_str, msg_str, op_str, s1, s2;
algorithm
  try
    true := Type.isBoolean(type1) and Type.isBoolean(type2);

    // Logical binary operations here are allowed only on Booleans.
    // The Modelica Specification 3.2 doesn't say anything if they should be
    // allowed or not on scalars of type Integers/Reals.
    // It says no for arrays of Integer/Real type.
    (e1, e2, ty, true) := matchExpressions(exp1, type1, exp2, type2);
    op := Operator.setType(ty, operator);

    exp := Expression.LBINARY(e1, op, e2);
  else
    e1_str := Expression.toString(exp1);
    e2_str := Expression.toString(exp2);
    ty1_str := Type.toString(type1);
    ty2_str := Type.toString(type2);
    op_str := Operator.symbol(operator);

    // Check if we have relational operations involving array types.
    // Just for proper error messages.
    msg_str := if not (Type.isBoolean(type1) or Type.isBoolean(type2)) then
      "\n: Logical operations involving non-Boolean types are not valid in Modelica." else ty1_str;

    s1 := "' " + e1_str + op_str + e2_str + " '";
    s2 := "' " + ty1_str + op_str + ty2_str + " '";

    Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1, s2, msg_str}, Absyn.dummyInfo);
  end try;
end checkLogicalBinaryOperation;

public function checkLogicalUnaryOperation
  "petfr:
  Typechecks logical unary operations, i.e. the not operator"
  input Expression exp1;
  input Type type1;
  input Operator operator;
  output Expression exp;
  output Type ty;
protected
  Expression e1;
  Operator op;
  //TypeSource ty_src;
  String e1_str, ty1_str, msg_str, op_str, s1;
algorithm
  try
    true := Type.isBoolean(type1);
    // Logical unary operations here are allowed only on Booleans.
    ty := type1;
    op := Operator.setType(ty, operator);
    exp := Expression.LUNARY(op, exp1);

  else
    e1_str := Expression.toString(exp1);
    ty1_str := Type.toString(type1);
    op_str := Operator.symbol(operator);

    // Just for proper error messages.
    msg_str := if not (Type.isBoolean(type1)) then
      "\n: Logical operations involving non-Boolean types are not valid in Modelica." else ty1_str;

    s1 := "' " + e1_str + op_str  + " '";

    Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1, msg_str}, Absyn.dummyInfo);
  end try;
end checkLogicalUnaryOperation;

public function checkRelationOperation
  "mahge:
  Type checks relational operations. Relations on scalars are handled
  simply by using Types.matchType(). This way conversions from Integer to real
  are handled internaly."
  input Expression exp1;
  input Type type1;
  input Operator operator;
  input Expression exp2;
  input Type type2;
  output Expression exp;
  output Type ty;
protected
  Expression e1, e2;
  Operator op;
  //TypeSource ty_src;
  String e1_str, e2_str, ty1_str, ty2_str, msg_str, op_str, s1, s2;
algorithm
  try
    true := Type.isScalarBuiltin(type1) and Type.isScalarBuiltin(type2);

    // Check types match/can be converted to match.
    (e1, e2, ty, true) := matchExpressions(exp1, type1, exp2, type2);
    //ty_src := Types.getTypeSource(ty);
    //ty := DAE.T_BOOL({}, ty_src);
    ty := Type.BOOLEAN();
    op := Operator.setType(ty, operator);

    exp := Expression.RELATION(e1, op, e2);
  else
    e1_str := Expression.toString(exp1);
    e2_str := Expression.toString(exp2);
    ty1_str := Type.toString(type1);
    ty2_str := Type.toString(type2);
    op_str := Operator.symbol(operator);

    // Check if we have relational operations involving array types.
    // Just for proper error messages.
    msg_str := if Type.isArray(type1) or Type.isArray(type2) then
      "\n: Relational operations involving array types are not valid in Modelica." else ty1_str;

    s1 := "' " + e1_str + op_str + e2_str + " '";
    s2 := "' " + ty1_str + op_str + ty2_str + " '";

    Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1, s2, msg_str}, Absyn.dummyInfo);
  end try;
end checkRelationOperation;

public function checkBinaryOperation
  "mahge:
  Type checks binary operations. operations on scalars are handled
  simply by using Types.matchType(). This way conversions from Integer to Real
  are handled internally.
  Operations involving arrays and Complex types are handled differently."
  input Expression exp1;
  input Type type1;
  input Operator operator;
  input Expression exp2;
  input Type type2;
  output Expression binaryExp;
  output Type binaryType;
protected
  Expression e1, e2;
  Operator op;
  //TypeSource ty_src;
  String e1_str, e2_str, ty1_str, ty2_str, s1, s2;
algorithm
  // All operators expect Numeric types except Addition.
  true := checkValidNumericTypesForOp(type1, type2, operator, true);

  try
    if Type.isScalarBuiltin(type1) and Type.isScalarBuiltin(type2) then
      // Binary expression with expression of simple type.

      (e1, e2, binaryType) := match operator
        // Addition operations on Scalars.
        // Check if the operands (match/can be converted to match) the other.
        case Operator.ADD()
          algorithm
            (e1, e2, binaryType, true) := matchExpressions(exp1, type1, exp2, type2);
          then
            (e1, e2, binaryType);

        case Operator.SUB()
          algorithm
            (e1, e2, binaryType, true) := matchExpressions(exp1, type1, exp2, type2);
          then
            (e1, e2, binaryType);

        case Operator.MUL()
          algorithm
            (e1, e2, binaryType, true) := matchExpressions(exp1, type1, exp2, type2);
          then
            (e1, e2, binaryType);

        // Check division operations.
        // They result in T_REAL regardless of the operand types.
        case Operator.DIV()
          algorithm
            (e1, e2, binaryType, true) := matchExpressions(exp1, type1, exp2, type2);

            //ty_src := Types.getTypeSource(type1);
          then
            (e1, e2, Type.REAL());

        // Check exponentiations.
        // They result in T_REAL regardless of the operand types.
        // According to spec operands should be promoted to real before expon.
        // to fit with ANSI C ???.
        case Operator.POW()
          algorithm
            // Try converting both to Real type.
            (e1, _, true) := matchTypes(type1, Type.REAL(), exp1);
            (e2, _, true) := matchTypes(type2, Type.REAL(), exp2);
            //ty_src := Types.getTypeSource(type1);
          then
            (e1, e2, Type.REAL());

      end match;

      op := Operator.setType(binaryType, operator);
      binaryExp := Expression.BINARY(e1, op, e2);
    else
      // Binary expression with expressions of array type.
      (binaryExp, binaryType) := checkBinaryOperationArrays(exp1, type1, operator, exp2, type2);
    end if;
  else
    e1_str := Expression.toString(exp1);
    e2_str := Expression.toString(exp2);
    ty1_str := Type.toString(type1);
    ty2_str := Type.toString(type2);
    s1 := "' " + e1_str + Operator.symbol(operator) + e2_str + " '";
    s2 := "' " + ty1_str + Operator.symbol(operator) + ty2_str + " '";
    Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1, s2, ty1_str}, Absyn.dummyInfo);
    fail();
  end try;
end checkBinaryOperation;

public function checkUnaryOperation
  "petfr:
  Type checks arithmetic unary operations. Both for simple scalar types and
  operations involving array types. Builds DAE unary node."
  input Expression exp1;
  input Type type1;
  input Operator operator;
  output Expression unaryExp;
  output Type unaryType;
protected
  Operator op;
  //TypeSource ty_src;
  String e1_str, ty1_str, s1;
algorithm
  try
    // Arithmetic type expected for Unary operators, i.e., UMINUS, UMINUS_ARR;  UPLUS removed
    true := Type.isNumeric(type1);

    unaryType := type1;
    op := Operator.setType(unaryType, operator);
    unaryExp := match op
              case Operator.ADD() then exp1; // If UNARY +, +exp1, remove it since no unary Operator.ADD
              else Expression.UNARY(op, exp1);
            end match;
  else
    e1_str := Expression.toString(exp1);
    ty1_str := Type.toString(type1);
    s1 := "' " + e1_str + Operator.symbol(operator) + " '" +
       " Arithmetic type expected for this unary operator ";
    Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1, ty1_str}, Absyn.dummyInfo);
    fail();
  end try;
end checkUnaryOperation;

public function checkBinaryOperationArrays
  "mahge:
  Type checks binary operations involving arrays. This involves more checks than
  scalar types. All normal operations as well as element wise operations involving
  arrays are handled here."
  input Expression inExp1;
  input Type inType1;
  input Operator inOp;
  input Expression inExp2;
  input Type inType2;
  output Expression outExp;
  output Type outType;
protected
  Boolean isArray1,isArray2, bothArrays;
  Integer nrDims1, nrDims2;
algorithm

  nrDims1 := Type.dimensionCount(inType1);
  nrDims2 := Type.dimensionCount(inType2);
  isArray1 := nrDims1 > 0;
  isArray2 := nrDims2 > 0;
  bothArrays := isArray1 and isArray2;

  (outExp, outType) := match inOp
    local
      Expression exp1,exp2;
      Type ty1,ty2, arrtp, ty;
      list<Dimension> dims;
      Dimension M,N1,N2,K;
      Operator newop;
      //TypeSource typsrc;

    case Operator.ADD()
      algorithm
        if (bothArrays) then
          (exp1,exp2,outType, true) := matchExpressions(inExp1,inType1,inExp2,inType2);
          outExp := Expression.BINARY(exp1, Operator.ADD(outType), exp2);
        else
          binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Addition operations involving an array and a scalar are " +
            "not valid in Modelica. Try using elementwise operator '.+'");
          fail();
        end if;
      then
        (outExp, outType);

    case Operator.SUB()
      algorithm
        if (bothArrays) then
          (exp1,exp2,outType, true) := matchExpressions(inExp1,inType1,inExp2,inType2);
          outExp := Expression.BINARY(exp1, Operator.SUB(outType), exp2);
        else
          binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Subtraction operations involving an array and a scalar are " +
            "not valid in Modelica. Try using elementwise operator '.+'");
          fail();
        end if;
      then
        (outExp, outType);

    case Operator.DIV()
      algorithm
        if (isArray1 and not isArray2) then
          dims := Type.arrayDims(inType1);
          arrtp := Type.liftArrayLeftList(inType2,dims);

          (exp1,exp2,_, true) := matchExpressions(inExp1,inType1,inExp2,arrtp);

          // Create a scalar Real Type and lift it to array.
          // Necessary because even if both operands are of Integer type the result
          // should be Real type with dimensions of the input array operand.
          //typsrc := Types.getTypeSource(ty1);
          ty := Type.REAL();

          outType := Type.liftArrayLeftList(ty,dims);
          outExp := Expression.BINARY(exp1, Operator.DIV_ARRAY_SCALAR(outType), exp2);
        else
          binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Dividing a sclar by array or array by array is not a valid " +
            "operation in Modelica. Try using elementwise operator './'");
          fail();
        end if;
      then
        (outExp, outType);

    case Operator.POW()
      algorithm
        if (nrDims1 == 2 and not isArray2) then
          {M, K} := Type.arrayDims(inType1);

          // Check if dims are equal. i.e Square Matrix
          if not(isValidMatrixMultiplyDims(M, K)) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
              "\n: Exponentiation involving arrays is only valid for square " +
              "matrices with integer exponents. Try using elementwise operator '.^'");
            fail();
          end if;

          if not Type.isInteger(inType2) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
              "\n: Exponentiation involving arrays is only valid for square " +
              "matrices with integer exponents. Try using elementwise operator '.^'");
            fail();
          end if;

          outType := inType1;
          outExp := Expression.BINARY(inExp1, Operator.POW_ARRAY_SCALAR(inType1), inExp2);
        else
          binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Exponentiation involving arrays is only valid for square " +
            "matrices with integer exponents. Try using elementwise operator '.^'");
          fail();
        end if;
      then
        (outExp, outType);


    case Operator.MUL()
      algorithm
        if (not isArray1 or not isArray2) then

          arrtp := if isArray1 then inType1 else inType2;
          dims := Type.arrayDims(arrtp);
          //match their scalar types. For now.
          ty1 := Type.elementType(inType1);
          ty2 := Type.elementType(inType2);
          // TODO: one of the exps is array but its type is now simple.
          (exp1,exp2,ty, true) := matchExpressions(inExp1,ty1,inExp2,ty2);

          outType := Type.liftArrayLeftList(ty,dims);
          outExp := Expression.BINARY(exp1, Operator.MUL_ARRAY_SCALAR(outType), exp2);

        elseif (nrDims1 == 1 and nrDims2 == 1) then
          {N1} := Type.arrayDims(inType1);
          {N2} := Type.arrayDims(inType2);
          if (not isValidMatrixMultiplyDims(N1,N2)) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Dimensions not equal for scalar product.");
            fail();
          else
            (exp1,exp2,ty, true) := matchExpressions(inExp1,inType1,inExp2,inType2);
            outType := Type.elementType(ty);
            outExp := Expression.BINARY(exp1, Operator.MUL_SCALAR_PRODUCT(outType), exp2);
          end if;

        elseif (nrDims1 == 2 and nrDims2 == 1) then
          {M,N1} := Type.arrayDims(inType1);
          {N2} := Type.arrayDims(inType2);
          if (not isValidMatrixMultiplyDims(N1,N2)) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Dimensions error in Matrix Vector multiplication.");
            fail();
          else
            ty1 := Type.elementType(inType1);
            ty2 := Type.elementType(inType2);
            // TODO: the exps are arrays but the types are now simple.
            (exp1,exp2,ty, true) := matchExpressions(inExp1,ty1,inExp2,ty2);
            outType := Type.liftArrayLeftList(ty, {M});
            outExp := Expression.BINARY(exp1, Operator.MUL_MATRIX_PRODUCT(outType), exp2);
          end if;

        elseif (nrDims1 == 1 and nrDims2 == 2) then

          {N1} := Type.arrayDims(inType1);
          {N2,M} := Type.arrayDims(inType2);
          if (not isValidMatrixMultiplyDims(N1,N2)) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Dimensions error in Vecto Matrix multiplication.");
            fail();
          else
            ty1 := Type.elementType(inType1);
            ty2 := Type.elementType(inType2);
            // TODO: the exps are arrays but the types are now simple.
            (exp1,exp2,ty, true) := matchExpressions(inExp1,ty1,inExp2,ty2);
            outType := Type.liftArrayLeftList(ty, {M});
            outExp := Expression.BINARY(exp1, Operator.MUL_MATRIX_PRODUCT(outType), exp2);
          end if;

        elseif (nrDims1 == 2 and nrDims2 == 2) then

          {M,N1} := Type.arrayDims(inType1);
          {N2,K} := Type.arrayDims(inType2);
          if (not isValidMatrixMultiplyDims(N1,N2)) then
            binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,
            "\n: Dimensions error in Matrix Matrix multiplication.");
            fail();
          else
            ty1 := Type.elementType(inType1);
            ty2 := Type.elementType(inType2);
            // TODO: the exps are arrays but the types are now simple.
            (exp1,exp2,ty, true) := matchExpressions(inExp1,ty1,inExp2,ty2);
            outType := Type.liftArrayLeftList(ty, {M,K});
            outExp := Expression.BINARY(exp1, Operator.MUL_MATRIX_PRODUCT(outType), exp2);
          end if;

        else
          binaryArrayOpError(inExp1,inType1,inExp2,inType2,inOp,"");
          fail();
        end if;

      then
        (outExp, outType);

    case _ guard Operator.isBinaryElementWise(inOp)
      algorithm
        (exp1,exp2,outType, true) := matchExpressions(inExp1,inType1,inExp2,inType2);
        newop := Operator.setType(outType, inOp);
        outExp := Expression.BINARY(exp1, newop, exp2);
      then
        (outExp, outType);

    else
      algorithm
        assert(false, getInstanceName() + ": got a binary operation that is not
            handled yet");
      then
        fail();
  end match;

end checkBinaryOperationArrays;


// ************************************************************** //
//   END: Operator typing helper functions
// ************************************************************** //





//// ************************************************************** //
////   BEGIN: TypeCall helper functions
//// ************************************************************** //
//
//
//public function matchCallArgs
//"@mahge:
//  matches given call args with the expected or formal arguments for a function.
//  if vectorization dimension (inVectDims) is given (is not empty) then the function
//  works with vectorization mode.
//  otherwise no vectorization will be done.
//
//  However if matching fails in no vect. mode due to dim mismatch then
//  a vect dim will be returned from  NFTypeCheck.matchCallArgs and this
//  function will start all over again with the new vect dimension."
//
//  input list<Expression> inArgs;
//  input list<Type> inArgTypes;
//  input list<Type> inExpectedTypes;
//  input DAE.Dimensions inVectDims;
//  output list<Expression> outFixedArgs;
//  output DAE.Dimensions outVectDims;
//algorithm
//  (outFixedArgs, outVectDims):=
//  matchcontinue (inArgs,inArgTypes,inExpectedTypes, inVectDims)
//    local
//      Expression e,e_1;
//      list<Expression> restargs, fixedArgs;
//      Type t1,t2;
//      list<Type> restinty,restexpcty;
//      DAE.Dimensions dims1, dims2;
//      String e1Str, t1Str, t2Str, s1;
//
//    case ({},{},{},_) then ({}, inVectDims);
//
//    // No vectorization mode.
//    // If things continue to match with no vect.
//    // Then all is good.
//    case (e::restargs, (t1 :: restinty), (t2 :: restexpcty), {})
//      equation
//        (e_1, {}) = matchCallArg(e,t1,t2,{});
//
//        (fixedArgs, {}) = matchCallArgs(restargs, restinty, restexpcty, {});
//      then
//        (e_1::fixedArgs, {});
//
//    // No vectorization mode.
//    // If argument failed to match not because of dim mismatch
//    // but due to actuall type mismatch then it is an invalid call and we fail here.
//    case (e::_, (t1 :: _), (t2 :: _), {})
//      equation
//        failure((_,_) = matchCallArg(e,t1,t2,{}));
//
//        e1Str = ExpressionDump.printExpStr(e);
//        t1Str = Types.unparseType(t1);
//        t2Str = Types.unparseType(t2);
//        s1 = "Failed to match or convert '" + e1Str + "' of type '" + t1Str +
//             "' to type '" + t2Str + "'";
//        Error.addSourceMessage(Error.INTERNAL_ERROR, {s1}, Absyn.dummyInfo);
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.matchCallArgs failed with type mismatch: " + t1Str + " tys: " + t2Str);
//      then
//        fail();
//
//    // No -> Yes vectorization mode.
//    // If argument fails to match due to dim mistmatch. then we
//    // have our vect. dim and we start from the begining.
//    case (e::_, (t1 :: _), (t2 :: _), {})
//      equation
//        (_, dims1) = matchCallArg(e,t1,t2,{});
//
//        // This is just to be realllly sure. The cases above actually make sure of it.
//        false = Expression.dimsEqual(dims1, {});
//
//        // Start from the first arg. This time with Vectorization.
//        (fixedArgs, dims2) = matchCallArgs(inArgs,inArgTypes,inExpectedTypes, dims1);
//      then
//        (fixedArgs, dims2);
//
//    // Vectorization mode.
//    case (e::restargs, (t1 :: restinty), (t2 :: restexpcty), dims1)
//      equation
//        false = Expression.dimsEqual(dims1, {});
//        (e_1, dims1) = matchCallArg(e,t1,t2,dims1);
//        (fixedArgs, dims1) = matchCallArgs(restargs, restinty, restexpcty, dims1);
//      then
//        (e_1::fixedArgs, dims1);
//
//
//
//    case (_::_,(_ :: _),(_ :: _), _)
//      equation
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.trace("- NFTypeCheck.matchCallArgs failed\n");
//      then
//        fail();
//  end matchcontinue;
//end matchCallArgs;
//
//
//public function matchCallArg
//"@mahge:
//  matches a given call arg with the expected or formal argument for a function.
//  if vectorization dimension (inVectDims) is given (is not empty) then the function
//  works with vectorization mode.
//  otherwise no vectorization will be done.
//
//  However if matching fails in no vect. mode due to dim mismatch then
//  it will try to see if vectoriztion is possible. If so the vectorization dim is
//  returned to NFTypeCheck.matchCallArg so that it can start matching from the begining
//  with the new vect dim."
//
//  input Expression inArg;
//  input Type inArgType;
//  input Type inExpectedType;
//  input DAE.Dimensions inVectDims;
//  output Expression outArg;
//  output DAE.Dimensions outVectDims;
//algorithm
//  (outArg, outVectDims) := matchcontinue (inArg,inArgType,inExpectedType,inVectDims)
//    local
//      Expression e,e_1;
//      Type e_type,expected_type;
//      String e1Str, t1Str, t2Str, s1;
//      DAE.Dimensions dims1, dims2, foreachdim;
//
//
//    // No vectorization mode.
//    // Types match (i.e. dims match exactly). Then all is good
//    case (e,e_type,expected_type, {})
//      equation
//        // Of course matchtype will make sure of this
//        // but this is faster.
//        dims1 = Types.getDimensions(e_type);
//        dims2 = Types.getDimensions(expected_type);
//        true = Expression.dimsEqual(dims1, dims2);
//
//        (e_1,_) = Types.matchType(e, e_type, expected_type, true);
//      then
//        (e_1, {});
//
//
//    // No vectorization mode.
//    // If it failed NOT because of dim mismatch but because
//    // of actuall type mismatch then fail here.
//    case (_,e_type,expected_type, {})
//      equation
//        dims1 = Types.getDimensions(e_type);
//        dims2 = Types.getDimensions(expected_type);
//        true = Expression.dimsEqual(dims1, dims2);
//      then
//        fail();
//
//    // No Vect. -> Vectorization mode.
//    // We found a dim mistmatch. Try vectorizing. If vectorizing
//    // matches, then this is our vectoriztion dimension.
//    // N.B. We still have to start matching again from the first arg
//    // with the new vectorization dimension.
//    case (e,e_type,expected_type, {})
//      equation
//        dims1 = Types.getDimensions(e_type);
//        dims2 = Types.getDimensions(expected_type);
//
//        false = Expression.dimsEqual(dims1, dims2);
//
//        foreachdim = findVectorizationDim(dims1,dims2);
//
//      then
//        (e, foreachdim);
//
//
//    // IN Vectorization mode!!!.
//    case (e,e_type,expected_type, foreachdim)
//      equation
//        e_1 = checkVectorization(e,e_type,expected_type,foreachdim);
//      then
//        (e_1, foreachdim);
//
//
//    case (e,e_type,expected_type, _)
//      equation
//        e1Str = ExpressionDump.printExpStr(e);
//        t1Str = Types.unparseType(e_type);
//        t2Str = Types.unparseType(expected_type);
//        s1 = "Failed to match or convert '" + e1Str + "' of type '" + t1Str +
//             "' to type '" + t2Str + "'";
//        Error.addSourceMessage(Error.INTERNAL_ERROR, {s1}, Absyn.dummyInfo);
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.matchCallArg failed with type mismatch: " + t1Str + " tys: " + t2Str);
//      then
//        fail();
//  end matchcontinue;
//end matchCallArg;
//
//
//protected function checkVectorization
//"@mahge:
//  checks if it is possible to vectorize a given argument to the
//  expected or formal argument with the given vectorization dim.
//  e.g. inForeachDim=[3,2]
//       function F(input Integer[2]);
//
//       Integer a[2,3,2], b[2,2,2],s;
//
//       a is vectorizable with [3,2] => a[1]), a[2]
//       b is not vectorizable with [3,2]
//       s is vectorizable with [3,2] => {{s,s},{s,s},{s,s}}
//
//  N.B. The vectoriztion dim came from the first arg mismatch in
//  NFTypeCheck.matchCallArg and all susequent args shoudl be vectorizable
//  with that dim. This function checks that.
//  "
//  input Expression inArg;
//  input Type inArgType;
//  input Type inExpectedType;
//  input DAE.Dimensions inForeachDim;
//  output Expression outArg;
//algorithm
//  outArg := matchcontinue (inArg,inArgType,inExpectedType,inForeachDim)
//    local
//      Expression outExp;
//      DAE.Dimensions expectedDims, argDims;
//      String e1Str, t1Str, t2Str, s1;
//      Type expcType;
//
//    // if types match (which also means dims match exactly).
//    // Then we have to change the given argument to an array of
//    // the vect. dim to have a 'foreach' argument
//    case(_,_,_,_)
//      equation
//        // Of course matchtype will make sure of this
//        // but this is faster.
//        argDims = Types.getDimensions(inArgType);
//        expectedDims = Types.getDimensions(inExpectedType);
//        true = Expression.dimsEqual(argDims, expectedDims);
//
//        (outExp,_) = Types.matchType(inArg, inArgType, inExpectedType, false);
//
//        // create the array from the given arg to match the vectorization
//        outExp = Expression.arrayFill(inForeachDim,outExp);
//      then
//        outExp;
//
//    // if dims don't match exactly. Then the given argument
//    // must have the same dimension as our vecorization or 'foreach' dimension.
//    // And the expected type will be lifeted to the 'foreach' dim and then
//    // matched with the given argument
//    case(_,_,_,_)
//      equation
//
//        argDims = Types.getDimensions(inArgType);
//
//        // lift the expected type by 'foreach' dims
//        expcType = Types.liftArrayListDims(inExpectedType,inForeachDim);
//
//        // Now the given type and the expected type must have the
//        // same dimesions. Otherwise vectorization is not possible.
//        expectedDims = Types.getDimensions(expcType);
//        true = Expression.dimsEqual(argDims, expectedDims);
//
//        (outExp,_) = Types.matchType(inArg, inArgType, expcType, false);
//      then
//        outExp;
//
//    else
//      equation
//        argDims = Types.getDimensions(inArgType);
//        expectedDims = Types.getDimensions(inExpectedType);
//
//        expectedDims = listAppend(inForeachDim,expectedDims);
//
//        e1Str = ExpressionDump.printExpStr(inArg);
//        t1Str = Types.unparseType(inArgType);
//        t2Str = Types.unparseType(inExpectedType);
//        s1 = "Vectorization can not continue matching '" + e1Str + "' of type '" + t1Str +
//             "' to type '" + t2Str + "'. Expected dimensions [" +
//             ExpressionDump.printListStr(expectedDims,ExpressionDump.dimensionString,",") + "], found [" +
//             ExpressionDump.printListStr(argDims,ExpressionDump.dimensionString,",") + "]";
//
//        Error.addSourceMessage(Error.INTERNAL_ERROR, {s1}, Absyn.dummyInfo);
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.checkVectorization failed ");
//      then
//        fail();
//
//   end matchcontinue;
//
//end checkVectorization;
//
//
//public function findVectorizationDim
//"@mahge:
// This function basically finds the diff between two dims. The resulting dimension
// is used for vectorizing calls.
//
// e.g. dim1=[2,3,4,2]  dim2=[4,2], findVectorizationDim(dim1,dim2) => [2,3]
//      dim1=[2,3,4,2]  dim2=[3,4,2], findVectorizationDim(dim1,dim2) => [2]
//      dim1=[2,3,4,2]  dim2=[4,3], fail
// "
//  input DAE.Dimensions inGivenDims;
//  input DAE.Dimensions inExpectedDims;
//  output DAE.Dimensions outVectDims;
//algorithm
//  outVectDims := matchcontinue(inGivenDims, inExpectedDims)
//    local
//      DAE.Dimensions dims1;
//      DAE.Dimension dim1;
//
//    case(_, {}) then inGivenDims;
//
//    case(_, _)
//      equation
//        true = Expression.dimsEqual(inGivenDims, inExpectedDims);
//      then
//        {};
//
//    case(dim1::dims1, _)
//      equation
//        true = listLength(inGivenDims) > listLength(inExpectedDims);
//        dims1 = findVectorizationDim(dims1,inExpectedDims);
//      then
//        dim1::dims1;
//
//    case(_::_, _)
//      equation
//        true = Flags.isSet(Flags.FAILTRACE);
//        Debug.traceln("- NFTypeCheck.findVectorizationDim failed with dimensions: [" +
//         ExpressionDump.printListStr(inGivenDims,ExpressionDump.dimensionString,",") + "] vs [" +
//         ExpressionDump.printListStr(inExpectedDims,ExpressionDump.dimensionString,",") + "].");
//      then
//        fail();
//
//  end matchcontinue;
//
//end findVectorizationDim;
//
//
//public function makeCallReturnType
//"@mahge:
//   makes the return type for function.
//   i.e if a list of types is given then it is a tuple ret function.
// "
//  input list<Type> inTypeLst;
//  output Type outType;
//  output Boolean outBoolean;
//algorithm
//  (outType,outBoolean) := match (inTypeLst)
//    local
//      Type ty;
//
//    case {} then (DAE.T_NORETCALL(DAE.emptyTypeSource), false);
//
//    case {ty} then (ty, false);
//
//    else  (DAE.T_TUPLE(inTypeLst,NONE(),DAE.emptyTypeSource), true);
//
//  end match;
//end makeCallReturnType;
//
//
//
//public function vectorizeCall
//"@mahge:
//   Vectorizes calls. Most of the work is done
//   vectorizeCall2.
//   This function get a list of functions with each arg
//   subscripted from vectorizeCall2. e.g. {F(a[1,1]),F(a[1,2]),F(a[2,1]),F(a[2,2])}
//   The it converts the list to an array of 'inForEachdim' dims using
//   Expression.listToArray. i.e.
//   {F(a[1,1]),F(a[1,2]),F(a[2,1]),F(a[2,2])} with vec. dim [2,2] will be
//   {{F(a[1,1]),F(a[1,2])}, {F(a[2,1])F(a[2,2])}}
//
// "
//  input Absyn.Path inFnName;
//  input list<Expression> inArgs;
//  input DAE.CallAttributes inAttrs;
//  input Type inRetType;
//  input DAE.Dimensions inForEachdim;
//  output Expression outExp;
//  output Type outType;
//algorithm
//  (outExp,outType) := matchcontinue (inFnName,inArgs,inAttrs,inRetType,inForEachdim)
//    local
//      list<Expression> callLst;
//      Expression callArr;
//      Type outtype;
//
//
//    // If no 'forEachdim' then no vectorization
//    case(_, _, _, _, {}) then (DAE.CALL(inFnName, inArgs, inAttrs), inRetType);
//
//
//    case(_, _::_, _, _, _)
//      equation
//        // Get the call list with args subscripted for each value in 'foreaach' dim.
//        callLst = vectorizeCall2(inFnName, inArgs, inAttrs, inForEachdim, {});
//
//        // Create the array of calls from the list
//        callArr = Expression.listToArray(callLst,inForEachdim);
//
//        // lift the retType to 'forEachDim' dims
//        outtype = Types.liftArrayListDims(inRetType, inForEachdim);
//      then
//        (callArr, outtype);
//
//    else
//      equation
//        Error.addMessage(Error.INTERNAL_ERROR, {"NFTypeCheck.vectorizeCall failed."});
//      then
//        fail();
//
//  end matchcontinue;
//end vectorizeCall;
//
//
//public function vectorizeCall2
//"@mahge:
//   Vectorizes calls. This function takes a list of args for a function
//   and a vectorization dim. then it subscripts the args for each idex
//   of the vec. dim and creates a function call for each subscripted
//   arg list. Then retuns the list of functions.
//   e.g.
//   for argLst ( a, {{b,b,b},{c,c,c}} ) and functionname F with vect. dim of [2,3]
//   this function creates the list
//
//   {F(a[1,1],b), F(a[1,2],b), F(a[1,3],b), F(a[2,1],c), F(a[2,2],c), F(a[2,3],c)}
// "
//  input Absyn.Path inFnName;
//  input list<Expression> inArgs;
//  input DAE.CallAttributes inAttrs;
//  input DAE.Dimensions inDims;
//  input list<Expression> inAccumCalls;
//  output list<Expression> outAccumCalls;
//algorithm
//  outAccumCalls := matchcontinue(inFnName, inArgs, inAttrs, inDims, inAccumCalls)
//    local
//      DAE.Dimension dim;
//      DAE.Dimensions dims;
//      Expression idx;
//      list<Expression> calls, subedargs;
//
//    case (_, _, _, {}, _) then DAE.CALL(inFnName, inArgs, inAttrs) :: inAccumCalls;
//
//    case (_, _, _, dim :: dims, _)
//      equation
//        (idx, dim) = getNextIndex(dim);
//
//        subedargs = List.map1(inArgs, Expression.subscriptExp, {DAE.INDEX(idx)});
//
//        calls = vectorizeCall2(inFnName, subedargs, inAttrs, dims, inAccumCalls);
//        calls = vectorizeCall2(inFnName, inArgs, inAttrs, dim :: dims, calls);
//      then
//        calls;
//
//    else inAccumCalls;
//
//  end matchcontinue;
//end vectorizeCall2;
//
//protected function getNextIndex
//  "Returns the next index given a dimension, and updates the dimension. Fails
//  when there are no indices left."
//  input DAE.Dimension inDim;
//  output Expression outNextIndex;
//  output DAE.Dimension outDim;
//algorithm
//  (outNextIndex, outDim) := match(inDim)
//    local
//      Integer new_idx, dim_size;
//      Absyn.Path p, ep;
//      String l;
//      list<String> l_rest;
//
//    case DAE.DIM_INTEGER(integer = 0) then fail();
//    case DAE.DIM_ENUM(size = 0) then fail();
//
//    case DAE.DIM_INTEGER(integer = new_idx)
//      equation
//        dim_size = new_idx - 1;
//      then
//        (DAE.ICONST(new_idx), DAE.DIM_INTEGER(dim_size));
//
//    // Assumes that the enum has been reversed with reverseEnumType.
//    case DAE.DIM_ENUM(p, l :: l_rest, new_idx)
//      equation
//        ep = Absyn.joinPaths(p, Absyn.IDENT(l));
//        dim_size = new_idx - 1;
//      then
//        (DAE.ENUM_LITERAL(ep, new_idx), DAE.DIM_ENUM(p, l_rest, dim_size));
//  end match;
//end getNextIndex;


// ************************************************************** //
//   END: TypeCall helper functions
// ************************************************************** //

protected
function matchExpressions
  input output Expression exp1;
  input Type type1;
  input output Expression exp2;
  input Type type2;
  input Boolean allowUnknown = false;
        output Type compatibleType;
        output Boolean compatible;
algorithm
  (exp1, compatibleType, compatible) :=
    matchTypes(type1, type2, exp1, allowUnknown);

  if not compatible then
    (exp2, compatibleType, compatible) :=
      matchTypes_cast(type2, type1, exp2, allowUnknown);
  end if;
end matchExpressions;

function matchTypes
  input Type actualType;
  input Type expectedType;
  input output Expression expression;
  input Boolean allowUnknown = false;
        output Type compatibleType;
        output Boolean compatible = true;
algorithm
  // Return true if the references are the same.
  if referenceEq(actualType, expectedType) then
    compatibleType := actualType;
    return;
  end if;

  // Check if the types are different kinds of types.
  if valueConstructor(actualType) <> valueConstructor(expectedType) then
    // If the types are not of the same kind we might need to type cast the
    // expression to make it compatible.
    (expression, compatibleType, compatible) :=
      match (actualType, expectedType)
        case (Type.FUNCTION(), Type.FUNCTION())
          then matchTypes(actualType.resultType, expectedType.resultType, expression, allowUnknown);
        case (Type.FUNCTION(), _)
          then matchTypes(actualType.resultType, expectedType, expression, allowUnknown);
        case (_, Type.FUNCTION())
          then matchTypes(actualType, expectedType.resultType, expression, allowUnknown);
        else matchTypes_cast(actualType, expectedType, expression, allowUnknown);
      end match;
    return;
  end if;

  // The types are of the same kind, so we only need to match on one of them.
  compatibleType := match (actualType)
    local
      list<Dimension> dims1, dims2;
      Type ety1, ety2;

    case Type.INTEGER() then actualType;
    case Type.REAL() then actualType;
    case Type.STRING() then actualType;
    case Type.BOOLEAN() then actualType;
    case Type.CLOCK() then actualType;

    case Type.ENUMERATION()
      algorithm
      then
        actualType;

    case Type.ARRAY()
      algorithm
        // Check that the element types are compatible.
        ety1 := actualType.elementType;
        ety2 := Type.arrayElementType(expectedType);

        (expression, compatibleType, compatible) :=
          matchTypes(ety1, ety2, expression, allowUnknown);

        // If the element types are compatible, check the dimensions too.
        if compatible then
          dims1 := actualType.dimensions;
          dims2 := Type.arrayDims(expectedType);

          // The arrays must have the same number of dimensions.
          if listLength(dims1) == listLength(dims2) then
            dims1 := list(if Dimension.isEqualKnown(dim1, dim2) then
              dim1 else Dimension.UNKNOWN() threaded for dim1 in dims1, dim2 in dims2);
            compatibleType := Type.liftArrayLeftList(compatibleType, dims1);
          else
            compatible := false;
          end if;
        end if;
      then
        compatibleType;

    case Type.FUNCTION()
      algorithm
        (expression, compatibleType, compatible) :=
          matchTypes_cast(actualType.resultType, expectedType, expression, allowUnknown);
      then
        compatibleType;

    else
      algorithm
        assert(false, getInstanceName() + " got unknown type.");
      then
        fail();

  end match;
end matchTypes;


//function checkTypeCompat
//  "This function checks that two types are compatible, as per the definition of
//   type compatible expressions in the specification. If needed it also does type
//   casting to make the expressions compatible. If the types are compatible it
//   returns the compatible type, otherwise the type returned is undefined."
//  input output Expression exp1;
//  input Type type1;
//  input output Expression exp2;
//  input Type type2;
//  input Boolean allowUnknown = false;
//        output Type compatType;
//        output Boolean compatible = true;
//protected
//  Type ty1, ty2;
//algorithm
//  // Return true if the references are the same.
//  if referenceEq(type1, type2) then
//    compatType := type1;
//    return;
//  end if;
//
//  // Check if the types are different kinds of types.
//  if valueConstructor(type1) <> valueConstructor(type2) then
//    if Types.extendsBasicType(type1) or Types.extendsBasicType(type2) then
//      // If either type extends a basic type, check the basic type instead.
//      ty1 := Types.derivedBasicType(type1);
//      ty2 := Types.derivedBasicType(type2);
//      (exp1, exp2, compatType, compatible) :=
//        checkTypeCompat(exp1, ty1, exp2, ty2);
//    else
//      // If the types are not of the same kind they might need to be type cast
//      // to become compatible.
//      (exp1, exp2, compatType, compatible) :=
//        checkTypeCompat_cast(exp1, type1, exp2, type2, allowUnknown);
//    end if;
//
//    // Regardless of the chosen branch above, we are done here.
//    return;
//  end if;
//
//  // The types are of the same kind, so we only need to match on one of them
//  // (which is a lot more efficient than matching both).
//  compatType := match(type1)
//    local
//      list<DAE.Dimension> dims1, dims2;
//      Type ety1, ety2, ty;
//      list<String> names;
//      list<DAE.Var> vars;
//      list<DAE.FuncArg> args;
//      list<Type> tys, tys2;
//      String name;
//      Absyn.Path p1, p2;
//
//    // Basic types, must be the same.
//    case DAE.T_INTEGER() then DAE.T_INTEGER_DEFAULT;
//    case DAE.T_REAL() then DAE.T_REAL_DEFAULT;
//    case DAE.T_STRING() then DAE.T_STRING_DEFAULT;
//    case DAE.T_BOOL() then DAE.T_BOOL_DEFAULT;
//    case DAE.T_CLOCK() then DAE.T_CLOCK_DEFAULT;
//
//    case DAE.T_SUBTYPE_BASIC()
//      algorithm
//        DAE.T_SUBTYPE_BASIC(complexType = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.complexType, exp2, ty);
//      then
//        compatType;
//
//    // Enumerations, check that they have same literals.
//    case DAE.T_ENUMERATION()
//      algorithm
//        DAE.T_ENUMERATION(names = names) := type2;
//        compatible := List.isEqualOnTrue(type1.names, names, stringEq);
//      then
//        type1;
//
//    // Arrays, must have compatible element types and dimensions.
//    case DAE.T_ARRAY()
//      algorithm
//        // Check that the element types are compatible.
//        ety1 := Types.arrayElementType(type1);
//        ety2 := Types.arrayElementType(type2);
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, ety1, exp2, ety2);
//
//        // If the element types are compatible, check the dimensions too.
//        if compatible then
//          dims1 := Types.getDimensions(type1);
//          dims2 := Types.getDimensions(type2);
//
//          // The arrays must have the same number of dimensions.
//          if listLength(dims1) == listLength(dims2) then
//            dims1 := list(if DAEExpression.dimensionsKnownAndEqual(dim1, dim2) then
//              dim1 else DAE.DIM_UNKNOWN() threaded for dim1 in dims1, dim2 in dims2);
//            compatType := Types.liftArrayListDims(compatType, dims1);
//          else
//            compatible := false;
//          end if;
//        end if;
//      then
//        compatType;
//
//    // Records, must have the same components.
//    case DAE.T_COMPLEX(complexClassType = ClassInf.RECORD())
//      algorithm
//        DAE.T_COMPLEX(varLst = vars) := type2;
//        // TODO: Implement type casting for records with the same components but
//        // in different order.
//        compatible := List.isEqualOnTrue(type1.varLst, vars, Types.varEqualName);
//      then
//        type1;
//
//    case DAE.T_FUNCTION()
//      algorithm
//        DAE.T_FUNCTION(funcResultType = ty, funcArg = args) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.funcResultType, exp2, ty);
//
//        if compatible then
//          tys := list(Types.funcArgType(arg) for arg in type1.funcArg);
//          tys2 := list(Types.funcArgType(arg) for arg in args);
//          (_, compatible) := checkTypeCompatList(exp1, tys, exp2, tys2);
//        end if;
//      then
//        type1;
//
//    case DAE.T_TUPLE()
//      algorithm
//        DAE.T_TUPLE(types = tys) := type2;
//        (tys, compatible) :=
//          checkTypeCompatList(exp1, type1.types, exp2, tys);
//      then
//        DAE.T_TUPLE(tys, type1.names, type1.source);
//
//    // MetaModelica types.
//    case DAE.T_METALIST()
//      algorithm
//        DAE.T_METALIST(ty = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.ty, exp2, ty, true);
//      then
//        DAE.T_METALIST(compatType, type1.source);
//
//    case DAE.T_METAARRAY()
//      algorithm
//        DAE.T_METAARRAY(ty = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.ty, exp2, ty, true);
//      then
//        DAE.T_METAARRAY(compatType, type1.source);
//
//    case DAE.T_METAOPTION()
//      algorithm
//        DAE.T_METAOPTION(ty = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.ty, exp2, ty, true);
//      then
//        DAE.T_METAOPTION(compatType, type1.source);
//
//    case DAE.T_METATUPLE()
//      algorithm
//        DAE.T_METATUPLE(types = tys) := type2;
//        (tys, compatible) :=
//          checkTypeCompatList(exp1, type1.types, exp2, tys);
//      then
//        DAE.T_METATUPLE(tys, type1.source);
//
//    case DAE.T_METABOXED()
//      algorithm
//        DAE.T_METABOXED(ty = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.ty, exp2, ty);
//      then
//        DAE.T_METABOXED(compatType, type1.source);
//
//    case DAE.T_METAPOLYMORPHIC()
//      algorithm
//        DAE.T_METAPOLYMORPHIC(name = name) := type2;
//        compatible := type1.name == name;
//      then
//        type1;
//
//    case DAE.T_METAUNIONTYPE(source = {p1})
//      algorithm
//        DAE.T_METAUNIONTYPE(source = {p2}) := type2;
//        compatible := Absyn.pathEqual(p1, p2);
//      then
//        type1;
//
//    case DAE.T_METARECORD(utPath = p1)
//      algorithm
//        DAE.T_METARECORD(utPath = p2) := type2;
//        compatible := Absyn.pathEqual(p1, p2);
//      then
//        type1;
//
//    case DAE.T_FUNCTION_REFERENCE_VAR()
//      algorithm
//        DAE.T_FUNCTION_REFERENCE_VAR(functionType = ty) := type2;
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, type1.functionType, exp2, ty);
//      then
//        DAE.T_FUNCTION_REFERENCE_VAR(compatType, type1.source);
//
//    else
//      algorithm
//        compatible := false;
//      then
//        DAE.T_UNKNOWN_DEFAULT;
//
//  end match;
//end checkTypeCompat;
//
//function checkTypeCompatList
//  "Checks that two lists of types are compatible using checkTypeCompat."
//  input Expression exp1;
//  input list<Type> types1;
//  input Expression exp2;
//  input list<Type> types2;
//  output list<Type> compatibleTypes = {};
//  output Boolean compatible = true;
//protected
//  Type ty2;
//  list<Type> rest_ty2 = types2;
//  Boolean compat;
//algorithm
//  if listLength(types1) <> listLength(types2) then
//    compatible := false;
//    return;
//  end if;
//
//  for ty1 in types1 loop
//    ty2 :: rest_ty2 := rest_ty2;
//    // Ignore the returned expressions. This function is used for tuples, and
//    // it's not clear how tuples should be type converted. So we only check that
//    // the types are compatible and hope for the best.
//    (_, _, ty2, compat) := checkTypeCompat(exp1, ty1, exp2, ty2);
//
//    if not compat then
//      compatible := false;
//      return;
//    end if;
//
//    compatibleTypes := ty2 :: compatibleTypes;
//  end for;
//
//  compatibleTypes := listReverse(compatibleTypes);
//end checkTypeCompatList;

function matchTypes_cast
  input Type actualType;
  input Type expectedType;
  input output Expression expression;
  input Boolean allowUnknown;
        output Type compatibleType;
        output Boolean compatible = true;
algorithm
  compatibleType := match(actualType, expectedType)
    case (Type.INTEGER(), Type.REAL())
      algorithm
        expression := Expression.typeCastElements(expression, expectedType);
      then
        expectedType;

    // Allow unknown types in some cases, e.g. () has type METALIST(UNKNOWN)
    case (Type.UNKNOWN(), _)
      algorithm
        compatible := allowUnknown;
      then
        expectedType;

    case (_, Type.UNKNOWN())
      algorithm
        compatible := allowUnknown;
      then
        actualType;

    // Anything else is not compatible.
    else
      algorithm
        compatible := false;
      then
        Type.UNKNOWN();

  end match;
end matchTypes_cast;

//function checkTypeCompat_cast
//  "Helper function to checkTypeCompat. Tries to type cast one of the given
//   expressions so that they become type compatible."
//  input output Expression exp1;
//  input Type type1;
//  input output Expression exp2;
//  input Type type2;
//  input Boolean allowUnknown;
//  output Type compatType;
//  output Boolean compatible = true;
//protected
//  Type ty1, ty2;
//  Absyn.Path path;
//algorithm
//  ty1 := Types.derivedBasicType(type1);
//  ty2 := Types.derivedBasicType(type2);
//
//  compatType := match(ty1, ty2)
//    // Real <-> Integer
//    case (DAE.T_REAL(), DAE.T_INTEGER())
//      algorithm
//        exp2 := Expression.typeCastElements(exp2, DAE.T_REAL_DEFAULT);
//      then
//        DAE.T_REAL_DEFAULT;
//
//    case (DAE.T_INTEGER(), DAE.T_REAL())
//      algorithm
//        exp1 := Expression.typeCastElements(exp1, DAE.T_REAL_DEFAULT);
//      then
//        DAE.T_REAL_DEFAULT;
//
//    // If one of the expressions is boxed, unbox it.
//    case (DAE.T_METABOXED(), _)
//      algorithm
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, ty1.ty, exp2, ty2, allowUnknown);
//        exp1 := if Types.isBoxedType(ty2) then exp1 else Expression.UNBOX(exp1, compatType);
//      then
//        ty2;
//
//    case (_, DAE.T_METABOXED())
//      algorithm
//        (exp1, exp2, compatType, compatible) :=
//          checkTypeCompat(exp1, ty1, exp2, ty2.ty, allowUnknown);
//        exp2 := if Types.isBoxedType(ty1) then exp2 else Expression.UNBOX(exp2, compatType);
//      then
//        ty1;
//
//    // Expressions such as Absyn.IDENT gets the type T_METARECORD(Absyn.Path.IDENT)
//    // instead of UNIONTYPE(Absyn.Path), but e.g. a function returning an
//    // Absyn.PATH has the type UNIONTYPE(Absyn.PATH). So we'll just pretend that
//    // metarecords actually have uniontype type.
//    case (DAE.T_METARECORD(), DAE.T_METAUNIONTYPE(source = {path}))
//      algorithm
//        compatible := Absyn.pathEqual(ty1.utPath, path);
//      then
//        ty2;
//
//    case (DAE.T_METAUNIONTYPE(source = {path}), DAE.T_METARECORD())
//      algorithm
//        compatible := Absyn.pathEqual(path, ty2.utPath);
//      then
//        ty1;
//
//    // Allow unknown types in some cases, e.g. () has type T_METALIST(T_UNKNOWN)
//    case (DAE.T_UNKNOWN(), _)
//      algorithm
//        compatible := allowUnknown;
//      then
//        ty2;
//
//    case (_, DAE.T_UNKNOWN())
//      algorithm
//        compatible := allowUnknown;
//      then
//        ty1;
//
//    // Anything else is not compatible.
//    else
//      algorithm
//        compatible := false;
//      then
//        DAE.T_UNKNOWN_DEFAULT;
//
//  end match;
//end checkTypeCompat_cast;

//public function getTypeDims
//"This will NOT fail if type is not array type."
//  input Type inType;
//  output DAE.Dimensions outDims;
//algorithm
//  outDims := match (inType)
//    case DAE.T_ARRAY() then inType.dims;
//    case DAE.T_FUNCTION() then getTypeDims(inType.funcResultType);
//    else {};
//  end match;
//end getTypeDims;

//function applySubsToDims
//  input list<DAE.Dimension> inDims;
//  input list<DAE.Subscript> inSubs;
//  output list<DAE.Dimension> outDims = {};
//protected
//  DAE.Dimension dim;
//  list<DAE.Dimension> dims1, dims2, slicedims;
//  Type baseTy, ixty;
//algorithm
//  dims1 := inDims;
//  dims2 := {};
//
//  for sub in inSubs loop
//    _ := match sub
//      case DAE.INDEX()
//        algorithm
//          ixty := Expression.typeof(sub.exp);
//          slicedims := getTypeDims(ixty);
//          if listLength(slicedims) > 0 then
//            assert(listLength(slicedims) == 1,
//              getInstanceName() + " failed. Got a slice with more than one dim?");
//            _::dims1 := dims1;
//            {dim} := slicedims;
//            outDims := dim::outDims;
//          end if;
//        then
//          ();
//
//      case DAE.WHOLEDIM()
//        algorithm
//          dim::dims1 := dims1;
//          outDims := dim::outDims;
//        then
//          ();
//    end match;
//  end for;
//end applySubsToDims;

function checkValidNumericTypesForOp
"  TODO: update me.
  @mahge:
  Helper function for Check*Operator functions.
  Checks if both operands are Numeric types for all operators except Addition.
  Which can also work on Strings and maybe Booleans??.
  Written separatly because it needs to print an error."
  input Type type1;
  input Type type2;
  input Operator operator;
  input Boolean printError;
  output Boolean isValid;
algorithm
  isValid := match operator
    local
      String ty1_str, ty2_str, op_str;

    case Operator.ADD() then true;

    case _ guard Type.isNumeric(type1) and Type.isNumeric(type2) then true;

    else
      algorithm
        if printError then
          ty1_str := Type.toString(type1);
          ty2_str := Type.toString(type2);
          op_str := Operator.symbol(operator);
          Error.addSourceMessage(Error.FOUND_NON_NUMERIC_TYPES,
            {op_str, ty1_str, ty2_str}, Absyn.dummyInfo);
        end if;
      then
        false;
  end match;
end checkValidNumericTypesForOp;

function isValidMatrixMultiplyDims
" TODO: update me.
  @mahge:
  Checks if two dimensions are equal, which is a prerequisite for Matrix/Vector
  multiplication."
  input Dimension dim1;
  input Dimension dim2;
  output Boolean res;
protected
  String msg;
algorithm
  if Dimension.isEqualKnown(dim1, dim2) then
    // The dimensions are both known and equal.
    res := true;
  elseif Flags.getConfigBool(Flags.CHECK_MODEL) and Dimension.isEqual(dim1, dim2) then
    // If checkModel is used we might get unknown dimensions. So use
    // isEqual instead, which matches anything against Dimension.UNKNOWN.
    res := true;
  else
    msg := "Dimension mismatch in Vector/Matrix multiplication operation: " +
      Dimension.toString(dim1) + "x" + Dimension.toString(dim2);
    Error.addSourceMessage(Error.COMPILER_ERROR, {msg}, Absyn.dummyInfo);
    res := false;
  end if;
end isValidMatrixMultiplyDims;

function binaryArrayOpError
  input Expression inExp1;
  input Type inType1;
  input Expression inExp2;
  input Type inType2;
  input Operator inOp;
  input String suggestion;
protected
  String e1Str, t1Str, e2Str, t2Str, s1, s2, sugg;
algorithm
  e1Str := Expression.toString(inExp1);
  t1Str := Type.toString(inType1);
  e2Str := Expression.toString(inExp2);
  t2Str := Type.toString(inType2);
  s1 := "' " + e1Str + Operator.symbol(inOp) + e2Str + " '";
  s2 := "' " + t1Str + Operator.symbol(inOp) + t2Str + " '";
  Error.addSourceMessage(Error.UNRESOLVABLE_TYPE, {s1,s2,suggestion}, Absyn.dummyInfo);
end binaryArrayOpError;

//public function getCrefType
//  input DAE.ComponentRef inCref;
//  output Type outType;
//protected
//  Type baseTy;
//  list<DAE.Dimension> dims, accdims;
//algorithm
//  (accdims,baseTy) := getCrefType2(inCref);
//  if listLength(accdims) > 0 then
//    outType := DAE.T_ARRAY(baseTy, accdims, DAE.emptyTypeSource);
//  else
//    outType := baseTy;
//  end if;
//end getCrefType;
//
//function getCrefType2
//  input DAE.ComponentRef inCref;
//  input output list<DAE.Dimension> accDims = {};
//  output Type baseType;
//protected
//  list<DAE.Dimension> dims;
//algorithm
//  _ := match inCref
//
//    case DAE.CREF_IDENT()
//      algorithm
//        baseType := Type.elementType(inCref.identType);
//        dims := getTypeDims(inCref.identType);
//        dims := applySubsToDims(dims, inCref.subscriptLst);
//        accDims := dims;
//      then ();
//
//    case DAE.CREF_QUAL()
//      algorithm
//        (accDims,baseType) := getCrefType2(inCref.componentRef);
//        dims := getTypeDims(inCref.identType);
//        dims := applySubsToDims(dims, inCref.subscriptLst);
//        accDims := listAppend(dims, accDims);
//      then ();
//
//    else
//      fail();
//  end match;
//end getCrefType2;

public function getRangeType
  input Expression inStart;
  input Type inStartTy;
  input Option<Expression> inOptStep;
  input Option<Type> inOptStepTy;
  input Expression inEnd;
  input Type inEndTy;
  input SourceInfo info;
  output Type outType;
protected
  Boolean stepreal;
  Type stepty;
algorithm

  stepreal := false;
  if Type.isNumeric(inStartTy) and Type.isNumeric(inEndTy) then
    if isSome(inOptStepTy) then
	    SOME(stepty) := inOptStepTy;
	    if not Type.isNumeric(stepty) then
	      Error.addInternalError("Invalid range expression. Step expression is not numeric type.", info);
	      fail();
	    end if;
	    stepreal := Type.isReal(stepty);
    end if;
    try
      outType := getNumericRangeType(inStart, inOptStep, inEnd);
    else
      // TODO: for now let it be unknown. However the expression (end-start)/step + 1 should be the dim expression.
      if stepreal or Type.isReal(inStartTy) or Type.isReal(inEndTy) then
        outType := Type.ARRAY(Type.REAL(), {Dimension.UNKNOWN()});
      else
        outType := Type.ARRAY(Type.INTEGER(), {Dimension.UNKNOWN()});
      end if;
    end try;

  elseif Type.isBoolean(inStartTy) and Type.isBoolean(inEndTy) then
    if isSome(inOptStepTy) then
      Error.addInternalError("Invalid range expression. Non numeric range exressions can not have steps.", info);
      fail();
    end if;
    try
      outType := getBooleanRangeType(inStart, inOptStep, inEnd);
    else
      // TODO: for now let it be unknown. However an expression that can deduce the size from the possible true/false
      // combinations should be the dim expression.
      outType := Type.ARRAY(Type.BOOLEAN(), {Dimension.UNKNOWN()});
    end try;

  elseif Type.isEnumeration(inStartTy) and Type.isEnumeration(inEndTy) then
    if isSome(inOptStepTy) then
      Error.addInternalError("Invalid range expression. Non numeric range exressions can not have steps.", info);
      fail();
    end if;
    Error.addInternalError("Enumerator ranges are not handled yet.", info);
    fail();

  else
    Error.addInternalError("Invalid range expression. Start and end expressions have different types.", info);
    fail();
  end if;

end getRangeType;

function getNumericRangeType
  input Expression inStart;
  input Option<Expression> inOptStep;
  input Expression inEnd;
  output Type outType;
protected
  Integer size, istep;
  Expression step;
algorithm
  (outType, size) := match(inStart, inOptStep, inEnd)
    // Pure integer arguments results in an integer range.
    case (Expression.INTEGER(), NONE(), Expression.INTEGER())
      then (Type.INTEGER(), inEnd.value - inStart.value + 1);

    case (Expression.INTEGER(), SOME(Expression.INTEGER(value = istep)), Expression.INTEGER())
      then (Type.INTEGER(), intDiv(inEnd.value - inStart.value, istep) + 1);

    // Mixed Integer/Real or pure Real arguments results in a Real range.
    case (_, NONE(), _)
      then (Type.REAL(), Util.realRangeSize(Expression.realValue(inStart), 1.0,
        Expression.realValue(inEnd)));

    case (_, SOME(step), _)
      then (Type.REAL(), Util.realRangeSize(Expression.realValue(inStart),
          Expression.realValue(step), Expression.realValue(inEnd)));
  end match;

  outType := Type.ARRAY(outType, {Dimension.INTEGER(size)});
end getNumericRangeType;

function getBooleanRangeType
  input Expression inStart;
  input Option<Expression> inOptStep;
  input Expression inEnd;
  output Type outType;
protected
  Integer sz;
  Boolean s, e;
algorithm
  true := isNone(inOptStep);
  Expression.BOOLEAN(value = s) := inStart;
  Expression.BOOLEAN(value = e) := inEnd;

  sz := match (s, e)
    case (true, false) then 0;
    case (false, true) then 2;
    else 1;
  end match;

  outType := Type.ARRAY(Type.BOOLEAN(), {Dimension.INTEGER(sz)});
end getBooleanRangeType;

function checkIfExpression
  input Expression condExp;
  input Type condType;
  input DAE.Const condVar;
  input Expression thenExp;
  input Type thenType;
  input DAE.Const thenVar;
  input Expression elseExp;
  input Type elseType;
  input DAE.Const elseVar;
  input SourceInfo info;
  output Expression outExp;
  output Type outType;
  output DAE.Const outVar;
protected
   Expression ec, e1, e2;
   String s1, s2, s3, s4;
   Boolean tyMatch;
algorithm
  (ec, _, tyMatch) := matchTypes(condType, Type.BOOLEAN(), condExp);

  // The condition must be a boolean.
  if not tyMatch then
    s1 := Expression.toString(condExp);
    s2 := Type.toString(condType);
    Error.addSourceMessageAndFail(Error.IF_CONDITION_TYPE_ERROR, {s1, s2}, info);
  end if;

  (e1, e2, outType, tyMatch) :=
    matchExpressions(thenExp, thenType, elseExp, elseType);

  // The types of the branches must be compatible.
  if not tyMatch then
    s1 := Expression.toString(thenExp);
    s2 := Expression.toString(elseExp);
    s3 := Type.toString(thenType);
    s4 := Type.toString(elseType);
    Error.addSourceMessageAndFail(Error.TYPE_MISMATCH_IF_EXP,
      {"", s1, s3, s2, s4}, info);
  end if;

  outExp := Expression.IF(ec, e1, e2);
  outType := thenType;
  outVar := Types.constAnd(thenVar, elseVar);
end checkIfExpression;

annotation(__OpenModelica_Interface="frontend");
end NFTypeCheck;
