Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzKkA-0004rJ-6O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 12:16:54 -0800
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzKk6-00077Q-QI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 12:16:54 -0800
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [uml-devel] Re: uml kbuild cleanup (cross-build) - some fixes and
	comments
Message-ID: <20050210201646.GE8859@parcelfarce.linux.theplanet.co.uk>
References: <200502101939.23300.blaisorblade@yahoo.it>
	<20050210190412.GC8859@parcelfarce.linux.theplanet.co.uk>
	<200502102016.52209.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502102016.52209.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 20:16:46 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Thu, Feb 10, 2005 at 08:16:52PM +0100, Blaisorblade wrote:
> On Thursday 10 February 2005 20:04, Al Viro wrote:
> > On Thu, Feb 10, 2005 at 07:39:23PM +0100, Blaisorblade wrote:
> > > 3) I don't understand how vmlinux.lds.S is created... it's a symlink, but
> > > it's created nowhere after the patch - maybe I overlook something, maybe
> > > you didn't do "make clean" and retest.
> 
> > Not a symlink anymore.  It's right there in the patch -
> Nice trick.
> In this case, it got lost in the version at that URL (I don't know whose is 
> the fault). I triple-checked that the file is missing at that URL.
> 
> Btw, did you also fix the typo I mentioned?

See another reply upthread.  BTW, patch is going to be split - right now
it's a big lump of unrelated fixes.  I'm waiting for Sam to return with
comments on headers layout...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
