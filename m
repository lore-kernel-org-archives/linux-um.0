Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRoRx-0008RB-AW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 01:07:33 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CRoRv-0000RF-4G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Nov 2004 01:07:33 -0800
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
In-Reply-To: <34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
Message-ID: <Pine.GSO.4.61.0411101005310.17015@waterleaf.sonytel.be>
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
	<200411092012.05383.blaisorblade_spam@yahoo.it>
	<34658.80.203.1.124.1100075791.squirrel@80.203.1.124>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 10 Nov 2004 10:07:09 +0100 (MET)
To: stian@nixia.no
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?UTF-8?Q?K=EF=BF=BDhler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

On Wed, 10 Nov 2004 stian@nixia.no wrote:
> > This fact (glibc caches getpid() results) was even known because already
> > posted, and I guessed that this could happen only with TLS support.
> 
> That glibc caches getpid() has been a known issue before when people
> wanted to benchmark uml syscall speeds inside vs outside of UML using a
> simple libc-function. A clone() call can't easily invalidate caches around
> in libs that are stored in statics. But it should be mentioned on
> getpid()'s man/info page that the value might be cached.

Why? getpid() is just an API call. No one guarantees it's actually a syscall.
And IMHO caching getpid() is allowed, since the returned value won't change
anyway.

If you want to be 100% sure you use a syscall, why not call the syscall
directly?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
