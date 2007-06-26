Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3Iyg-0007zs-WD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 14:53:39 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3Iyg-0000Qy-6j
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 14:53:38 -0700
Date: Tue, 26 Jun 2007 17:53:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070626215328.GA23077@c2.user-mode-linux.org>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
	<20070626133550.4a607fe8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070626133550.4a607fe8.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Simplify helper stack handling
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jun 26, 2007 at 01:35:50PM -0700, Andrew Morton wrote:
> >  	sprintf(title, data->title, data->device);
> > -	pid = run_helper(NULL, NULL, argv, NULL);
> > +	pid = run_helper(NULL, NULL, argv);
> >  	if (pid < 0) {
> >  		err = pid;
> >  		printk(UM_KERN_ERR "xterm_open : run_helper failed, "
> 
> Something's gone wrong here.  My copy of this file has
> 
>         pid = run_helper(NULL, NULL, argv, &stack);

Looks like you're applying patches out of order.  This is from the
14th, while a patch from the 13th ("UML - xterm driver tidying") has
-       pid = run_helper(NULL, NULL, argv, &stack);
	...
+       pid = run_helper(NULL, NULL, argv, NULL);

If you don't want to fiddle with this, just drop it and I'll rediff
against the next -mm and resend.

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
