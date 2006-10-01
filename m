Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU9UO-0002QR-0X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 15:08:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GU9UN-0006vy-Ea
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 15:08:47 -0700
Date: Sun, 1 Oct 2006 18:07:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061001220727.GA5194@ccure.user-mode-linux.org>
References: <200609271757.k8RHvtNK005742@ccure.user-mode-linux.org>
	<200610011910.37805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610011910.37805.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 01, 2006 at 07:10:37PM +0200, Blaisorblade wrote:
> NACK on the ubd driver part. It adds a bugs and does fix the one you found in
> the right point. ACK on the other hunk.
> 
> Now, Andrew, you can ignore what follows if you want:
> 
> Jeff, please explain me the exact ubd driver bug - I believe that the open 
> must be done there, that it is balanced by ubd_close(), and that the leak fix
> should be done differently. 

The code as it was was just wrong.  There was a call to ubd_open_dev
at the start and a matching ubd_close at the end.  So far, so good,
since ubd_close inverts ubd_open_dev.  However, neither manipulates
dev->count (this is done by ubd_open/ubd_release) and the call to
ubd_add_disk indirectly calls ubd_open, which, since dev->count is
still zero redoes the initialization, leaking the descriptor and
vmalloc space allocated by the first ubd_open_dev call.

The fix is simple - there is no need for ubd_add to call ubd_open_dev
or ubd_close (ubd_file_size doesn't require the device be opened), so
the calls can simply be deleted.  With the non-count-changing
device-opening call gone, the leaks just disappear.

There are multiple things wrong with the code, many of which are still
there, but I don't see this as being an argument against this change.
It eliminates some useless code, which is good from both a maintenance
and performance standpoint.  However, leaks aside, the main benefit of
this change is that eliminates the one call to ubd_open_dev outside of
ubd_open, and thus opening stuff on the host and allocating memory is
always inside a check of dev->open.

> I've done huge changes to the UBD driver and I'll
> send them you briefly for your tree (they work but they're not yet in a 
> perfect shape).

OK, just make sure you preserve (or add) this property.

> For what I can gather from your description and code, the leak you diagnosed 
> is a bug in ubd_open_dev(), and is valid for any call to it: 

No, the bug is doing the work of opening the device outside a check of
the device refcount.

> generally, if an
> _open function fails it should leave nothing to cleanup, and in particular 
> the corresponding _close should not be called (this is the implicit standard 
> I've seen in Linux). 

This is true - however the _open function was succeeding, so it's
irrelevant in this case.

> Btw, ubd_open_dev() and ubd_close() are matching functions, while ubd_close()
> does not match ubd_open(), so I renamed ubd_close -> ubd_close_dev.

Yes, this is one of the things wrong with the current code - the names
are messed up.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
