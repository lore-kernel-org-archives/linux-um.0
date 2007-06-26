Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3HmN-00005Z-Gh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 13:36:52 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3HmL-0003MS-Gl
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 13:36:50 -0700
Date: Tue, 26 Jun 2007 13:35:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070626133550.4a607fe8.akpm@linux-foundation.org>
In-Reply-To: <20070614202655.GA9647@c2.user-mode-linux.org>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
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

On Thu, 14 Jun 2007 16:26:55 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> --- linux-2.6.21-mm.orig/arch/um/drivers/xterm.c	2007-06-13 17:13:42.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/drivers/xterm.c	2007-06-13 18:44:41.000000000 -0400
> @@ -132,7 +132,7 @@ static int xterm_open(int input, int out
>  	}
>  
>  	sprintf(title, data->title, data->device);
> -	pid = run_helper(NULL, NULL, argv, NULL);
> +	pid = run_helper(NULL, NULL, argv);
>  	if (pid < 0) {
>  		err = pid;
>  		printk(UM_KERN_ERR "xterm_open : run_helper failed, "

Something's gone wrong here.  My copy of this file has

        pid = run_helper(NULL, NULL, argv, &stack);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
