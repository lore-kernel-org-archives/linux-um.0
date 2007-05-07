Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hl9xQ-0002op-TD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:37:46 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hl9xP-00026v-H1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:37:20 -0700
Date: Mon, 7 May 2007 13:40:20 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20070507134020.26a6be17.randy.dunlap@oracle.com>
In-Reply-To: <20070507202019.GA8512@c2.user-mode-linux.org>
References: <20070507202019.GA8512@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/5] Fix Linuxdoc comment
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
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 7 May 2007 16:20:19 -0400 Jeff Dike wrote:

> A linuxdoc comment had fallen out of date - it refers to an argument
> which no longer exists.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  kernel/irq/handle.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-2.6.21-mm/kernel/irq/handle.c
> ===================================================================
> --- linux-2.6.21-mm.orig/kernel/irq/handle.c	2007-05-02 11:21:45.000000000 -0400
> +++ linux-2.6.21-mm/kernel/irq/handle.c	2007-05-04 14:53:58.000000000 -0400
> @@ -22,7 +22,6 @@
>   * handle_bad_irq - handle spurious and unhandled irqs
>   * @irq:       the interrupt number
>   * @desc:      description of the interrupt
> - * @regs:      pointer to a register structure
>   *
>   * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
>   */

Yes, I (or someone) need(s) to make scripts/kernel-doc catch "extra"
function @parameters like that.

BTW, this patch shouldn't be part of the UML patch series...
it's totally unrelated.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
