eDir:="../../../PlanarGraph/Hedrites/DataHedrites/";

List_iHed  :=[4,5,6,7,8];
List_MinNbV:=[2, 3, 4, 7, 6];


GetListPair:=function(iHed, nbV)
  local ListPair;
  if iHed=4 then
    if nbV>2 then
      ListPair:=[ [2,4],        [4,nbV-2] ];
    else
      ListPair:=[ [2,4] ];
    fi;
  fi;
  if iHed=5 then
    if nbV>3 then
      ListPair:=[ [2,3], [3,2], [4,nbV-3] ];
    else
      ListPair:=[ [2,3], [3,2] ];
    fi;
  fi;
  if iHed=6 then
    if nbV>4 then
      ListPair:=[ [2,2], [3,4], [4,nbV-4] ];
    else
      ListPair:=[ [2,2], [3,4] ];
    fi;
  fi;
  if iHed=7 then
    ListPair  :=[ [2,1], [3,6], [4,nbV-5] ];
  fi;
  if iHed=8 then
    if nbV>6 then
      ListPair:=[        [3,8], [4,nbV-6] ];
    else
      ListPair:=[        [3,8] ];
    fi;
  fi;
  return ListPair;
end;

#CreateDatabase:=false;
CreateDatabase:=true;
if CreateDatabase then
  for iHed in [4..8]
  do
    pos:=Position(List_iHed, iHed);
    MinNbV:=List_MinNbV[pos];
    Print("iHed=", iHed, "\n");
    for nbV in [MinNbV..200]
    do
      Print("  iHed=", iHed, " nbV=", nbV, "\n");
      ListPair:=GetListPair(iHed, nbV);
      eFile:=Concatenation(eDir, String(iHed), "-Hedrite", String(nbV));
      IsExist:=true;
      if IsExistingFile(eFile)=true then
        if iHed=4 then
          LPLnorm:=ReadAsFunction(eFile)();
          LPL:=List(LPLnorm, PlanGraphToPlanGraphOriented);
          if IsInt(nbV/2) then
            Add(LPL, SpecialFamily4hedrite(nbV/2));
	    Print("Inserting special family\n");
          fi;
          if nbV=4 then
            PL1:=Foil(4);
            Add(LPL, PlanGraphToPlanGraphOriented(PL1));
	    Print("Inserting exceptional\n");
          fi;
          eInfo:=rec(IsPLori:=true, Complete:=true);
          HaveFile:=false;
        else
          LPL:=ReadAsFunction(eFile)();
          eInfo:=rec(IsPLori:=false, Complete:=true);
          HaveFile:=true;
        fi;
      else
        eInfo:=rec(IsPLori:=true, Complete:=true);
        HaveFile:=false;
        OperDone:=false;
        if nbV>50 then
          IsExist:=false;
          OperDone:=true;
        fi;
        if iHed=4 then
          if nbV=2 then
            LPL:=[Mbundle(4)];
            OperDone:=true;
          fi;
        fi;
        if OperDone=false then
          Error("Debug from that point");
        fi;
      fi;
      if Length(LPL)>0 and eInfo.IsPLori=false then
        ePL:=LPL[1];
        PLori:=PlanGraphToPlanGraphOriented(ePL);
        VEFori:=PlanGraphOrientedToVEF(PLori);
        ListFaceLen:=List(VEFori.FaceSet, Length);
        if Collected(ListFaceLen)<>ListPair then
          Error("Inconsistency in ListPair");
        fi;
      fi;
      k:=4;
      g:=0;
      eStr:=GetMapDatabasePrefix(k, g, nbV, ListPair);
      if IsExist then
        if HaveFile=true then
          eComm:=Concatenation("(cd MapDatabase_hedrites && ln -sf ../", eFile, " ", eStr, ".data)");
          Exec(eComm);
        else
          FileSave:=Concatenation("MapDatabase_hedrites/", eStr, ".data");
          SaveDataToFile(FileSave, LPL);
        fi;
        #
        eFileOut:=Concatenation("MapDatabase_hedrites/", eStr, ".info");
        SaveDataToFile(eFileOut, eInfo);
      fi;
    od;
  od;
fi;

