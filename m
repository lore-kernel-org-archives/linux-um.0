Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9Nd1-0001RW-1W	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 06:55:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9Nd0-0006yc-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 06:55:19 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [uml-user] Hardware Requirements -Some Questions
	about UML by a Newbie
Message-ID: <20050828134839.GE3192@ccure.user-mode-linux.org>
References: <396648218@web.de>
	<20050811232256.GF11873@ccure.user-mode-linux.org>
	<200508121814.43201.blaisorblade@yahoo.it>
	<1124960678.28722.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124960678.28722.29.camel@localhost.localdomain>
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
Date: Sun, 28 Aug 2005 09:48:39 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>, eric_leitner@web.de

On Thu, Aug 25, 2005 at 10:04:38AM +0100, Antoine Martin wrote:
> 64-bit is broken atm, you'll run out of memory very quickly.

I found the leak, and have been making a UML doing a kernel build loop
all weekend, with no memory loss.

The patch is below.

> PS: I also got this error, not sure it has anything to do with the above
> (probably not):
> x86_64-pc-linux-gnu-gcc -O2 -fno-unit-at-a-time -DHAVE_CONFIG_H
> -D_U_="__attribute__((unused))" -I.  -I./missing -I/usr/include
> -c ./smbutil.c
> In file included from ./tcpdump-stdinc.h:96,
>                  from ./smbutil.c:18:
> /usr/include/unistd.h:533: internal compiler error: Segmentation fault

Is this reproducable?

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
