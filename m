Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1Tu263-0003hA-K0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 14:30:07 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu25w-0000f5-Ss
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 14:30:07 +0000
Date: Sat, 12 Jan 2013 15:29:47 +0100
From: Richard Weinberger <richard@sigma-star.at>
Message-ID: <20130112152947.0e89203b@spider.haslach.nod.at>
In-Reply-To: <50F1585A.8050006@nagafix.co.uk>
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<20130112105812.4eedc505@spider.haslach.nod.at>
	<1394921.l9eX0xA5nn@vault01> <50F1585A.8050006@nagafix.co.uk>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] "Couldn't grant pty"
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Sat, 12 Jan 2013 19:34:34 +0700
schrieb Antoine Martin <antoine@nagafix.co.uk>:

> > DEB1-32 login: get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > get_pty : Couldn't grant pty - errno = -2
> > open_pts : Failed to open pts
> > INIT: Id "s0" respawning too fast: disabled for 5 minutes
> Since I made this root_fs, I guess I need to update the webpage as the
> this one is supposed to boot ok with UML, without any tty issues.
> 
> Note however that I rarely use those filesystems with UML anymore, and
> many distros have repeatedly moved/changed/broken tty initialization
> in so many undocumented ways that I stopped caring a long time ago.
> That said, if someone finds the solution, I'll gladly apply it.

I test most of your filesystems on UML.
Mostly the Debian ones on both x86_64 and x86.

Bob, what exactly are you doing?
I just did:

make defconfig ARCH=um SUBARCH=x86
make linux ARCH=um SUBARCH=x86
# Image from
http://fs.devloop.org.uk/filesystems/Debian-Squeeze/Debian-Squeeze-x86-root_fs.bz2^C ./linux
ubda=Debian-Squeeze-x86-root_fs root=/dev/ubda mem=512M

It boots like charm.

*confused*,
//richard

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122912
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

