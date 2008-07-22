Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLFmF-0004DM-6h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 04:11:31 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KLFmB-0006CD-Gb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 04:11:31 -0700
Date: Tue, 22 Jul 2008 11:53:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20080722115354.79ba2314@lxorguk.ukuu.org.uk>
In-Reply-To: <20080722105812.GB5283@alice>
References: <20080722105812.GB5283@alice>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] um: fix a build error
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
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: xiyou.wangcong@gmail.com, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6/arch/um/drivers/line.c.orig	2008-07-22 12:06:17.000000000 +0200
> +++ linux-2.6/arch/um/drivers/line.c	2008-07-22 12:06:49.000000000 +0200
> @@ -362,10 +362,8 @@ static irqreturn_t line_write_interrupt(
>  	if (tty == NULL)
>  		return IRQ_NONE;
>  
> -	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
> -	   (tty->ldisc.write_wakeup != NULL))
> -		(tty->ldisc.write_wakeup)(tty);
> -
> +	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
> +		tty_wakeup(tty);

Sorry I should have been clearer - you don't want the test_bit either.

Acked-by: Alan Cox <alan@redhat.com>

however as it is still right but you can stick my Ack on a version
without the if too.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
