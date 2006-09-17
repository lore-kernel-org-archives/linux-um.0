Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GP16U-00022I-9L for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Sep 2006 11:10:54 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GP16Q-0004IK-LJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Sep 2006 11:10:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 17 Sep 2006 20:10:13 +0200
References: <20060829083009.95142.qmail@web25224.mail.ukl.yahoo.com>
	<20060912170841.GA7980@ccure.user-mode-linux.org>
In-Reply-To: <20060912170841.GA7980@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609172010.13315.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using -fcombine for UML
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
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tuesday 12 September 2006 19:08, Jeff Dike wrote:
> On Tue, Aug 29, 2006 at 10:30:09AM +0200, Paolo Giarrusso wrote:
> > Look there, it would be very useful IMHO for UML:
> >
> > http://lkml.org/lkml/2006/8/24/212
>
> Yeah, looks interesting, but a bunch of work.  When you build a directory
> at a time,
I was thinking by thematic areas - for instance each _user with its _kern 
(there are still some such examples). Having little wrappers inlined 
(especially for some ones in the hot paths, I'm recalling something about mm 
fault handling or such) would help however, and could be prioritized.
> everything that is exposed to the outside needs to be declared 
> __global.

> This is useful documentation in its own right, but it will take some time
> to do.
Obviously...
> 				Jeff

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
