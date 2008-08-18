Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVAbc-0003k3-Sb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:41:32 -0700
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVAbb-0007Ss-9g
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 12:41:32 -0700
Date: Mon, 18 Aug 2008 12:20:45 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20080818192045.GO10350@suse.de>
References: <20080818191012.663450219@mini.kroah.org>
MIME-Version: 1.0
Content-Disposition: inline; filename="uml-path_max-needs-limits.h.patch"
In-Reply-To: <20080818191834.GA10350@suse.de>
Subject: [uml-devel] [patch 40/49] uml: PATH_MAX needs limits.h
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
Cc: Ingo Molnar <mingo@elte.hu>, Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Eugene Teo <eteo@redhat.com>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Jake Edge <jake@lwn.net>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>

2.6.25-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Ingo Molnar <mingo@elte.hu>

commit b6d8adf477439e7086224bc9674c6b6638780783 upstream.

Include limits.h to get a definition of PATH_MAX.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/os-Linux/helper.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <linux/limits.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
 #include "kern_constants.h"

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
