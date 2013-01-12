Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Tu3NQ-0006e6-R8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 15:52:08 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu3NG-0004yK-1S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 15:52:08 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <1556600.9mAckIm5pW@vault01>
In-Reply-To: <20130112152947.0e89203b@spider.haslach.nod.at>
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<50F1585A.8050006@nagafix.co.uk>
	<20130112152947.0e89203b@spider.haslach.nod.at>
MIME-Version: 1.0
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
Date: Sat, 12 Jan 2013 15:52:10 +0000
Subject: Re: [uml-devel] "Couldn't grant pty"
To: Richard Weinberger <richard@sigma-star.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 12 January 2013 15:29:47 Richard Weinberger wrote:
> Am Sat, 12 Jan 2013 19:34:34 +0700
> 
> schrieb Antoine Martin <antoine@nagafix.co.uk>:
> > > DEB1-32 login: get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > get_pty : Couldn't grant pty - errno = -2
> > > open_pts : Failed to open pts
> > > INIT: Id "s0" respawning too fast: disabled for 5 minutes
> > 
> > Since I made this root_fs, I guess I need to update the webpage as the
> > this one is supposed to boot ok with UML, without any tty issues.
> > 
> > Note however that I rarely use those filesystems with UML anymore, and
> > many distros have repeatedly moved/changed/broken tty initialization
> > in so many undocumented ways that I stopped caring a long time ago.
> > That said, if someone finds the solution, I'll gladly apply it.
> 
> I test most of your filesystems on UML.
> Mostly the Debian ones on both x86_64 and x86.
> 
> Bob, what exactly are you doing?
> I just did:
> 
> make defconfig ARCH=um SUBARCH=x86
> make linux ARCH=um SUBARCH=x86
> # Image from
> http://fs.devloop.org.uk/filesystems/Debian-Squeeze/Debian-Squeeze-x86-root_
> fs.bz2^C ./linux ubda=Debian-Squeeze-x86-root_fs root=/dev/ubda mem=512M
> 
> It boots like charm.
> 
> *confused*,
> //richard

Gentlemen,

I have re-tested my side, but this time running the 32 bit UML not in my 
chroot'ed 32 bit environment, but alongside the 64 bit. It works.

The difference in the boot-up log is:

Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
devtmpfs: initialized

as opposed to:

Checking for host processor cmov support...Yes
check_one_sigio failed, errno = 2
check_one_sigio failed, errno = 2
devtmpfs: initialized

Why would this be?

I will now push on and attempt to either understand why I am getting my 
'Network Related UML Crashing', or show how to reproduce it.

However, understanding why this issue with my chroot'ed 32 bit method gives 
problems would be really advantageous (educational).

The 32 bit kernel was built in the chroot'ed environment and is obviously 
linked with a 32 bit glibc. The default is not to link static, therefore I 
need the 32 bit glibc installed and working in the 64 world. If I remove the 
/lib/ld-linux.so.2 then the 32 bit kernel doesn't work (as expected). 

Regards,
David








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

