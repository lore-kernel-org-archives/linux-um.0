Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1TtyGZ-0003du-N5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 10:24:43 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TtyGW-00080f-8m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 10:24:43 +0000
Date: Sat, 12 Jan 2013 10:58:12 +0100
From: Richard Weinberger <richard@sigma-star.at>
Message-ID: <20130112105812.4eedc505@spider.haslach.nod.at>
In-Reply-To: <50F132F9.1030601@bob-the-boat.me.uk>
References: <50F132F9.1030601@bob-the-boat.me.uk>
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
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Sat, 12 Jan 2013 09:55:05 +0000
schrieb "Dave (Bob)" <dave@bob-the-boat.me.uk>:

> Maybe someone can help me with this...
> 
> I have been trying to tie down an issue that I have with "UML Network
> Related Crashing" so that Richard can reproduce my problem.
> 
> I am currently trying to use both a 32 bit UML and a 64 bit UML to run
> Debian root filesystems, 32 bit and 64 bit respectively.
> 
> I am running on a 64 bit machine, with 64 bit kernel incorporating 32
> bit compatibility.
> 
> The 32 bit environment that I am working in for the compilation of 32
> bit UML kernels and running them is a place to which I bind
> mount /dev, /sys, /proc to their primary locations; chroot to the top
> of this structure; execute 'linux32'; and then work as though I was
> on a 32 bit machine.
> 
> When I try to run the 32 bit UML kernel with the 32 bit Debian root
> filesystem image, it boots to the login prompt, but I can't type
> anything at the prompt. The UML kernel is displaying messages:
> 
> "Couldn't grant pty - errno = -2"

Please show us the full boot log.
Maybe something else failed.
 
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

