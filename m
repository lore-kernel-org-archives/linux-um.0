Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uzXO-0007Jc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 12:12:58 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uzXM-0006tO-Hw
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 12:12:56 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] 2.6.0 uptime bug
In-Reply-To: <200309041706.03045.petschge@gmx.de>
Message-ID: <Pine.GSO.4.21.0309042111030.8621-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 4 Sep 2003 21:11:44 +0200 (MEST)
To: petschge@web.de
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 4 Sep 2003, Patrick Kilian wrote:
> I found a bug in the 2.6.0-test? kernels. /proc/uptime shows a uptime 
> since the start of the epoch, approx. 33 years.
> Is anybody able to reproduce this bug?

| virtual:~# uptime
| Unknown HZ value! (0) Assume 100.
|  21:10:46 up 12299 days, 19:10,  1 user,  load average: 0.84, 0.62, 0.27
| virtual:~# cat /proc/uptime 
| 1062702653.67 31.10
| virtual:~# uname -a
| Linux virtual 2.6.0-test3-1um #7 Tue Sep 2 17:07:34 CEST 2003 i686 unknown
| virtual:~# 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
