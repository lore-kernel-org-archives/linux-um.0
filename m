Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzJpH-0001S0-2F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:18:07 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzJpC-00008g-Bv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 11:18:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: uml kbuild cleanup (cross-build) - some fixes and
	comments
References: <200502101939.23300.blaisorblade@yahoo.it>
	<20050210190412.GC8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050210190412.GC8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502102016.52209.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 20:16:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>

On Thursday 10 February 2005 20:04, Al Viro wrote:
> On Thu, Feb 10, 2005 at 07:39:23PM +0100, Blaisorblade wrote:
> > 3) I don't understand how vmlinux.lds.S is created... it's a symlink, but
> > it's created nowhere after the patch - maybe I overlook something, maybe
> > you didn't do "make clean" and retest.

> Not a symlink anymore.  It's right there in the patch -
Nice trick.
In this case, it got lost in the version at that URL (I don't know whose is 
the fault). I triple-checked that the file is missing at that URL.

Btw, did you also fix the typo I mentioned?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
