Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZeAe-0003HZ-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:50:36 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZeAd-0001Lf-66
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:50:36 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
References: <1130917338.14475.133.camel@localhost>
	<200511071832.04974.rob@landley.net>
	<200511081656.24694.blaisorblade@yahoo.it>
In-Reply-To: <200511081656.24694.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081850.26359.rob@landley.net>
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
Date: Tue, 8 Nov 2005 18:50:26 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 November 2005 09:56, Blaisorblade wrote:
> But hey, it's (now) standard practice to loopback-mount root_fs images to
> alter them. I've been using linux since less than 3 years (say RedHat 7.3
> was my first distro), though, so I can't remember about before.

Red Hat 5.something here.  (5.1?  It _hated_ my video card.  And I was already 
trying to do strange things like loopback mounting a file that lived in 
another loopback mount...)

> Which means that, when just testing the build process in itself, since you
> can create a chroot on the loopback-mount, it's perfectly ok to run it in a
> chroot on the host, for speed.

I've done that (with my build, run the sources/scripts/1.1-* script in the 
chroot environment after --bind mounting in /tools and /tools/sources).  But 
at the end of the build the packaging step makes a standalone User Mode Linux 
(with appended squashfs) to test it out, so I'll need it eventually anyway...

Of course the gcc build is still quite a memory hog without UML.  But the 
system is more graceful about dealing with it.  (Better at random memory 
pressure than random IO pressure, apparently.  It might just be that the 
anticipatory scheduler on the host system is particularly _bad_ about dealing 
with saturation level random-seek equal mixes of reads and writes scattered 
across a couplke hundred megabytes of disk space.)

I should be upgrading the host system soon, not worth pursuing this unless the 
new kernel has the same problem...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
