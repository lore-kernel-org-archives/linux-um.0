Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7DDm-00053D-FJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 08:01:06 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H7DDk-0002k2-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 08:01:06 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 17 Jan 2007 17:00:37 +0100
References: <3cb76b010701160511i1ff30a49k467fc1f4d5887c94@mail.gmail.com>
In-Reply-To: <3cb76b010701160511i1ff30a49k467fc1f4d5887c94@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701171700.37908.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] FC4 rootfs - crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sapan Bhatia <sapan.bhatia@gmail.com>

On Tuesday 16 January 2007 14:11, Sapan Bhatia wrote:
> Hi,
>
> I'm using UML 2.6.19.2 on a 2.6.19-skas3 host, and observing the following
> when I try booting with a root fs based on FC4/glibc- 2.6-20. UML gets
> stuck with a 'Warning: unable to open an initial console'. gdb shows that
> it's because it gets a stream of infinite segfaults. When I boot off
> another rootfs and try to chroot into the one with FC4, it segfaults out.
> strace shows that this happens just after libc is ldopened.. at a call to
> rt_sigprocmask.

Which is the other root_fs? Slackware is way stablere than anything else, 
since I guess they are much more conservative when building glibc.

> So I tried regressing glibc, and now (with glibc-2.6.3) chroot works, but
> UML still gets stuck at the same place when I try to boot.

You mean glibc-2.3.6?
Can an older UML version boot fine on that root_fs? No definitive 
incompatibility with FC4 exists that I know of.

However, there is a similar problem with _host_ glibc >= 2.4. Is this your 
case?

> Sapan

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
