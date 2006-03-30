Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FP2Bu-0006Zu-Dc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 10:48:18 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FP2Br-0004ja-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 10:48:18 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Integer overflows in new AIO ubd driver
Message-ID: <20060330184927.GC6739@ccure.user-mode-linux.org>
References: <1143398965.11224.146.camel@localhost.localdomain>
	<20060327153832.GB3666@ccure.user-mode-linux.org>
	<1143474452.11224.150.camel@localhost.localdomain>
	<20060329193324.GC4940@ccure.user-mode-linux.org>
	<1143666989.7192.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143666989.7192.9.camel@localhost.localdomain>
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
Date: Thu, 30 Mar 2006 13:49:27 -0500
To: Gerd Stolpmann <info@gerd-stolpmann.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 29, 2006 at 11:16:27PM +0200, Gerd Stolpmann wrote:
> Almost:
> 
> iozone -i 0 -i 1 -r 64k -s 5G -e -f /Data/testfile -U /Data
> 
> i.e. record size is 64K, and there is a umount/mount between the
> runs. /Data is an ext3 filesystem with 4k block size, on a 20 G
> partition.

OK, this doesn't run fine for me even the first time, so I have something
I can chew on.

BTW, your earlier fixes are now in my patchset.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
