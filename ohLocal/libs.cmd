#Always search local
-y .

#DV local version
-y ./common/dv

#DV simple fifo
# -y ./memory/dv


-y ../oh/common/dv
-y ../oh/emesh/dv
-y ../oh/memory/dv
-y ../oh/accelerator/hdl
-y ../oh/axi/dv
-y ../oh/axi/hdl
-y ../oh/common/hdl
-y ../oh/elink/hdl
-y ../oh/edma/hdl
-y ../oh/emesh/hdl
-y ../oh/emmu/hdl
-y ../oh/emailbox/hdl
-y ../oh/etrace/hdl
-y ../oh/mio/hdl
-y ../oh/gpio/hdl
-y ../oh/memory/hdl
-y ../oh/parallella/hdl
-y ../oh/spi/hdl
-y ../oh/xilibs/hdl
-y ../oh/xilibs/ip

#INCLUDE PATHS (FOR CONSTANTS)
+incdir+../oh/emesh/hdl
+incdir+../oh/elink/hdl
+incdir+../oh/edma/hdl
+incdir+../oh/emmu/hdl
+incdir+../oh/emailbox/hdl
+incdir+../oh/accelerator/hdl
+incdir+../oh/etrace/hdl
+incdir+../oh/gpio/hdl
+incdir+../oh/spi/hdl
+incdir+../oh/mio/hdl

