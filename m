Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JNdEl-0003UC-2K for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Feb 2008 16:06:31 -0800
Received: from twin.jikos.cz ([213.151.79.26] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JNdEi-0004k2-D6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Feb 2008 16:06:30 -0800
Date: Sat, 9 Feb 2008 01:05:15 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <20080208223228.GD6505@cs181133002.pp.htv.fi>
Message-ID: <Pine.LNX.4.64.0802090102590.30873@twin.jikos.cz>
References: <20080208223228.GD6505@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml compile error
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
To: Adrian Bunk <bunk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, Miklos Szeredi <mszeredi@suse.cz>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, 9 Feb 2008, Adrian Bunk wrote:

> Commit dd2cc4dff3b08ab54c4c177a080046bcc84ac41d broke uml:
> <-- snip  -->
> ...
>   CC      fs/hostfs/hostfs_kern.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/fs/hostfs/hostfs_kern.c: In function 'hostfs_show_options':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/fs/hostfs/hostfs_kern.c:328: error: dereferencing pointer to incomplete type
> make[3]: *** [fs/hostfs/hostfs_kern.o] Error 1

I guess we need this one?



From: Jiri Kosina <jkosina@suse.cz>

UML: fix hostfs build

We need to include mount.h to get vfsmount.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d0549cb..5222345 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -12,6 +12,7 @@
 #include <linux/pagemap.h>
 #include <linux/statfs.h>
 #include <linux/seq_file.h>
+#include <linux/mount.h>
 #include "hostfs.h"
 #include "init.h"
 #include "kern.h"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
