Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ9t1-0000Bh-SL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:36:39 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CQ9t0-00075N-Sa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:36:39 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Synchronization primitives in UML (was: Re: [uml-devel] Re: [patch
	09/20] uml: use SIG_IGN for empty sighandler)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052036.55541.blaisorblade_spam@yahoo.it>
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
Date: Fri, 5 Nov 2004 20:36:55 +0100
To: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, cw@f00f.org

On Friday 05 November 2004 06:48, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > I had a doubt on this, but I was not getting much feedback from you...

> Yeah, sorry.
Jeff, please read this one - I have a number of important things in it. Also, 
I'd like comments from everyone else interested.

I can understand you, so I'll try to reduce my mails to you to increase the 
signal/noise ratio.

I'll still send what needed to the list, but CC you just when requesting your 
attention (not for trivial fixlet, yes for things as this one, which smelt 
like being an hack done on purpose).

> > Also, if you reject this, I'd require a comment-only patch for it: "as
> > soon as I remember why" makes me think back to my yesterday's class,
> > when  the teacher said "put comments in your code or you'll soon
> > forget what it  does!" 8-O (yes, 1st year University student :-( ).

> The thing is, you often don't realize what's going to be mysterious until
> it actually is, and then it's too late for the comment :-)

> In this case, it wants to be bounced out
You mean it failing with EINTR, right?
> of sigprocmask when a SIGWINCH 
> arrives.
Also, why shouldn't sigprocmask be restartable with the -ERESTART* mechanism? 
Wouldn't your kludge break?

Also, a nicer way to code this could be to have an explicit sighandler setting 
a flag (to get the syscall interrupted if the signal arrives before being 
blocked) and to call sigpending() (to test if the signal arrived just after 
setting it). After the syscall, that could become SIG_IGN.

Also, (optional answer), why is this needed? A comment about such issues would 
be better than an answer email.

> In order to do so, it must have a handler registered, even if 
> it does nothing.

Ok. However, I have a general question about all this whole code: why do you 
use pipes as synchronization primitives? Did you avoid semaphores for 
portability issues, or for persistency ones? Both can be solved (with the os_ 
layer and the IPC_PRIVATE key).

This would especially help during context switching, I think. I have just a 
rough idea of what switch_pipe is for, but calling the network layer (what 
you call os_pipe() is actually socketpair(), which is very confusing) to rely 
on the semaphores / wait queues it uses seems suboptimal and ugly.

What are your ideas about this?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
