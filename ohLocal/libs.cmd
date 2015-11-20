#Always search local
-y .

#DV local version
-y ./common/dv

#DV simple fifo
-y ./memory/dv

#DV oh version
-y ../oh/common/dv
-y ../oh/emesh/dv
-y ../oh/memory/dv

#DV axi
-y ../oh/axi/dv

#HDL
-y .
-y ../oh/common/hdl
-y ../oh/elink/hdl
-y ../oh/edma/hdl
-y ../oh/emesh/hdl
-y ../oh/emmu/hdl
-y ../oh/emailbox/hdl
-y ../oh/memory/hdl
-y ../oh/xilibs/hdl
-y ../oh/xilibs/ip
-y ../oh/parallella/hdl

#INCLUDE PATHS (FOR CONSTANTS)
+incdir+../oh/emesh/hdl
+incdir+../oh/elink/hdl
+incdir+../oh/edma/hdl
+incdir+../oh/emmu/hdl
+incdir+../oh/emailbox/hdl
