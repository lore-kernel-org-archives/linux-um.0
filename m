Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMVP2-0007md-S8	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:51:08 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMVP2-0005Md-DD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:51:09 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using __initcall from um/drivers/chan_kern.c / fun
	with keyboard
References: <2accc2ff0510022302i427f5730w56c3d0c28f7ff201@mail.gmail.com>
In-Reply-To: <2accc2ff0510022302i427f5730w56c3d0c28f7ff201@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032051.00444.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 20:51:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Nelson Castillo <nelsoneci@gmail.com>
Cc: Linux en-Caja <linuxencaja@googlegroups.com>

On Monday 03 October 2005 08:02, Nelson Castillo wrote:
> Hi, I'm sending a patch that allows me to query the
> number of keys pressed by the user (I'll copy [4]).


> --------------
> # cat /proc/keystrokes
> 29
> --------------

> I read [1] and skimmed over [2] and I think I'm using
> the __init and __initcall macros well, but I get this
> error when I try to use them:
>
> CC      arch/um/drivers/chan_kern.o
> arch/um/drivers/chan_kern.c:111: error: `proc_kst_init' undeclared
> here (not in a function)
> arch/um/drivers/chan_kern.c:98: warning: `proc_kts_init' defined but not
If you pasted the correct error message and the correct code, they both say 
"kst" on one line and "kts" on the other. You have a trivial typo.

> What should I do/try?

> Can I use these macros in um/drivers/chan_kern.c?
Yes, take the right include and you can (use <linux/init.h>, not 
arch/um/include/init.h)

>   Blaisorblade told me to it in serio[3], but I don't know
>   where I should put the hooks. I think I can also use
>   drivers/char/keyboard.c
If it's arch-independent, you maybe can. But you'd better ask this on LKML, 
probably.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
