Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiMXg-000070-Eh for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:41:20 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AiMXf-0005Qf-UB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:41:20 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml-patch-2.6.1
Message-ID: <20040119000327.GD21046@ccure.user-mode-linux.org>
References: <200401140725.i0E7Pr9b001444@uml.user-mode-linux.org>
	<200401181723.32498.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401181723.32498.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jan 2004 19:03:27 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 05:23:32PM +0100, BlaisorBlade wrote:
> Try disabling CONFIG_MODE_TT and you'll see that 
> arch/um/kernel/skas/include/uaccess.h doesn't compile (it uses EFAULT but 
> errno.h is included only by arch/um/kernel/tt/include/uaccess.h).

Fixed now.

> This happens because hostfs is not compiled with -O2, since now -O2 is added 
> to CFLAGS after including arch/??/Makefile. The inlines that do the needed 
> wrapping are defined(in /usr/include/sys/stat.h) only if _OPTIMIZE_ if 
> defined (probably because inlines don't work otherwise, but other inlines are
> defined anyway, so there is also a libc bug). So, I'm attaching the fix.

Applied, thanks.

				Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
