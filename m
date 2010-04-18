Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BCB353A.3040806@web.de>
Date: Sun, 18 Apr 2010 18:37:14 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
Subject: [PATCH] uml: Fix build breakage after slab.h changes
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Tejun Heo <tj@kernel.org>, Tiger Yang <tiger.yang@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

We now have to to include linux/slab.h explicitly for kmalloc & friends.
Files that build against host headers already get their prototypes via
um_malloc.h, linux/slab.h may even be unavailable.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/drivers/line.c    |    1 +
 arch/um/os-Linux/helper.c |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 64cda95..7a656bd 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -6,6 +6,7 @@
 #include "linux/irqreturn.h"
 #include "linux/kd.h"
 #include "linux/sched.h"
+#include "linux/slab.h"
 #include "chan_kern.h"
 #include "irq_kern.h"
 #include "irq_user.h"
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 06d6ccf..b6b1096 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -8,7 +8,6 @@
 #include <errno.h>
 #include <sched.h>
 #include <linux/limits.h>
-#include <linux/slab.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include "kern_constants.h"

