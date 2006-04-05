Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRDV2-0007J4-DH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 12:17:04 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRDV0-0003hX-8F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 12:17:04 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] system call accessing the host os
Message-ID: <20060405181812.GA5684@ccure.user-mode-linux.org>
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
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
Date: Wed, 5 Apr 2006 14:18:12 -0400
To: Olivier Crameri <olivier.crameri@epfl.ch>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 05, 2006 at 07:16:22PM +0200, Olivier Crameri wrote:
> Unfortunately, I'm having some weird issues that I can't really  
> understand. I can read the file using fread, but only in a buffer  
> that I allocated using um_kmalloc. If I use a buffer allocated by  
> malloc, the fread fails. Then, even if I replace all  my mallocs by  
> um_kmallocs, some libc functions (such as sscanf) don't seem to work  
> properly. I guess I'm missing something, but I can't figure out what.

Define "fails" and "don't seem to work properly".

If your buffers are larger than 128K, then libc malloc gets turned into
UML kernel vmalloc.  In this case, the buffer isn't mapped, and
passing it into a system call will make it return -EFAULT.  The
easiest workaround for this is to memset the thing immediately after
allocating it.

Also, if you're using the libc things you're talking about, watch out
for your stack consumption.  By default, you get two pages (8K).
printf will completely use it up, so it is unusable in kernel code.

UML kernel stack size is configurable - CONFIG_KERNEL_STACK_ORDER -
bumping that to 3 will double the kernel stack size.  If problems then
go away, then you know that libc is overflowing your stack.

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
