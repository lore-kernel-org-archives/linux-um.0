Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Tu4Wf-0001MH-K9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 17:05:45 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu4WU-0003jw-Dy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 17:05:45 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <3776844.6K58P5x2hc@vault01>
In-Reply-To: <20130112170002.530c4a9a@spider.haslach.nod.at>
References: <50F132F9.1030601@bob-the-boat.me.uk> <1556600.9mAckIm5pW@vault01>
	<20130112170002.530c4a9a@spider.haslach.nod.at>
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
Date: Sat, 12 Jan 2013 17:05:46 +0000
Subject: Re: [uml-devel] "Couldn't grant pty"
To: Richard Weinberger <richard@sigma-star.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 12 January 2013 17:00:02 Richard Weinberger wrote:
> Am Sat, 12 Jan 2013 16:51:52 +0100 (CET)
> 
> > The difference in the boot-up log is:
> > 
> > Checking for host processor cmov support...Yes
> > Checking that host ptys support output SIGIO...Yes
> > Checking that host ptys support SIGIO on close...No, enabling
> > workaround devtmpfs: initialized
> > 
> > as opposed to:
> > 
> > Checking for host processor cmov support...Yes
> > check_one_sigio failed, errno = 2
> > check_one_sigio failed, errno = 2
> > devtmpfs: initialized
> > 
> > Why would this be?
> > 
> > I will now push on and attempt to either understand why I am getting
> > my 'Network Related UML Crashing', or show how to reproduce it.
> > 
> > However, understanding why this issue with my chroot'ed 32 bit method
> > gives problems would be really advantageous (educational).
> > 
> > The 32 bit kernel was built in the chroot'ed environment and is
> > obviously linked with a 32 bit glibc. The default is not to link
> > static, therefore I need the 32 bit glibc installed and working in
> > the 64 world. If I remove the /lib/ld-linux.so.2 then the 32 bit
> > kernel doesn't work (as expected).
> 
> Sounds like your chroot environment is incomplete. Maybe no /dev/
> or /dev/pts/.
> 
> Thanks,
> //richard

Richard,

In the 64 bit environment (with additional 32 bit glibc) that works, I do:
(/uml_test is a mount point for a filesystem)

mount --bind /dev /<path_to_32_bit_stuff>/dev
mount --bind /proc /<path_to_32_bit_stuff>/proc
mount --bind /sys /<path_to_32_bit_stuff>/sys
mount --bind /uml_test <path_to_32_bit_stuff>/uml_test
chroot <path_to_32_bit_stuff>
linux32
cd /uml_test/DEB1-32
./startup

Or, I do:

cd /uml_test/DEB1-32
./startup


So the actual thing that is running, and the dev, sys, and proc filesystems, 
are all identical for the two situations.

If the reason for this isn't clear to those more knowledgeable than I, then I 
am encouraged to investigate when I have my other problems out of the way.

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

