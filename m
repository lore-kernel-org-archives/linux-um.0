Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJd0m-0002BI-Fv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 12:17:40 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJd0l-0006WE-Jx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 12:17:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <4173F1FD.6080004@colitti.com> <87d5zgrkm2.fsf@bytesex.org>
In-Reply-To: <87d5zgrkm2.fsf@bytesex.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410182118.09005.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Host processes never terminate on 2.6.9rc3
	host (stuck in ptrace_stop)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 18 Oct 2004 21:18:08 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

On Monday 18 October 2004 19:39, Gerd Knorr wrote:
> Lorenzo Colitti <lorenzo@colitti.com> writes:
> > Using a 2.6.8.1 UML kernel on a 2.6.9-rc3 host in tt mode, my "linux"
> > processes on the host hang around forever, even if I shut the virtual
> > machine down with halt.

> > P.S. Might this be due to a change to ptrace committed in 2.6.9rc1?
> > There's something about ptrace_stop in this changelog:
> > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/old/patch-2.6.9-rc1
> >-bk16.log

> Yes, I see that as well, it actually *is* that ptrace change added in
> patch-2.6.9-rc1-bk16.

> IMHO it is a bug, I've reported it to lkml a 
> few days ago, no response yet.

Oh well, did I lost it or you did not CC the UML mailing list? And in the 2nd 
case, why? I'm downloading the patches from BitKeeper. This are the links 
(not guaranted to work, I should have used "bookmarkable link" but I may have 
missed some ones):

http://linux.bkbits.net:8080/linux-2.5/cset@413f1c0bviEp6fHuuZpUWED2M7lWWA?nav=index.html|
tags|ChangeSet@..1.1867
http://linux.bkbits.net:8080/linux-2.5/cset@413f1c00MHeKsQfqBGA5McsDQ71Rmg?nav=index.html|
tags|ChangeSet@..1.1867
http://linux.bkbits.net:8080/linux-2.5/cset@413f1bdabfaQNzIZpU6bPxNlSxdriQ?nav=index.html|
tags|ChangeSet@..1.1867
http://linux.bkbits.net:8080/linux-2.5/cset@413f1be9vIHHLGwHUvcNtaZDwKSuig?nav=index.html|
tags|ChangeSet@..1.1867

There is one patch in particular mentioning ptrace_stop, but the other ones 
are related to it, too (except the one about strace catching even invalid 
syscalls).

> Problem is that you can't kill -9 processes any more which are ptraced
> _and_ stopped at the same time.
Sorry, tried kill -CONT? I'm almost sure it works (tried by both Henrik 
Normstrod and me, not in this case).

> skas mode isn't hit that badly by the bug, it "only" hangs on
> shutdown/reboot.


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
