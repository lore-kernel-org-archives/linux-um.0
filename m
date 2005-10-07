Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENwF8-0004g4-6Z	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 10:42:50 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ENwF4-00010z-NB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 10:42:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13-bs3 amd64 compilation broken?
References: <1128695313.15932.30.camel@localhost.localdomain>
	<43467BEE.7000503@gmail.com>
In-Reply-To: <43467BEE.7000503@gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XJrRDxsGwcjqUpc"
Message-Id: <200510071937.27810.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 7 Oct 2005 19:37:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alan Menegotto <macnish@gmail.com>

--Boundary-00=_XJrRDxsGwcjqUpc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 07 October 2005 15:45, Alan Menegotto wrote:
> Antoine Martin wrote:
> >I tried twice to be sure, but compile fails near the end:
> >
> > CC      arch/um/sys-x86_64/stub_segv.o
> >arch/um/sys-x86_64/stub_segv.c: In function `stub_segv_handler':
> >arch/um/sys-x86_64/stub_segv.c:41: warning: implicit declaration of
> >function `container_of'
> >arch/um/sys-x86_64/stub_segv.c:41: error: parse error before "struct"
> >make[1]: *** [arch/um/sys-x86_64/stub_segv.o] Error 1
> >make: *** [arch/um/sys-x86_64] Error 2
> >
> >Antoine

> I've got no such errors compiling 2.6.13-bs9 (probably one version
> further, I'm not sure about the version). Try the latest 'bs patch' and
> the latest vanilla kernel version (2.6.13-3) and the error should be gone.
Probably you tried 2.6.12-bs9 - 2.6.13 latest -bs is 3.

Also, this was added in -bs3, to fix another problem.

Try the attached patch.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_XJrRDxsGwcjqUpc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-early-x86_64-crash-fix-compile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-early-x86_64-crash-fix-compile"

uml: compile-time fix for x86_64 frame pointer fix

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This should fix the compile-time error on x86_64. We can't get container_of from
host headers, since it's new in 2.6. offsetof, instead, is ANSI C. But it's
untested.

Jeff, stick this with the original patch when sending it upstream (it's
introduced by your fix for frame-pointer-less x86_64 binaries).

After Antoine Martin tested this on his build environment, anyway.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-x86_64/stub_segv.c
+++ linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
@@ -9,6 +9,7 @@
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
+#include <stddef.h>
 
 /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
  * in the libc headers anywhere.
@@ -20,6 +21,11 @@ struct rt_sigframe
         struct siginfo info;
 };
 
+/* Copied here from <linux/kernel.h> - we're userspace. */
+#define container_of(ptr, type, member) ({			\
+        const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
+        (type *)( (char *)__mptr - offsetof(type,member) );})
+
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig)
 {

--Boundary-00=_XJrRDxsGwcjqUpc--


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
