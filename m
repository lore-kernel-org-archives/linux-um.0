Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gu4GU-0006cM-LK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 01:49:34 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gu4GT-00022G-9E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 01:49:34 -0800
Date: Tue, 12 Dec 2006 10:49:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <0A01463223B8164194908CAC85B66A12012D2AB8@ZMY16EXM67.ds.mot.com>
Message-ID: <Pine.LNX.4.62.0612121048340.20902@pademelon.sonytel.be>
References: <0A01463223B8164194908CAC85B66A12012D2AB8@ZMY16EXM67.ds.mot.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Regarding getpid
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
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 12 Dec 2006, Krishnappa Abhijith-A21204 wrote:
>             "Process system calls must be nullified in the host, and
> this is done by converting them into getpid. "
> How is system calls  are nullified by converting them to getpid() ?

Instead of calling the actual system call, it just calls getpid(). I.e. the
actual system call is not executed, and getpid() is more or less a NOP.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
