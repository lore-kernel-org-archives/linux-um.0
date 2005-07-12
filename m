Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsSwW-0001rk-0X	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 15:09:32 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsSwT-0002Q0-Bx	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 15:09:31 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Clarification of UML and AIO?
Message-ID: <20050712220327.GB4469@ccure.user-mode-linux.org>
References: <42D42ED5.4000101@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D42ED5.4000101@oracle.com>
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
Date: Tue, 12 Jul 2005 18:03:27 -0400
To: Allan Graves <allan.graves@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Tracing the aio_read() through the UML kernel finally gets me here:
> 
> #0  sys_pread64 (fd=3, buf=0xbf7c8f20 "", count=1024, pos=0)
>   at fs/read_write.c:354
> #1  0x08062ff8 in execute_syscall_skas (r=0x12374864)
>   at arch/um/kernel/skas/syscall_kern.c:29

Finally?  That's the very beginning of the system call (or the very end).

The UML block device doesn't know about AIO.  All it does is get blocks from
a disk.

Are you sure you're getting kernel AIO and not the libc emulation of it?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
