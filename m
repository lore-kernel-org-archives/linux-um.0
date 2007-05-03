Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjUVN-0001lK-5n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 23:09:29 -0700
Received: from smtp1.linux-foundation.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjUVL-0004AM-IE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 May 2007 23:09:28 -0700
Date: Wed, 2 May 2007 23:09:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070502230919.cb6864df.akpm@linux-foundation.org>
In-Reply-To: <20070501193646.GA9482@c2.user-mode-linux.org>
References: <20070501193646.GA9482@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - forgot asm-um/cmpxchg.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 1 May 2007 15:36:46 -0400 Jeff Dike <jdike@addtoit.com> wrote:

> The i386 and x86_64 cmpxchg patches require an asm-um/cmpxchg.h for
> the UML build.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  include/asm-um/cmpxchg.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-2.6.21-mm/include/asm-um/cmpxchg.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.21-mm/include/asm-um/cmpxchg.h	2007-05-01 15:31:09.000000000 -0400
> @@ -0,0 +1,6 @@
> +#ifndef __UM_CMPXCHG_H
> +#define __UM_CMPXCHG_H
> +
> +#include "asm/arch/cmpxchg.h"
> +
> +#endif

OK, I clumped all three patches into one as I think that's required for
git-bisect friendliness.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
