Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] AMD or Intel for host
In-Reply-To: <045f01c43ffc$418302f0$2000000a@schlepptopp>
Message-ID: <Pine.GSO.4.58.0405231120280.2027@waterleaf.sonytel.be>
References: <40AF3E70.3000205@almahdi.cc>
	<045f01c43ffc$418302f0$2000000a@schlepptopp>
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
Date: Sun, 23 May 2004 11:22:11 +0200 (MEST)
To: roland <for_spam@gmx.de>
Cc: Ali Almahdi <ali@almahdi.cc>, user-mode-linux-user@lists.sourceforge.net, User Mode Linux Devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 22 May 2004, roland wrote:
> not easy to tell, if xp 2800+ or P4 2.8 is better for uml
>
> but maybe:
> http://www6.tomshardware.com/cpu/20021001/index.html
> helps to find a decision.
>
> this is another comparison i found on the net:
>
> Intel Pentium 4 2.8GHz
> SPECint: 1010
> SPECfp: 947
>
> AMD Athlon XP 2800+ (2.25GHz)
> SPECint: 933
> SPECfp: 843

That must be an old XP 2800+, since the new ones (Barton core) run at 2083 MHz.
SPEC numbers may have changed, since Barton has 512 KiB L2 cache.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
