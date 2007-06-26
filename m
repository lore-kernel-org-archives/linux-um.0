Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3JCc-0000vE-Hy for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 15:08:02 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3JCc-0004Wj-54
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 15:08:02 -0700
Date: Tue, 26 Jun 2007 15:07:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070626150747.5110e614.akpm@linux-foundation.org>
In-Reply-To: <20070626215328.GA23077@c2.user-mode-linux.org>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
	<20070626133550.4a607fe8.akpm@linux-foundation.org>
	<20070626215328.GA23077@c2.user-mode-linux.org>
Mime-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 26 Jun 2007 17:53:28 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> On Tue, Jun 26, 2007 at 01:35:50PM -0700, Andrew Morton wrote:
> > >  	sprintf(title, data->title, data->device);
> > > -	pid = run_helper(NULL, NULL, argv, NULL);
> > > +	pid = run_helper(NULL, NULL, argv);
> > >  	if (pid < 0) {
> > >  		err = pid;
> > >  		printk(UM_KERN_ERR "xterm_open : run_helper failed, "
> > 
> > Something's gone wrong here.  My copy of this file has
> > 
> >         pid = run_helper(NULL, NULL, argv, &stack);
> 
> Looks like you're applying patches out of order.

Yes, I am.  After a few days off and a few more days being lazy I have
600-odd patches (and followups thereto) to process.

- If I do them in-order, I merge stuff which is out of date or wrong

- If I do them in reverse-order, I can miss dependencies.

On balance, reverse-order seems to be better.

>  This is from the
> 14th, while a patch from the 13th ("UML - xterm driver tidying") has
> -       pid = run_helper(NULL, NULL, argv, &stack);
> 	...
> +       pid = run_helper(NULL, NULL, argv, NULL);
> 
> If you don't want to fiddle with this, just drop it and I'll rediff
> against the next -mm and resend.

I sorted it out, thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
