Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVAXM-0003Je-2o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:37:08 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVAXK-00058a-AR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:37:08 -0700
Date: Mon, 18 Aug 2008 12:20:21 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20080818192021.GD10350@suse.de>
References: <20080818191012.663450219@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline;
	filename="uml-physical-memory-shouldn-t-include-initial-stack.patch"
In-Reply-To: <20080818191834.GA10350@suse.de>
Subject: [uml-devel] [patch 29/49] uml: physical memory shouldnt include
	initial stack
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
Cc: Jeff Dike <jdike@linux.intel.com>, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, WANG Cong <xiyou.wangcong@gmail.com>, Eugene Teo <eteo@redhat.com>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Jake Edge <jake@lwn.net>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, "Christopher S. Aker" <caker@theshore.net>, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>

2.6.25-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Dike <jdike@addtoit.com>

commit 60a2988aea701a6424809a5432bf068667aac177 upstream

The top of physical memory should be below the initial process stack, not the
top of the address space, at least for as long as the stack isn't known to the
kernel VM system and appropriately reserved.

Cc: "Christopher S. Aker" <caker@theshore.net>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/kernel/um_arch.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -259,6 +259,7 @@ int __init linux_main(int argc, char **a
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
 	unsigned int i, add;
+	unsigned long stack;
 	char * mode;
 
 	for (i = 1; i < argc; i++) {
@@ -347,7 +348,9 @@ int __init linux_main(int argc, char **a
 	}
 
 	virtmem_size = physmem_size;
-	avail = TASK_SIZE - start_vm;
+	stack = (unsigned long) argv;
+	stack &= ~(1024 * 1024 - 1);
+	avail = stack - start_vm;
 	if (physmem_size > avail)
 		virtmem_size = avail;
 	end_vm = start_vm + virtmem_size;

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
