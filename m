Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxQ7X-0004r2-2E for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 04:32:35 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AxPwM-0004f7-49 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 04:21:02 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
In-Reply-To: <20040229023636.GB8272@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291325.40644.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Feb 2004 13:25:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 03:36, domenica 29 febbraio 2004, Jeff Dike ha scritto:
> The patch below fixes a bug in the /dev/kmem driver which causes UML to
> die if you write to it.  Of course, the kernel will die if you write random
> crap to kernel memory, but at least it doesn't die in a UML-specific way.

> This is a cut'n'paste from an xterm, so apply with patch -l.

This patch is like the one for the read from /dev/kmem (i.e. the one fixing 
the panic when one does "cat /dev/kmem": you can reproduce this panic on 
Uml2.6): it makes it behave like /dev/mem (man 4 mem is indeed helpful!). So 
it is basically not *the right way*.

Also, someone got a panic with the read patch applied while klogd was reading 
something. The diagnosys was that the /dev/mem driver checks for overflows, 
while this patched /dev/kmem driver does not. To read the physical address 
0x1with /dev/kmem, you are supposed to read 0xc0000001; so with that patch 
any proper user of /dev/kmem will overflow p.

So, I propose to either return -EFAULT with not accessible addresses (which is 
the proper fix), or to (at least and as a workaround) correct the "fops" 
fields of /dev/kmem to redirect it on /dev/mem (at least this avoids the 
crash better than the current patches).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
