Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9Qd-0001yO-KV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:56:55 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9Qc-0001MY-AG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:56:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC: 2.6 patch] fix the INIT_ENV_ARG_LIMIT
	dependencies
References: <20060415143036.GI15022@stusta.de>
In-Reply-To: <20060415143036.GI15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191159.41148.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:59:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Adrian Bunk <bunk@stusta.de>, jdike@karaya.com, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>

On Saturday 15 April 2006 16:30, Adrian Bunk wrote:
> This patch fixes the INIT_ENV_ARG_LIMIT dependencies to what seems to
> have been intended.

Yes, the global rename USERMODE -> UML in Kconfig missed something, it seems. 
My bad.

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> Spotted by Jean-Luc Leger.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

> --- linux-2.6.17-rc1-mm2-full/init/Kconfig.old	2006-04-15
> 16:26:46.000000000 +0200 +++
> linux-2.6.17-rc1-mm2-full/init/Kconfig	2006-04-15 16:27:12.000000000 +0200
> @@ -46,8 +46,8 @@
>
>  config INIT_ENV_ARG_LIMIT
>  	int
> -	default 32 if !USERMODE
> -	default 128 if USERMODE
> +	default 32 if !UML
> +	default 128 if UML
>  	help
>  	  Maximum of each of the number of arguments and environment
>  	  variables passed to init from the kernel command line.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live
> webcast and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
