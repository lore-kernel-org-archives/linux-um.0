Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI9wq-000819-Hc	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 12:08:04 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EI9wl-0000Zi-I6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 12:08:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509211749.46125.blaisorblade@yahoo.it>
	<20050921180436.GA7712@ccure.user-mode-linux.org>
In-Reply-To: <20050921180436.GA7712@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509212106.39169.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 21:06:38 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 21 September 2005 20:04, Jeff Dike wrote:
> On Wed, Sep 21, 2005 at 05:49:43PM +0200, Blaisorblade wrote:
[...]
> > Don't think it's reasonable to expect this. I think that filesystems like
> > ext2 will never produce write barriers - they are needed for journaled
> > FS's.

> I thought your point was to rely on the block layer to order overlapping
> writes for us.
The block layer is supposed to merge as far as possible overlapping writes, 
that's reasonable, but not dependable. Say it gets the overlapping request 
*after* it sent the first one - we'll see both. Also, this is trivially true 
for output done through page cache, but for the rest I don't know if explicit 
merging is implemented.

For the buffer cache (i.e. fs metadata) it may still hold, but I'm not sure at 
all. Not that it matters for us - we can't depend on it anyway.

No, I was thinking to you enforcing ordering to comply to what journaled 
filesystems expect.

Btw: even when we aren't using COW, we're supposed to do writes in the order 
the fs passed them to us - at least when write barriers are explicitly sent 
(don't know if there's something to care normally - I know this as a LWN.net 
reader, not as an hacker in this area).

> It sounded reasonable to me :-)

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
