Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1Kwr5M-0001yb-TD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Nov 2008 04:30:40 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kwr5K-0000Ra-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Nov 2008 04:30:40 +0000
Date: Fri, 31 Oct 2008 15:14:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20081031191452.GA10950@c2.user-mode-linux.org>
References: <f39be10d0810241608i590d13f5p429c02558a1c26cf@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f39be10d0810241608i590d13f5p429c02558a1c26cf@mail.gmail.com>
Subject: Re: [uml-devel] UML crashes when built with _FORTIFY_SOURCE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Roman Yepishev <roman.yepishev@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 25, 2008 at 02:08:31AM +0300, Roman Yepishev wrote:
> Temporary solution is to fix file declaration to be 108 or less bytes
> but checks should be introduced when socket path is constructed.

I don't really understand what you mean by checks being introduced,
but how do you like the patch below?

			Jeff

-- 
Work email - jdike at linux dot intel dot com

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 19d579d..cc88ef7 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -785,11 +785,12 @@ static int __init mconsole_init(void)
 	/* long to avoid size mismatch warnings from gcc */
 	long sock;
 	int err;
-	char file[256];
+	char file[UM_UNIX_PATH_MAX];
 
 	if (umid_file_name("mconsole", file, sizeof(file)))
 		return -1;
-	snprintf(mconsole_socket_name, sizeof(file), "%s", file);
+	snprintf(mconsole_socket_name, sizeof(file) - 1, "%s", file);
+	file[sizeof(file) - 1] = '\0';
 
 	sock = os_create_unix_socket(file, sizeof(file), 1);
 	if (sock < 0) {
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index f8cf4c8..f00735e 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/uio.h>
-#include <sys/un.h>
+#include <linux/un.h>
 #include "kern_constants.h"
 #include "mconsole.h"
 #include "user.h"
@@ -37,7 +37,7 @@ static struct mconsole_command commands[] = {
 };
 
 /* Initialized in mconsole_init, which is an initcall */
-char mconsole_socket_name[256];
+char mconsole_socket_name[UNIX_PATH_MAX];
 
 static int mconsole_reply_v0(struct mc_request *req, char *reply)
 {
diff --git a/arch/um/sys-i386/user-offsets.c b/arch/um/sys-i386/user-offsets.c
index 5f883bf..5e4ae72 100644
--- a/arch/um/sys-i386/user-offsets.c
+++ b/arch/um/sys-i386/user-offsets.c
@@ -2,8 +2,10 @@
 #include <stddef.h>
 #include <signal.h>
 #include <sys/poll.h>
+#include <sys/socket.h>
 #include <sys/user.h>
 #include <sys/mman.h>
+#include <linux/un.h>
 #include <asm/ptrace.h>
 
 #define DEFINE(sym, val) \
@@ -50,4 +52,6 @@ void foo(void)
 	DEFINE(UM_PROT_READ, PROT_READ);
 	DEFINE(UM_PROT_WRITE, PROT_WRITE);
 	DEFINE(UM_PROT_EXEC, PROT_EXEC);
+
+	DEFINE(UM_UNIX_PATH_MAX, UNIX_PATH_MAX);
 }
diff --git a/arch/um/sys-x86_64/user-offsets.c b/arch/um/sys-x86_64/user-offsets.c
index 9735854..e47b3bd 100644
--- a/arch/um/sys-x86_64/user-offsets.c
+++ b/arch/um/sys-x86_64/user-offsets.c
@@ -4,6 +4,7 @@
 #include <sys/poll.h>
 #include <sys/mman.h>
 #include <sys/user.h>
+#include <linux/un.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <asm/types.h>
@@ -62,4 +63,6 @@ void foo(void)
 	DEFINE(UM_PROT_READ, PROT_READ);
 	DEFINE(UM_PROT_WRITE, PROT_WRITE);
 	DEFINE(UM_PROT_EXEC, PROT_EXEC);
+
+	DEFINE(UM_UNIX_PATH_MAX, UNIX_PATH_MAX);
 }

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
