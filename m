Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Dewar <alex.dewar@gmx.co.uk>
Subject: [PATCH 3/4] Add SPDX headers for files in arch/um/os-Linux
Date: Sun, 25 Aug 2019 10:49:18 +0100
Message-Id: <20190825094919.4731-4-alex.dewar@gmx.co.uk>
In-Reply-To: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
References: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar@gmx.co.uk>
List-ID: <linux-um.lists.infradead.org>

Convert files to use SPDX header. All files are licensed under the GPLv2.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 arch/um/os-Linux/Makefile                | 2 +-
 arch/um/os-Linux/drivers/Makefile        | 2 +-
 arch/um/os-Linux/drivers/etap.h          | 2 +-
 arch/um/os-Linux/drivers/ethertap_kern.c | 2 +-
 arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
 arch/um/os-Linux/drivers/tuntap.h        | 2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   | 2 +-
 arch/um/os-Linux/drivers/tuntap_user.c   | 2 +-
 arch/um/os-Linux/file.c                  | 2 +-
 arch/um/os-Linux/helper.c                | 2 +-
 arch/um/os-Linux/irq.c                   | 2 +-
 arch/um/os-Linux/main.c                  | 2 +-
 arch/um/os-Linux/mem.c                   | 2 +-
 arch/um/os-Linux/process.c               | 2 +-
 arch/um/os-Linux/registers.c             | 2 +-
 arch/um/os-Linux/sigio.c                 | 2 +-
 arch/um/os-Linux/signal.c                | 2 +-
 arch/um/os-Linux/skas/Makefile           | 2 +-
 arch/um/os-Linux/skas/mem.c              | 2 +-
 arch/um/os-Linux/skas/process.c          | 2 +-
 arch/um/os-Linux/start_up.c              | 2 +-
 arch/um/os-Linux/time.c                  | 2 +-
 arch/um/os-Linux/tty.c                   | 2 +-
 arch/um/os-Linux/umid.c                  | 2 +-
 arch/um/os-Linux/util.c                  | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 455b500afe97..839915b8c31c 100644
=2D-- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-# Licensed under the GPL
 #

 # Don't instrument UML-specific code
diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/=
Makefile
index 6c546dc9222b..d79e75f1b69a 100644
=2D-- a/arch/um/os-Linux/drivers/Makefile
+++ b/arch/um/os-Linux/drivers/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
-# Licensed under the GPL
 #

 ethertap-objs :=3D ethertap_kern.o ethertap_user.o
diff --git a/arch/um/os-Linux/drivers/etap.h b/arch/um/os-Linux/drivers/et=
ap.h
index 54183a679fdd..a475259f90e1 100644
=2D-- a/arch/um/os-Linux/drivers/etap.h
+++ b/arch/um/os-Linux/drivers/etap.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __DRIVERS_ETAP_H
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/d=
rivers/ethertap_kern.c
index f424600a583f..3182e759d8de 100644
=2D-- a/arch/um/os-Linux/drivers/ethertap_kern.c
+++ b/arch/um/os-Linux/drivers/ethertap_kern.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <linux/init.h>
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/d=
rivers/ethertap_user.c
index 6d4918246ffe..9483021d86dd 100644
=2D-- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
  * Copyright (C) 2001 by various other people who didn't put their name h=
ere.
- * Licensed under the GPL.
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/drivers/tuntap.h b/arch/um/os-Linux/drivers/=
tuntap.h
index 7367354ac8df..e364e42abfc5 100644
=2D-- a/arch/um/os-Linux/drivers/tuntap.h
+++ b/arch/um/os-Linux/drivers/tuntap.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #ifndef __UM_TUNTAP_H
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/os-Linux/dri=
vers/tuntap_kern.c
index d9d56e5810fe..adcb6717be6f 100644
=2D-- a/arch/um/os-Linux/drivers/tuntap_kern.c
+++ b/arch/um/os-Linux/drivers/tuntap_kern.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <linux/netdevice.h>
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/dri=
vers/tuntap_user.c
index db24ce0d09a6..53eb3d508645 100644
=2D-- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index f25b110d4e70..453a2273e8c6 100644
=2D-- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 3f02d4232812..9fa6e4187d4f 100644
=2D-- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index 365823010346..d508310ee5e1 100644
=2D-- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 - Cambridge Greys Ltd
  * Copyright (C) 2011 - 2014 Cisco Systems Inc
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f1fee2b91239..c8a42ecbd7a2 100644
=2D-- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index e162a95ad7dd..3c1b77474d2d 100644
=2D-- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index b3e0d40932e1..e52dd37ddadc 100644
=2D-- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index 2ff8d4fe83c4..2d9270508e15 100644
=2D-- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2004 PathScale, Inc
  * Copyright (C) 2004 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <errno.h>
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 46e762f926eb..d88e9cb739c4 100644
=2D-- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <unistd.h>
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 75b10235d369..f450147b9711 100644
=2D-- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.u=
k})
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2004 PathScale, Inc
  * Copyright (C) 2004 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/os-Linux/skas/Makefile b/arch/um/os-Linux/skas/Makefi=
le
index d2ea3409e072..c4566e788815 100644
=2D-- a/arch/um/os-Linux/skas/Makefile
+++ b/arch/um/os-Linux/skas/Makefile
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
-# Licensed under the GPL
 #

 obj-y :=3D mem.o process.o
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 35015e3e1e87..c546d16f8dfe 100644
=2D-- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stddef.h>
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/proce=
ss.c
index df4a985716eb..f34a7126aec5 100644
=2D-- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 82bf5f8442ba..f79dc338279e 100644
=2D-- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 6d94ff52362c..432f8e1f55c2 100644
=2D-- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.u=
k})
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2012-2014 Cisco Systems
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stddef.h>
diff --git a/arch/um/os-Linux/tty.c b/arch/um/os-Linux/tty.c
index 721d8afa329b..f784db83e026 100644
=2D-- a/arch/um/os-Linux/tty.c
+++ b/arch/um/os-Linux/tty.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdlib.h>
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index e261656fe9d7..44def53a11cd 100644
=2D-- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 8cc8b2617a67..ecf2f390fad2 100644
=2D-- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
  */

 #include <stdio.h>
=2D-
2.23.0


