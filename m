Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQ7KM-0001oZ-CZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 11:29:30 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FQ7KK-0006li-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Apr 2006 11:29:30 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
In-Reply-To: <20060402173445.GB5108@inferi.kami.home>
Message-ID: <Pine.LNX.4.62.0604022027190.15153@pademelon.sonytel.be>
References: <20060402173445.GB5108@inferi.kami.home>
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
Date: Sun, 2 Apr 2006 20:29:12 +0200 (CEST)
To: Mattia Dongili <malattia@linux.it>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, 2 Apr 2006, Mattia Dongili wrote:
> some time ago it's been proposed to let uml_net live in /usr/lib/uml to
> comply the FHS (I have version 2.3 at hand):
> 
>   /usr/lib includes object files, libraries, and internal binaries that
>   are not intended to be executed directly by users or shell scripts.
> 
> see chapter 4.7.1
> The attached patch implements it and keeps backward compatibility.
> It's kind of brutal because putenv will wipe any user-defined PATH, if
> this is a problem I can provide an improved patch that appends
> /usr/lib/uml to the existing PATH. Is this the way to go?
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>

> --- a/arch/um/os-Linux/helper.c	2006-04-02 16:32:38.340801686 +0200
> +++ b/arch/um/os-Linux/helper.c	2006-04-02 16:34:13.454745936 +0200
> @@ -22,6 +22,9 @@ struct helper_data {
>  	int fd;
>  };
>  
> +/* PATH variable to find uml helpers  installed in FHS compliant locations */
> +static char *alt_path = "PATH=:/bin:/usr/bin:/usr/lib/uml"; 
                                 ^
Woops, this puts the current directory first in your path, which is probably
not what you want (Never bitten by people leaving evil `ls' variants in /tmp?).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
