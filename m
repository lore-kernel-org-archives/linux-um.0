Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOi1z-0005PA-5b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 13:16:43 -0800
Received: from moutng.kundenserver.de ([212.227.126.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FOi1u-00025w-Cr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 13:16:43 -0800
Subject: Re: [uml-devel] Integer overflows in new AIO ubd driver
From: Gerd Stolpmann <info@gerd-stolpmann.de>
In-Reply-To: <20060329193324.GC4940@ccure.user-mode-linux.org>
References: <1143398965.11224.146.camel@localhost.localdomain>
	<20060327153832.GB3666@ccure.user-mode-linux.org>
	<1143474452.11224.150.camel@localhost.localdomain>
	<20060329193324.GC4940@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1143666989.7192.9.camel@localhost.localdomain>
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
Date: Wed, 29 Mar 2006 23:16:27 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am Mittwoch, den 29.03.2006, 14:33 -0500 schrieb Jeff Dike:
> On Mon, Mar 27, 2006 at 05:47:31PM +0200, Gerd Stolpmann wrote:
> > I used iozone in various ways. The simplest workload leading to problems
> > was:
> > 
> > - Write a 5GB file
> > - Write it again
> > - Read it back
> > - Read it back
> > 
> > This benchmark ran fine the first time I started it. When I started it
> > again, UML locked up in the middle. This is reproducible.
> 
> I'm interpretting that description as being this command:
> 	iozone -s 5G -i 0 -i 0 -i 1 -i 1
> 
> Yes?

Almost:

iozone -i 0 -i 1 -r 64k -s 5G -e -f /Data/testfile -U /Data

i.e. record size is 64K, and there is a umount/mount between the
runs. /Data is an ext3 filesystem with 4k block size, on a 20 G
partition.

> And it runs fine here.

For me it runs fine only the first time I call it. The next time UML
locks up.

Can I do something to find out more details?

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
