Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1Tu9EM-0006nx-Ld
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 22:07:10 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tu9EI-0007S7-L3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 22:07:10 +0000
Date: Sat, 12 Jan 2013 23:06:54 +0100
From: Richard Weinberger <richard@sigma-star.at>
Message-ID: <20130112230654.4462c938@spider.haslach.nod.at>
In-Reply-To: <3776844.6K58P5x2hc@vault01>
References: <50F132F9.1030601@bob-the-boat.me.uk> <1556600.9mAckIm5pW@vault01>
	<20130112170002.530c4a9a@spider.haslach.nod.at>
	<3776844.6K58P5x2hc@vault01>
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

Am Sat, 12 Jan 2013 18:05:28 +0100 (CET)
schrieb "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>:
> 
> Richard,
> 
> In the 64 bit environment (with additional 32 bit glibc) that works,
> I do: (/uml_test is a mount point for a filesystem)
> 
> mount --bind /dev /<path_to_32_bit_stuff>/dev
> mount --bind /proc /<path_to_32_bit_stuff>/proc
> mount --bind /sys /<path_to_32_bit_stuff>/sys
> mount --bind /uml_test <path_to_32_bit_stuff>/uml_test

What about /dev/pts?
Why the chroot anyways?

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

