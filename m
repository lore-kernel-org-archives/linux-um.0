Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPlpA-0002xM-1M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:22:48 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BPlp7-0001Pl-QM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:22:45 -0700
Message-Id: <s0a89290.084@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [uml-devel] Re: Patch 2.6.6
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
Date: Mon, 17 May 2004 10:22:53 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I've downloaded this patch, with a vanilla kernel to a SuSE 9.0 machine
(32-bit, native Intel architecture). Following previously posted
suggestions, I removed the um_rquest_irq function from
include/asm-um/irq.h.

However, I'm having problems compiling. I issue 'make vmlinux ARCH=um'
and see:

  HOSTCC  arch/um/util/mk_constants_kern.o
arch/um/util/mk_constants_kern.c: In function `main':
arch/um/util/mk_constants_kern.c:16: error: `KERN_EMERG' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:16: error: (Each undeclared identifier
is reported only once
arch/um/util/mk_constants_kern.c:16: error: for each function it
appears in.)
arch/um/util/mk_constants_kern.c:17: error: `KERN_ALERT' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:18: error: `KERN_CRIT' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:19: error: `KERN_ERR' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:20: error: `KERN_WARNING' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:21: error: `KERN_NOTICE' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:22: error: `KERN_INFO' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:23: error: `KERN_DEBUG' undeclared
(first use in this function)
arch/um/util/mk_constants_kern.c:25: error: `NSEC_PER_SEC' undeclared
(first use in this function)
make[1]: *** [arch/um/util/mk_constants_kern.o] Error 1
make: *** [arch/um/util] Error 2

However, KERN_EMERG is declared in both
<kernel_src>/include/linux/kernel.h and /usr/include/linux/kernel.h,
which is included at the top of the source file. Why would this fail to
be declared? I HAVE to be missing something basic on my compiles...
*sigh*

Tony


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
