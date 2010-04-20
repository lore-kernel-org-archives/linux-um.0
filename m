Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1O4APS-0004nX-UU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 10:10:26 +0000
Received: from mail-pz0-f181.google.com ([209.85.222.181])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4APS-0006Cy-0t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 10:10:26 +0000
Received: by pzk11 with SMTP id 11so1379115pzk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Apr 2010 03:10:20 -0700 (PDT)
Date: Tue, 20 Apr 2010 18:14:06 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Message-ID: <20100420101406.GD5317@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<e89d636e305d095f5919c0e22cf92159c4067018.1271713955.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e89d636e305d095f5919c0e22cf92159c4067018.1271713955.git.jan.kiszka@web.de>
Subject: Re: [uml-devel] [PATCH 5/5] uml: Clean up asm/system.h
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Jeff Dike <jdike@addtoit.com>, trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 19, 2010 at 11:53:08PM +0200, Jan Kiszka wrote:
>Remove duplicates and unused prototypes.
>
>Signed-off-by: Jan Kiszka <jan.kiszka@web.de>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>


>---
> arch/um/include/asm/system.h |    3 ---
> 1 files changed, 0 insertions(+), 3 deletions(-)
>
>diff --git a/arch/um/include/asm/system.h b/arch/um/include/asm/system.h
>index 753346e..93af1cf 100644
>--- a/arch/um/include/asm/system.h
>+++ b/arch/um/include/asm/system.h
>@@ -3,11 +3,8 @@
> 
> #include "sysdep/system.h"
> 
>-extern void *switch_to(void *prev, void *next, void *last);
>-
> extern int get_signals(void);
> extern int set_signals(int enable);
>-extern int get_signals(void);
> extern void block_signals(void);
> extern void unblock_signals(void);
> 
>-- 
>1.6.0.2
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

