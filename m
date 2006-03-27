Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNtwS-0004Ra-6a for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 07:47:40 -0800
Received: from moutng.kundenserver.de ([212.227.126.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FNtwQ-0006dg-Pe
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 07:47:40 -0800
Subject: Re: [uml-devel] Integer overflows in new AIO ubd driver
From: Gerd Stolpmann <info@gerd-stolpmann.de>
In-Reply-To: <20060327153832.GB3666@ccure.user-mode-linux.org>
References: <1143398965.11224.146.camel@localhost.localdomain>
	<20060327153832.GB3666@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1143474452.11224.150.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Mon, 27 Mar 2006 17:47:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Montag, den 27.03.2006, 10:38 -0500 schrieb Jeff Dike:
> On Sun, Mar 26, 2006 at 08:49:25PM +0200, Gerd Stolpmann wrote:
> > I recently tried to benchmark the new AIO-based ubd driver (including
> > O_DIRECT), and ran into serious problems with filesystems > 4GB. I think
> > I found the problem; two overflows in ubd_kern.c (see patch).
> 
> The first bit looks reasonable.  I would change start to an unsigned
> long long instead of casting, though.
> 
> > I also experienced (hard) lockups when doing lots of I/O. But this seems
> > to be unrelated to this problem (but who knows).
> 
> What was your workload?

I used iozone in various ways. The simplest workload leading to problems
was:

- Write a 5GB file
- Write it again
- Read it back
- Read it back

This benchmark ran fine the first time I started it. When I started it
again, UML locked up in the middle. This is reproducible.

Gerd
-- 
------------------------------------------------------------
Gerd Stolpmann * Viktoriastr. 45 * 64293 Darmstadt * Germany 
gerd@gerd-stolpmann.de          http://www.gerd-stolpmann.de
Phone: +49-6151-153855                  Fax: +49-6151-997714
------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
