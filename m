Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIC8w-0007Jb-EB	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 14:28:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIC8v-0001IP-Hr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 14:28:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Review needed for ubd fixes
Message-ID: <20050921204507.GA9918@ccure.user-mode-linux.org>
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509211749.46125.blaisorblade@yahoo.it>
	<20050921180436.GA7712@ccure.user-mode-linux.org>
	<200509212106.39169.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509212106.39169.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 16:45:07 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wed, Sep 21, 2005 at 09:06:38PM +0200, Blaisorblade wrote:
> The block layer is supposed to merge as far as possible overlapping writes, 
> that's reasonable, but not dependable. Say it gets the overlapping request 
> *after* it sent the first one - we'll see both. Also, this is trivially true 
> for output done through page cache, but for the rest I don't know if explicit 
> merging is implemented.

Yeah, I'm concerned about O_DIRECT.  Also, what happens when we write a page
to disk, and immediately afterwards, it gets dirty again and written again?
Is there a barrier between the two?

> No, I was thinking to you enforcing ordering to comply to what journaled 
> filesystems expect.

Yeah, but there's more ordering than that.

> Btw: even when we aren't using COW, we're supposed to do writes in the order 
> the fs passed them to us - at least when write barriers are explicitly sent 
> (don't know if there's something to care normally - I know this as a LWN.net 
> reader, not as an hacker in this area).

We get requests from the block layer, not the fs.  And physical disks are 
allowed to reorder requests, so I think there is some flexibility there.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
