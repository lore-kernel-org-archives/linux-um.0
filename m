Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwHsZ-0000xq-KZ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 06:18:19 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HwHsY-0002MX-52
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 06:18:19 -0700
Date: Thu, 7 Jun 2007 09:09:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070607130912.GA5408@c2.user-mode-linux.org>
References: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
Subject: Re: [uml-devel] Building a UML uClinux(Busybox/uClibc) filesystem
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
To: Andrew Sinclair <Andrew.Sinclair@elprotech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 07, 2007 at 05:57:19PM +1000, Andrew Sinclair wrote:
> Unfortunately, when trying to generate my own filesystem, my kernel no
> longer works. It basically stops after mounting the filesystem. 
> 
> When I try and use gdb to debug I get stuck in
> arch/um/include/um_uaccess.h:50
> 
> static inline int copy_to_user(void __user *to, const void *from, int n)
> {
>         return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
>                                 from, n));
> }

I'm guessing gdb is stopping because it sees a segfault there:

(gdb) handle SIGSEGV pass nostop noprint

Segfaults within UML are normal, and gdb should just ignore them.

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
