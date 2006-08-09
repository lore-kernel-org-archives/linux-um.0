Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GApJ0-0004sJ-Q1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 07:45:10 -0700
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GApIx-0000Ja-UX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 07:45:10 -0700
Message-ID: <20060809144459.58896.qmail@web25222.mail.ukl.yahoo.com>
Date: Wed, 9 Aug 2006 16:44:59 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060808200231.GA6463@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/3] uml: fix proc-vs-interrupt context
	spinlock deadlock
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
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Tue, Aug 08, 2006 at 12:59:05PM +0200, Paolo Giarrusso wrote:
> > I could be wrong, but I trust that thanks to deep and good work
> by
> > who designed locking in the network layer, this patch is correct.
> And
> > indeed I addressed your issues below.
> 
> OK, but there will need to be comments explaining why it is OK that
> this data only looks half-locked.

Guess I'll put it in Documentation and reference it.

> The locking, as it stands, looks consistent and conservative.
Yes, it is.
> However, there are some places where critical sections are too big
> and
> the locking should be narrowed.

Yes, in particular we cannot hold a spinlock for the whole _open
since it must call sleeping functions. 

> > This is also true of char/block devices (you don't need to lock
> > against write/read in open/close; UBD doesn't know that but I
> have
> > unfinished patches for it), but there it's simpler: if userspace
> you
> > call close while a read is executing, thanks to refcounting
> (sys_read
> > does fget) the ->close (or ->release) is only called after the
> end of
> > ->read.
> 
> In my current patchset, there is a per-queue lock which is mostly
> managed by the block layer.

I'll try then to finish the patches soon and merge them; the main
problem is splitting (including the use of different locks) normal
locking from our peculiar locking of _open/_close against mconsole
changes.


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
