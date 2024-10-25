eDir:="../../../PlanarGraph/Nanodisk/DATAicosahedrites/";

for p4 in [0..100]
do
  nbV:=12 + 2*p4;
  p3:=20 + 2*p4;
  if p4>0 then
    ListPair:=[ [3,p3], [4,p4] ];
  else
    ListPair:=[ [3,p3] ];
  fi;
  Print("  p4=", p4, "\n");
  eFile:=Concatenation(eDir, "LPL", String(nbV));
  if IsExistingFile(eFile) then
    LPL:=ReadAsFunction(eFile)();
    if Length(LPL)>0 then
      DualPL:=DualGraph(LPL[1]).PlanGraph;
      ListFaceLen:=List(DualPL, Length);
      if Collected(ListFaceLen)<>ListPair then
        Error("Inconsistency in ListPair");
      fi;
    fi;
    k:=5;
    g:=0;
    eStr:=GetMapDatabasePrefix(k, g, nbV, ListPair);
    eComm:=Concatenation("(cd MapDatabase_icosahedrite && ln -sf ../", eFile, " ", eStr, ".data)");
    Exec(eComm);
    #
    eFileOut:=Concatenation("MapDatabase_icosahedrite/", eStr, ".info");
    eInfo:=rec(IsPLori:=false, Complete:=true);
    SaveDataToFile(eFileOut, eInfo);
  fi;
od;
