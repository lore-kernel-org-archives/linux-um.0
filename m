Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GicTI-0003fZ-GK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 11:55:28 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GicTE-0000gm-Nx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 11:55:28 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 10 Nov 2006 20:54:53 +0100
References: <8764elbcrj.fsf@glaurung.internal.golden-gryphon.com>
	<200610311225.16874.blaisorblade@yahoo.it>
	<20061031211155.GA6824@ccure.user-mode-linux.org>
In-Reply-To: <20061031211155.GA6824@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611102054.54094.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Pkg-uml-devel] Re: [Pkg-uml-pkgs] Bug#393263:
	uml-utilities: New version uml_utilities_20060622 has humsify,
	please update
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
Cc: Pkg-UML developers <pkg-uml-devel@lists.alioth.debian.org>, 393263@bugs.debian.org, stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 31 October 2006 22:11, Jeff Dike wrote:
> > About this, I'd have one question to pose to Jeff: when are you going to
> > include humfs in mainline? Last time I asked you this you said "ok", so I
> > can guess you'll send for next cycle (2.6.20). Is that right?
>
> Yeah, I was going to do it a couple of weeks ago, but then I decided to
> bang on it a bit.  I fixed the inode refcount bugs that turned up, but you
> still get still some interesting link counts when removing directories.
>
> See the gory details in yesterday's diary entry.

Compliments for your work on this, I'm favourably impressed by this 
improvements - I would also gather they apply to all externfs, i.e. both to 
new hostfs and humfs?

That would be exceptionally good, however even humfs alone would be already 
good for merging. And an earlier trip in -mm might help if somebody takes a 
look at it (Al Viro did review our fs work in the past so he might decide to 
give a look here too).
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
