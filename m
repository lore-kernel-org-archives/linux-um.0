Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMk5X-00061F-3A	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:31:59 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMk5V-0007Zo-Da
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:31:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] ubd and write barriers
References: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
In-Reply-To: <HDubM/jULNDp.FiIUPkbI/sUT/mvVu1/2/A@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041231.56985.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 12:31:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Lightfoot <chris@ex-parrot.com>, Jeff Dike <jdike@addtoit.com>

On Tuesday 04 October 2005 11:31, Chris Lightfoot wrote:
> The current ubd implementation doesn't support write
> barriers (blk_queue_ordered etc.), and the reccomendation
> is to use synchronous IO to ensure data integrity. In
> principle, adding barrier request support ought to get
> around this problem, allowing writes without O_SYNC with
> occasional calls to fdatasync on the underlying data (the
> motivation for write barrier support was safety of
> journalling filesystems on disks with write caches, an
> analogous problem).
Yes, I more or less remembered that was the idea (from readings on lwn.net), 
thanks for confirming it.
> ext3 and reiserfs support the write barrier stuff if
> mounted with appropriate options (barrier=1 and
> barrier=flush respectively).
So they don't auto-enable this when support exists? I.e. everybody is running 
slower just because we don't add those params?
> Implementing this ought to give performance somewhere
> between ubdXs and ubdX, but with adequate guarantees of
> data integrity for use with modern filesystems. That said,
> I haven't measured this yet.

> A patch for this is pretty simple (see below). Has there
> been discussion of this before? I couldn't find any in the
> list archives....
This was discussed between me and Jeff recently, even if maybe that was 
off-list.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
