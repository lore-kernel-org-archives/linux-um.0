Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zdvm-0003nx-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 08:09:22 -0700
Received: from bay7-f103.bay7.hotmail.com ([64.4.11.103] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zdvl-0000tl-Lx
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 08:09:21 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Problem with 2.4.22-um4
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F103PPYPeOqp2N00015916@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Sep 2003 15:08:49 +0000
To: petschge@gmx.de
Cc: User-mode-linux-devel@lists.sourceforge.net

petschge@gmx.de wrote:

>Checking that host ptys support output SIGIO...<0>Kernel panic: check_sigio 
>: read failed, err = -1
>
>In idle task - not syncing
>
>The host kernel is a 2.4.18 kernel patched by SuSE _without_ skas support. 
>gcc version is 2.95.3.
>
>Is this a know bug?

Jeff didn't like a part of my patch, but didn't back out all of the related 
bits.  I've sent him a patch that should fix this issue, but havn't heard 
back if he likes it any better.

In the mean time you can hand apply this diff to 
arch/um/kernel/sigio_user.c:tty_output()

-       else if(n == -EAGAIN) printk("No, enabling workaround\n");
-       else panic("check_sigio : read failed, err = %d\n", n);
+       else if(errno == EAGAIN) printk("No, enabling workaround\n");
+       else panic("check_sigio : read failed, errno = %d\n", errno);

Steve Schmidtke

>Is 2.4.22-um4 unusable without skas? Is this related to the patch in 
>arch/um/drivers/ubd_user.c? (Neither the patch from Ross Combs nor the 
>patch named ubd_start_io_thread.diff from Steve Schmidtke fix this error)
>
>mfg,
>Patrick "Petschge" Kilian

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
