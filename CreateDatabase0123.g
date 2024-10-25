eDir:="../../../PlanarGraph/23_6spheres/Data0123/";

for iClass in [0..3]
do
  Print("iClass=", iClass, "\n");
  for iFile in [1..200]
  do
    Print("  iClass=", iClass, " iFile=", iFile, "\n");
    eFile:=Concatenation(eDir, "DATA_C", String(iClass), "_", String(iFile));
    if IsExistingFile(eFile) then
      LPL:=ReadAsFunction(eFile)();
      if iClass=0 then
        if iFile>2 then
          ListPair:=[ [2,6], [3,2*(iFile-2)] ];
        else
          ListPair:=[ [2,6] ];
        fi;
      fi;
      if iClass=1 then
        ListPair:=[ [1,1], [2,4], [3,1+2*(iFile-2)] ];
      fi;
      if iClass=2 then
        if iFile>1 then
          ListPair:=[ [1,2], [2,2], [3,2*(iFile-1)] ];
        else
          ListPair:=[ [1,2], [2,2] ];
        fi;
      fi;
      if iClass=3 then
        ListPair:=[ [1,3], [3, 3+2*(iFile-2)] ];
      fi;
      if Length(LPL)>0 then
        PLori:=LPL[1];
        VEFori:=PlanGraphOrientedToVEF(PLori);
        ListFaceLen:=List(VEFori.FaceSet, Length);
        if Collected(ListFaceLen)<>ListPair then
          Error("Inconsistency in ListPair");
        fi;
      fi;
      k:=6;
      g:=0;
      nbV:=iFile;
      eStr:=GetMapDatabasePrefix(k, g, nbV, ListPair);
      eComm:=Concatenation("(cd MapDatabase_0123 && ln -sf ../", eFile, " ", eStr, ".data)");
      Exec(eComm);
      #
      eFileOut:=Concatenation("MapDatabase_0123/", eStr, ".info");
      eInfo:=rec(IsPLori:=true, Complete:=true);
      SaveDataToFile(eFileOut, eInfo);
    fi;
  od;



od;