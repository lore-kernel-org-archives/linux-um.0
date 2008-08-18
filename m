Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVAbE-0003jj-00 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:41:08 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVAbC-0006Ys-DN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:41:07 -0700
Date: Mon, 18 Aug 2008 12:20:43 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20080818192043.GN10350@suse.de>
References: <20080818191012.663450219@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline; filename="uml-fix-boot-crash.patch"
In-Reply-To: <20080818191834.GA10350@suse.de>
Subject: [uml-devel] [patch 39/49] uml: Fix boot crash
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
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Eugene Teo <eteo@redhat.com>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Jake Edge <jake@lwn.net>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>

2.6.25-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Dike <jdike@addtoit.com>

commit 7c1fed03b9fa32d4323d5caa6a9c7dcdd7eba767 upstream

My copying of linux/init.h didn't go far enough.  The definition of
__used singled out gcc minor version 3, but didn't care what the major
version was.  This broke when unit-at-a-time was added and gcc started
throwing out initcalls.

This results in an early boot crash when ptrace tries to initialize a
process with an empty, uninitialized register set.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/include/init.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/um/include/init.h
+++ b/arch/um/include/init.h
@@ -45,6 +45,8 @@ typedef void (*exitcall_t)(void);
 # define __section(S) __attribute__ ((__section__(#S)))
 #endif
 
+#if __GNUC__ == 3
+
 #if __GNUC_MINOR__ >= 3
 # define __used			__attribute__((__used__))
 #else
@@ -52,6 +54,12 @@ typedef void (*exitcall_t)(void);
 #endif
 
 #else
+#if __GNUC__ == 4
+# define __used			__attribute__((__used__))
+#endif
+#endif
+
+#else
 #include <linux/compiler.h>
 #endif
 /* These are for everybody (although not all archs will actually

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