# ListInfoFrom OCT2 paper
ListInfo:=[
rec(nbV:=6 , iHed:=8, nbG:=1),
rec(nbV:=8 , iHed:=8, nbG:=1),
rec(nbV:=9 , iHed:=8, nbG:=1),
rec(nbV:=10, iHed:=8, nbG:=2),
rec(nbV:=11, iHed:=8, nbG:=1),
rec(nbV:=12, iHed:=8, nbG:=5),
rec(nbV:=13, iHed:=8, nbG:=2),
rec(nbV:=14, iHed:=8, nbG:=8),
rec(nbV:=15, iHed:=8, nbG:=5), 

rec(nbV:=7 , iHed:=7, nbG:=1),
rec(nbV:=8 , iHed:=7, nbG:=1),
rec(nbV:=9 , iHed:=7, nbG:=1),
rec(nbV:=10, iHed:=7, nbG:=3),
rec(nbV:=11, iHed:=7, nbG:=4),
rec(nbV:=12, iHed:=7, nbG:=5),
rec(nbV:=13, iHed:=7, nbG:=7),
rec(nbV:=14, iHed:=7, nbG:=9),
rec(nbV:=15, iHed:=7, nbG:=12),

rec(nbV:=4 , iHed:=6, nbG:=1),
rec(nbV:=5 , iHed:=6, nbG:=1),
rec(nbV:=6 , iHed:=6, nbG:=2),
rec(nbV:=7 , iHed:=6, nbG:=1),
rec(nbV:=8 , iHed:=6, nbG:=5),
rec(nbV:=9 , iHed:=6, nbG:=5),
rec(nbV:=10, iHed:=6, nbG:=9),
rec(nbV:=11, iHed:=6, nbG:=7),
rec(nbV:=12, iHed:=6, nbG:=14),
rec(nbV:=13, iHed:=6, nbG:=14),
rec(nbV:=14, iHed:=6, nbG:=23),
rec(nbV:=15, iHed:=6, nbG:=17),

rec(nbV:=3 , iHed:=5, nbG:=1),
rec(nbV:=4 , iHed:=5, nbG:=0),
rec(nbV:=5 , iHed:=5, nbG:=1),
rec(nbV:=6 , iHed:=5, nbG:=2),
rec(nbV:=7 , iHed:=5, nbG:=3),
rec(nbV:=8 , iHed:=5, nbG:=1),
rec(nbV:=9 , iHed:=5, nbG:=2),
rec(nbV:=10, iHed:=5, nbG:=3),
rec(nbV:=11, iHed:=5, nbG:=5),
rec(nbV:=12, iHed:=5, nbG:=3),
rec(nbV:=13, iHed:=5, nbG:=4),
rec(nbV:=14, iHed:=5, nbG:=7),
rec(nbV:=15, iHed:=5, nbG:=10),

rec(nbV:=2 , iHed:=4, nbG:=1),
rec(nbV:=3 , iHed:=4, nbG:=0),
rec(nbV:=4 , iHed:=4, nbG:=2),
rec(nbV:=5 , iHed:=4, nbG:=0),
rec(nbV:=6 , iHed:=4, nbG:=2),
rec(nbV:=7 , iHed:=4, nbG:=0),
rec(nbV:=8 , iHed:=4, nbG:=4),
rec(nbV:=9 , iHed:=4, nbG:=0),
rec(nbV:=10, iHed:=4, nbG:=3),
rec(nbV:=11, iHed:=4, nbG:=0),
rec(nbV:=12, iHed:=4, nbG:=5),
rec(nbV:=13, iHed:=4, nbG:=0),
rec(nbV:=14, iHed:=4, nbG:=3),
rec(nbV:=15, iHed:=4, nbG:=0)
];




PrintNumberGraph:=true;
if PrintNumberGraph then
  for nbV in [2..15]
  do
    Print("nbV=", nbV, "\n");
    for iHed in [4..8]
    do
      pos:=Position(List_iHed, iHed);
      MinNbV:=List_MinNbV[pos];
      if nbV >= MinNbV then
        ListPair:=GetListPair(iHed, nbV);
        k:=4;
        g:=0;
        eStr:=GetMapDatabasePrefix(k, g, nbV, ListPair);
        FileSave:=Concatenation("MapDatabase_hedrites/", eStr, ".data");
        U:=ReadAsFunction(FileSave)();
        nbG:=Length(U);
      else
        nbG:=0;
      fi;
      nbGtable:=-1;
      for eInfo in ListInfo
      do
        if eInfo.nbV=nbV and eInfo.iHed=iHed then
          nbGtable:=eInfo.nbG;
        fi;
      od;
      if nbGtable <> -1 and nbG<>nbGtable then
        Print("Inconsistency at nbV=", nbV, " iHed=", iHed, " nbG=", nbG, " nbGtable=", nbGtable, "\n");
        if nbG>nbGtable then
          Print("U=", U, "\n");
        fi;
      fi;
      Print("   iHed=", iHed, " nbG=", nbG, "\n");
    od;
  od;
fi;

