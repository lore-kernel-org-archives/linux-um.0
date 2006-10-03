Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GUpLR-0006fj-6S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 11:50:21 -0700
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GUpLQ-0002xw-Cz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 11:50:21 -0700
Message-ID: <20061003185006.91302.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 3 Oct 2006 20:50:06 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20061001220727.GA5194@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/5] UML - Close file descriptor leaks
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
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sun, Oct 01, 2006 at 07:10:37PM +0200, Blaisorblade wrote:
> > NACK on the ubd driver part. It adds a bugs and does fix the one
> you found in
> > the right point. ACK on the other hunk.

I'm answering away from the code (limited Internet access) so I'll
have to look better some things. The patch has been merged, I'll care
for that in any case (avoiding conflicts with my changes as needed).

> However, neither manipulates
> dev->count (this is done by ubd_open/ubd_release) and the call to
> ubd_add_disk indirectly calls ubd_open, which, since dev->count is
> still zero redoes the initialization, leaking the descriptor and
> vmalloc space allocated by the first ubd_open_dev call.

Ah, ok. I fixed exactly this - now ubd_open_dev and ubd_close_dev are
called only through ubd_{get,put}_dev, which manage the refcount. I
did this also for other reasons - the refcount makes "close while it
is being used" impossible, so solves "mutual exclusion without
locking" (like the network layer state machine does for network
devices, this is used in general for fds; I'll write something about
this).

> The fix is simple - there is no need for ubd_add to call
> ubd_open_dev
> or ubd_close (ubd_file_size doesn't require the device be opened),

I know ubd_file_size doesn't require opening, I thought (and still
think) that call was for error checking. I'll have to re-read the
code now that I saw your point.
> so
> the calls can simply be deleted.  With the non-count-changing
> device-opening call gone, the leaks just disappear.

> There are multiple things wrong with the code, many of which are
> still
> there, but I don't see this as being an argument against this
> change.
> It eliminates some useless code, which is good from both a
> maintenance
> and performance standpoint.  However, leaks aside, the main benefit
> of
> this change is that eliminates the one call to ubd_open_dev outside
> of
> ubd_open, and thus opening stuff on the host and allocating memory
> is
> always inside a check of dev->open.

Well, this may simplify locking, so it may be interesting - I'll see.

> > I've done huge changes to the UBD driver and I'll
> > send them you briefly for your tree (they work but they're not
> yet in a 
> > perfect shape).

> OK, just make sure you preserve (or add) this property.

> > For what I can gather from your description and code, the leak
> you diagnosed 
> > is a bug in ubd_open_dev(), and is valid for any call to it: 

> No, the bug is doing the work of opening the device outside a check
> of
> the device refcount.

Ok, but the one I saw exists (in the error: label), (but I have the
patch for it).

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
