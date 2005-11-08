Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZW0p-0005R2-V1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:07:55 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZW0n-0006EA-Oc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:07:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511061818.30449.blaisorblade@yahoo.it>
	<200511071832.04974.rob@landley.net>
In-Reply-To: <200511071832.04974.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081656.24694.blaisorblade@yahoo.it>
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
Date: Tue, 8 Nov 2005 16:56:24 +0100
To: Rob Landley <rob@landley.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 November 2005 01:32, Rob Landley wrote:
> On Sunday 06 November 2005 11:18, Blaisorblade wrote:

> In theory the host should get this right, though.  What I really want is
> ionice, and I'm under the impression that one of the schedulers made this
> possible a few months back.  Dunno if it got merged, or what userspace
> changes I'd need...

IIRC that was exactly CFQ, but no details on this.

> > > The dd to create the file on the parent filesystem
> > > created a sparse file, which UML was happy to loopback mount because
> > > hostfs hid the sparseness of it.

> > 1) I think that loop-back mount is supposed to work on sparse files too
> > (the only thing which is refused is "swapon <sparse file>").
> > 2) How does hostfs hides that? That's interesting (as a bug, I mean).

> I mean I made a sparse file on ext2 and then ran a UML instance that hostfs
> mounted that ext2.

> If hostfs cares that the underlying filesystem is 
> sparse or compressed or whatnot, it's caring way too much about
> implementation details of the underlying filesystem. :)

No, the point is that you can loop-back mount even sparse files.

> I suppose if I used the funky block allocation range ioctl thing that LILO
> uses to figure out where kernel images live on disk, maybe it would pass it
> through.  I haven't tried.

I think it simply isn't implemented - I barely know about that (guess it's 
->bmap or ->fibmap in the fs methods). Also, there's no point in that - can 
the application, after having the block numbers, open the block device in any 
way? And obviously it's worse for LILO.

> (I vaguely recall that at one point loopback 
> mounting sparse files didn't work, but loopback mounting used to be brittle
> five years or so back.  It seems to have been cleaned up a bit since
> then...)

Ah, ok, didn't saw this part before.

But hey, it's (now) standard practice to loopback-mount root_fs images to 
alter them. I've been using linux since less than 3 years (say RedHat 7.3 was 
my first distro), though, so I can't remember about before.

Which means that, when just testing the build process in itself, since you can 
create a chroot on the loopback-mount, it's perfectly ok to run it in a 
chroot on the host, for speed. (Yep, I know, but if you need to rebuild the 
same thing over and over, and the problems are with the compilation rather 
than with UML, you can do that in the chroot). This can apply for instance 
when installing Gentoo.

Ok, ok, that's maybe too obvious to be laid out - sorry if it's so.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
