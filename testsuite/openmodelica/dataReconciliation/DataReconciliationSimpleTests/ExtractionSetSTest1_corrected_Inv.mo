within DataReconciliationSimpleTests;
model ExtractionSetSTest1_corrected_Inv
  Real x1(uncertain=Uncertainty.refine)=0;
  Real x2(uncertain=Uncertainty.refine)=0;
  Real x3(uncertain=Uncertainty.refine)=0;
  Real y1;
  Real y2;
  Real y3                               annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
equation
  // x1 = 0;
  // x1-x2 = 0;
  y1 = x2+2*x3;
  x3-y1+y2=x2;
  y2+y3=0;
  // y2-2*y3=3;
end ExtractionSetSTest1_corrected_Inv;
