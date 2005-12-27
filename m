Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ErKCr-0004Zj-2o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 11:09:57 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ErKCn-0005Dx-D9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 11:09:57 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Ho ho ho.. Linux 2.6.15-rc7
References: <20051227124500.CA66633495@sc8-sf-spam1.sourceforge.net>
	<1135705691.3719.13.camel@localhost.localdomain>
In-Reply-To: <1135705691.3719.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0FZsDQcUnGPZV+G"
Message-Id: <200512272009.40980.blaisorblade@yahoo.it>
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
Date: Tue, 27 Dec 2005 20:09:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>, Pekka Enberg <penberg@cs.helsinki.fi>

--Boundary-00=_0FZsDQcUnGPZV+G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 27 December 2005 18:48, Antoine Martin wrote:
> > On 12/25/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > > Please do give it a try, and if you have any issues/regressions,
> >
> > send out
> >
> > > a note (even if you sent one earlier) so that we don't forget about
> >
> > it.
> >
> > Hmm. Somebody broke UML compile for my config again...

Please test the attached patch, worksForMe now.

> Are you sure that you are using a raw 2.6.15-rc7?
He has disabled SKAS, which is causing this - however the breakage doesn't 
seem new into 2.6.15-rc7.

> AFAIK, no new UML patches made it into rc7, and mostly fixes since rc1
> (as required) I think I've had a similar issue before - can't remember
> (searching the archives may help), have you tried this:
> find . -size 0 -exec rm {} \;
> As some of the patches may leave empty files behind.

Luckily that doesn't happen for kernel.org patches, mostly... it's more common 
on incremental patches. The problem is that sometimes they get merged.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_0FZsDQcUnGPZV+G
Content-Type: text/x-diff; charset="iso-8859-1"; name="uml-skas0-only-for-skas"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-skas0-only-for-skas"

Index: linux-2.6.git/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.git.orig/arch/um/sys-i386/Makefile
+++ linux-2.6.git/arch/um/sys-i386/Makefile
@@ -1,6 +1,8 @@
-obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o stub.o stub_segv.o \
-	syscalls.o sysrq.o sys_call_table.o
+obj-y := bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
+	sys_call_table.o
+
+obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
Index: linux-2.6.git/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.git.orig/arch/um/sys-x86_64/Makefile
+++ linux-2.6.git/arch/um/sys-x86_64/Makefile
@@ -6,8 +6,9 @@
 
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o ldt.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
-	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
+	ptrace.o ptrace_user.o sigcontext.o signal.o syscalls.o \
+	syscall_table.o sysrq.o thunk.o
+lib-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o

--Boundary-00=_0FZsDQcUnGPZV+G--

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
