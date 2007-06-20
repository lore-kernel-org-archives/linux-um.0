Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I11wj-0007Ct-RZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 08:18:14 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I11wf-0008Iy-Qx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 08:18:13 -0700
Date: Wed, 20 Jun 2007 11:17:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070620151753.GA6728@c2.user-mode-linux.org>
References: <20070619184245.GA10567@c2.user-mode-linux.org>
	<20070619195003.GA11718@c2.user-mode-linux.org>
	<20070619131441.01b5ae4b.akpm@linux-foundation.org>
	<200706201606.58331.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200706201606.58331.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jun 20, 2007 at 04:06:58PM +0200, Blaisorblade wrote:
> Oh, it's exactly what CONFIG_DEBUG_STACK_USAGE does for i386... (not sure if 
> you were still wondering...).

Where?  The only usage in i386 that I see is thread_info.h zeroing stacks
as they are allocated.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
