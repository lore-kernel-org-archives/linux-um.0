Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIY3j-0003Iu-Jq	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:52:47 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIY3h-0006k5-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:52:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509212106.39169.blaisorblade@yahoo.it>
	<20050921204507.GA9918@ccure.user-mode-linux.org>
In-Reply-To: <20050921204507.GA9918@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509222251.31918.blaisorblade@yahoo.it>
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
Date: Thu, 22 Sep 2005 22:51:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 21 September 2005 22:45, Jeff Dike wrote:
> On Wed, Sep 21, 2005 at 09:06:38PM +0200, Blaisorblade wrote:
> > The block layer is supposed to merge as far as possible overlapping
> > writes, that's reasonable, but not dependable. Say it gets the
> > overlapping request *after* it sent the first one - we'll see both. Also,
> > this is trivially true for output done through page cache, but for the
> > rest I don't know if explicit merging is implemented.
>
> Yeah, I'm concerned about O_DIRECT.  Also, what happens when we write a
> page to disk, and immediately afterwards, it gets dirty again and written
> again? Is there a barrier between the two?
>
> > No, I was thinking to you enforcing ordering to comply to what journaled
> > filesystems expect.
>
> Yeah, but there's more ordering than that.
>
> > Btw: even when we aren't using COW, we're supposed to do writes in the
> > order the fs passed them to us - at least when write barriers are
> > explicitly sent (don't know if there's something to care normally - I
> > know this as a LWN.net reader, not as an hacker in this area).
>
> We get requests from the block layer, not the fs.  And physical disks are
> allowed to reorder requests, so I think there is some flexibility there.
I expect the FS to send the barriers - they don't make sense otherwise.

In fact, grep -i barrier fs/jbd/*.c gives some results, which point to 
BH_Ordered.

And after grepping it in reiserfs, I found that fs/buffer.c:submit_bh() cares 
about it (i.e. looks at the buffer head and sees if it is ordered), and sends 
it down to the elevator.
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
