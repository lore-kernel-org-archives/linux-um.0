Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GGvOU-0007dH-DB for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 03:28:02 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GGvOP-0000uK-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 03:28:02 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 26 Aug 2006 12:27:39 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261227.39263.blaisorblade@yahoo.it>
Subject: [uml-devel] UniProcessor UML running on SMP host: things to care
	about in the code
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
Cc: user-mode-linux-devel@lists.sourceforge.net

I was thinking to some possible (theoretical?) troubles which could happen 
with UML running on a SMP host - they're due to the code assuming it is 
running on an UP machine.

1) Over the host we use pipes as synchronization mechanism. Who on the heart 
assures the "memory barrier" guarantees a lock needs to satisfy? Is it just 
that i386 is so nice? And anyway, are i386 guarantees enough for the existing 
code to be safe? Or does the code use them as a simple (slow) wakeup 
mechanism without memory guarantees?

2) (luckily a non-problem) atomic_t definition: we use i386 code, which can 
take for granted that if CONFIG_SMP is off it does not need memory barriers 
and so on (in particular, LOCK_PREFIX is null).

With CONFIG_SMP off, if two different UML kernel threads could run on 
different CPUs things would break, however this cannot happen (and when the 
kernel migrates UML that must be trasparent to the user, so it is still ok).

However this is to keep in mind when having different host thread running.

*) Is there any other case to warn about?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
