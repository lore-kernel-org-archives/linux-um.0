Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKPqV-00H10N-Gp
	for linux-um@lists.infradead.org; Sat, 06 Aug 2022 19:52:28 +0000
Received: by mail-ej1-x634.google.com with SMTP id j8so10219034ejx.9
        for <linux-um@lists.infradead.org>; Sat, 06 Aug 2022 12:52:25 -0700 (PDT)
From: Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH v1 1/2] um: fix default console kernel parameter
Date: Sat,  6 Aug 2022 21:52:22 +0200
Message-Id: <53b5c5f559cc95fc676cb4cc9e5a8d9f0cb8f58c.1659815468.git.chunkeey@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Meyer <thomas@m3y3r.de>

OpenWrt's UML with 5.15 was producing odd errors/warnings during preinit
part of the early userspace portion:

|[    0.000000] Kernel command line: ubd0=root.img root=98:0 console=tty
|[...]
|[    0.440000] random: jshn: uninitialized urandom read (4 bytes read)
|[    0.460000] random: jshn: uninitialized urandom read (4 bytes read)
|/etc/preinit: line 47: can't create /dev/tty: No such device or address
|/etc/preinit: line 48: can't create /dev/tty: No such device or address
|/etc/preinit: line 58: can't open /dev/tty: No such device or address
|[...] repeated many times

That "/dev/tty" came from the command line (which is automatically
added if no console= parameter was specified for the uml binary).

The TLDP project tells the following about the /dev/tty:
<https://tldp.org/HOWTO/Text-Terminal-HOWTO-7.html#ss7.3>
| /dev/tty stands for the controlling terminal (if any) for the current
| process.[...]
| /dev/tty is something like a link to the actually terminal device[..]

The "(if any)" is important here, since it's possible for processes to
not have a controlling terminal.

I think this was a simple typo and the author wanted tty0 there.

CC: Thomas Meyer <thomas@m3y3r.de>
Fixes: d7ffac33631b ("um: stdio_console: Make preferred console")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9838967d0b2f..9c6991f42131 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -32,7 +32,7 @@
 #include "um_arch.h"
 
 #define DEFAULT_COMMAND_LINE_ROOT "root=98:0"
-#define DEFAULT_COMMAND_LINE_CONSOLE "console=tty"
+#define DEFAULT_COMMAND_LINE_CONSOLE "console=tty0"
 
 /* Changed in add_arg and setup_arch, which run before SMP is started */
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

