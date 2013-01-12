Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1Tu3Vj-00076O-70
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 16:00:43 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu3Vh-0006EG-CJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 16:00:43 +0000
Date: Sat, 12 Jan 2013 17:00:02 +0100
From: Richard Weinberger <richard@sigma-star.at>
Message-ID: <20130112170002.530c4a9a@spider.haslach.nod.at>
In-Reply-To: <1556600.9mAckIm5pW@vault01>
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<50F1585A.8050006@nagafix.co.uk>
	<20130112152947.0e89203b@spider.haslach.nod.at>
	<1556600.9mAckIm5pW@vault01>
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
To: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Sat, 12 Jan 2013 16:51:52 +0100 (CET)
> The difference in the boot-up log is:
> 
> Checking for host processor cmov support...Yes
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling
> workaround devtmpfs: initialized
> 
> as opposed to:
> 
> Checking for host processor cmov support...Yes
> check_one_sigio failed, errno = 2
> check_one_sigio failed, errno = 2
> devtmpfs: initialized
> 
> Why would this be?
> 
> I will now push on and attempt to either understand why I am getting
> my 'Network Related UML Crashing', or show how to reproduce it.
> 
> However, understanding why this issue with my chroot'ed 32 bit method
> gives problems would be really advantageous (educational).
> 
> The 32 bit kernel was built in the chroot'ed environment and is
> obviously linked with a 32 bit glibc. The default is not to link
> static, therefore I need the 32 bit glibc installed and working in
> the 64 world. If I remove the /lib/ld-linux.so.2 then the 32 bit
> kernel doesn't work (as expected). 

Sounds like your chroot environment is incomplete. Maybe no /dev/
or /dev/pts/.

Thanks,
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

