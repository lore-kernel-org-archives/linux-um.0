Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jsl83-0002Et-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 May 2008 13:48:15 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jsl82-0002lM-57
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 May 2008 13:48:15 -0700
Date: Sun, 4 May 2008 22:48:03 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <200805031518.11029.rob@landley.net>
Message-ID: <Pine.LNX.4.64.0805042247320.2615@anakin>
References: <200805031518.11029.rob@landley.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] make quiet suppress parse_chan_pair boot
	messages
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Rob Landley <rob@landley.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 3 May 2008, Rob Landley wrote:
> +	printk(KERN_WARNING "Using a channel type which is configured out of "
> +	       "UML\n");

If you would use pr_warning(), it would fit nicely on a single line.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
