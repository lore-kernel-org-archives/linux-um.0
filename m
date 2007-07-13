Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9K2L-0007CI-Id for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:14:19 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9K2J-0004gz-Tr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:14:17 -0700
Message-ID: <46976C6B.3090702@nagafix.co.uk>
Date: Fri, 13 Jul 2007 13:13:31 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <87odihsrvs.fsf@hades.wkstn.nix> <87bqehsp3x.fsf@hades.wkstn.nix>
In-Reply-To: <87bqehsp3x.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] block layer request length increases break 2.6.22.*
	COW ubd
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
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net


> Here, have a skas-v9-pre9 patch forward-ported to 2.6.22 in restitution
> of my idiocy.
>
> (The 2.6.20 patch, the most recent I could find, collided with paravirt
> and the header-inclusion reduction work. My fix to the latter is
> especially ugly, since it means that <linux/mm.h> is including
> <asm/current.h> and <linux/sched.h> again.  Probably the right fix is
> for do_mmap_pgoff() to no longer be inlined, but I'm not sure what
> performance implications that might have.)
>
>   
Thanks for that.
For those who find it difficult to extract patches from emails (like me 
on a laptop), I've copied it here:
http://uml.nagafix.co.uk/skas-2.6.22-v9-pre9.patch.bz2
(also compile tested)

Anyone fancy doing the same work to v8? I remember having severe 
problems with v9...

Antoine


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
