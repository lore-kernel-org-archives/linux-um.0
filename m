Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVAap-0003eI-5Q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:40:43 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVAao-0007Bk-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:40:43 -0700
Date: Mon, 18 Aug 2008 12:20:41 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20080818192041.GM10350@suse.de>
References: <20080818191012.663450219@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline;
	filename="uml-fix-gcc-ices-and-unresolved-externs.patch"
In-Reply-To: <20080818191834.GA10350@suse.de>
Subject: [uml-devel] [patch 38/49] uml: fix gcc ICEs and unresolved externs
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>, alan@lxorguk.ukuu.org.uk, Eugene Teo <eteo@redhat.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Ingo Molnar <mingo@elte.hu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Chuck Wolber <chuckw@quantumlinux.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jake Edge <jake@lwn.net>, Dave Jones <davej@redhat.com>, Jeff Dike <jdike@linux.intel.com>, akpm@linux-foundation.org, Theodore Ts'o <tytso@mit.edu>, Ulrich Drepper <drepper@redhat.com>, Chuck Ebbert <cebbert@redhat.com>, Benny Halevy <bhalevy@panasas.com>, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>

2.6.25-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Dike <jdike@addtoit.com>

commit 4f81c5350b44bcc501ab6f8a089b16d064b4d2f6 upstream

There are various constraints on the use of unit-at-a-time:
 - i386 uses no-unit-at-a-time for pre-4.0 (not 4.3)
 - x86_64 uses unit-at-a-time always

Uli reported a crash on x86_64 with gcc 4.1.2 with unit-at-a-time,
resulting in commit c0a18111e571138747a98af18b3a2124df56a0d1

Ingo reported a gcc internal error with gcc 4.3 with no-unit-at-a-timem,
resulting in 22eecde2f9034764a3fd095eecfa3adfb8ec9a98

Benny Halevy is seeing extern inlines not resolved with gcc 4.3 with
no-unit-at-a-time

This patch reintroduces unit-at-a-time for gcc >= 4.0, bringing back the
possibility of Uli's crash.  If that happens, we'll debug it.

I started seeing both the internal compiler errors and unresolved
inlines on Fedora 9.  This patch fixes both problems, without so far
reintroducing the crash reported by Uli.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: Benny Halevy <bhalevy@panasas.com>
Cc: Adrian Bunk <bunk@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Makefile        |    1 -
 arch/um/Makefile-i386   |    7 +++++++
 arch/um/Makefile-x86_64 |    3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -77,7 +77,6 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
 KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
-KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
 PHONY += linux
 
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -32,4 +32,11 @@ cflags-y += $(call cc-option,-mpreferred
 # an unresolved reference.
 cflags-y += -ffreestanding
 
+# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
+# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
+# 4.3.0 needs -funit-at-a-time for extern inline functions.
+KBUILD_CFLAGS += $(shell if [ $(call cc-version) -lt 0400 ] ; then \
+			echo $(call cc-option,-fno-unit-at-a-time); \
+			else echo $(call cc-option,-funit-at-a-time); fi ;)
+
 KBUILD_CFLAGS += $(cflags-y)
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -21,3 +21,6 @@ HEADER_ARCH := x86
 
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 LINK-y += -m64
+
+# Do unit-at-a-time unconditionally on x86_64, following the host
+KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)

-- 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
