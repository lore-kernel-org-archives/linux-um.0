Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbqPJ-00045r-CN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 18:18:49 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EbqPF-0003i3-Dg
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 18:18:49 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511141745.44703.rob@landley.net>
	<20051115013855.GA12719@ccure.user-mode-linux.org>
In-Reply-To: <20051115013855.GA12719@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4VUeDJ8cOkYVuKF"
Message-Id: <200511142018.32074.rob@landley.net>
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
Date: Mon, 14 Nov 2005 20:18:31 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

--Boundary-00=_4VUeDJ8cOkYVuKF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 November 2005 19:38, Jeff Dike wrote:
> On Mon, Nov 14, 2005 at 05:45:44PM -0600, Rob Landley wrote:
> > The breakage, by the way, (which occurs when you fix the failing hunk #2
> > up by hand) stems from the inability to find asm/signal.h:
>
> What distro is this?  asm/signal is in glibc-kernheaders here:
>
> % rpm -q -f /usr/include/asm/signal.h
> glibc-kernheaders-2.4-9.1.94

Well, according to /proc/version, it's PLD:

Linux version 2.6.11.10-6 (builder@serwus) (gcc version 3.3.5 (PLD Linux)) #1 
Fri May 27 20:55:12 UTC 2005

rpm has a package "basesystem" that's version 1.99.

Here's their web page: http://www.pld.org.pl/

I think this is the distro Maszur originally did his linux-libc-headers 
package for, so I'm guessing that's what they're using.  (Not the glibc 
stuff.)  I use uClibc a lot elsewhere, and that generally uses Mazur's 
headers rather than the glibc ones too.

It has:

[rob@rg4 include]$ find /usr/include -name signal.h
/usr/include/linux/signal.h
/usr/include/signal.h
/usr/include/sys/signal.h

Hmm, I'm somewhat familiar with Mazur's headers and may be able to fix this 
up...

Ok, the attached patch builds for me.  (I didn't say it was _right_, I said it 
builds. :)

And let's see how it runs...

Nope, same failure.  Want the new panic and register dump?

--Boundary-00=_4VUeDJ8cOkYVuKF
Content-Type: text/x-diff;
  charset="utf-8";
  name="headers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="headers.patch"

--- linux-2.6.15-rc1/arch/um/sys-x86_64/stub_segv.c	2005-11-14 23:20:54.855517272 +0100
+++ linux-2.6.14/arch/um/sys-x86_64/stub_segv.c	2005-11-15 03:11:28.580804656 +0100
@@ -4,11 +4,9 @@
  */
 
 #include <linux/compiler.h>
-#include <asm/signal.h>
+#include <signal.h>
 #include <asm/unistd.h>
 #include <asm/sigcontext.h>
-#include <asm/siginfo.h>
-#include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"

--Boundary-00=_4VUeDJ8cOkYVuKF--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
