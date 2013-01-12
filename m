Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antoine@nagafix.co.uk>) id 1Tu0Y3-0002uf-WB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 12:50:56 +0000
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tu0Y1-00085l-GV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 12:50:55 +0000
Received: (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTPSA id 9B082667A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Jan 2013 12:34:36 +0000 (GMT)
Message-ID: <50F1585A.8050006@nagafix.co.uk>
Date: Sat, 12 Jan 2013 19:34:34 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<20130112105812.4eedc505@spider.haslach.nod.at>
	<1394921.l9eX0xA5nn@vault01>
In-Reply-To: <1394921.l9eX0xA5nn@vault01>
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
To: user-mode-linux-devel@lists.sourceforge.net

> DEB1-32 login: get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> get_pty : Couldn't grant pty - errno = -2
> open_pts : Failed to open pts
> INIT: Id "s0" respawning too fast: disabled for 5 minutes
Since I made this root_fs, I guess I need to update the webpage as the
this one is supposed to boot ok with UML, without any tty issues.

Note however that I rarely use those filesystems with UML anymore, and
many distros have repeatedly moved/changed/broken tty initialization in
so many undocumented ways that I stopped caring a long time ago.
That said, if someone finds the solution, I'll gladly apply it.

Cheers
Antoine

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

