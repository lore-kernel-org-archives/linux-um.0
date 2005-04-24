Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPm8A-00064R-BJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:46:58 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DPm89-0000Np-Ml for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 11:46:58 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504241644.38016.blaisorblade@yahoo.it>
	<20050424165112.GA4598@ccure.user-mode-linux.org>
In-Reply-To: <20050424165112.GA4598@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504242044.04625.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
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
Date: Sun, 24 Apr 2005 20:44:04 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Sunday 24 April 2005 18:51, Jeff Dike wrote:
> On Sun, Apr 24, 2005 at 04:44:37PM +0200, Blaisorblade wrote:
> > Btw, many of the code movement things are just cut'n'paste things, so for
> > them there is no reason to delay them. Now we are going to merge them for
> > 2.6.13-rc1 (for .12 it's too late), but every other delay increases the
> > possibility that we fix somehow the code we are moving and forget to do
> > the same on the moved code.

> Yeah, that's a concern.  I'm holding onto the code movement because I want
> to look at the os interface that resulted from it, and see if it can be
> cleaned up.
Happy for that.

> > Finally, about the syscall table patches for s390: I'm going to merge
> > into -mm the syscall table patches you can find in the last -devel
> > snapshot I put on my page (the uploaded ones maybe are out-of-date, but
> > I'll cc you on patches).

> What patch is this?  All I see is a patch which makes some small fixes to
> the sys_call_table.
No, I don't mean -bs, I mean the DEVEL snapshot. It's under 
patches/devel-guest/, and other will follow (when I have broad-band).

However the updated patches are flying to you (plural, since they also relate 
with s390 port).

> > They entirely remove the UML syscall table to replace it with the
> > $(SUBARCH) one (there is some hand-work to do for each subarch but it's
> > much less than before). While doing this I also fixed various little bugs
> > about this subject.
>
> Don't send that anywhere until I've seen it.  Your description of it makes
> me nervous.
I'm sending it for -mm only, and it's marked as such. Also it won't silently 
slip since it acts a bit on i386.

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
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
