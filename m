Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh6s-0006TE-7J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh6r-0002Ch-5N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:25 -0800
Message-Id: <200401280439.i0S4dEZw005502@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [Sebastian.Koch@metatool.de: Re: ps u failed with
	signal 8 (FPE)] 
In-Reply-To: Your message of "Thu, 22 Jan 2004 12:48:58 +0100."
	<20040122114858.GH11029@bytesex.org> 
References: <20040122114858.GH11029@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 27 Jan 2004 23:39:14 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> The problem is that the proc file system of the UML shows a wrong /
> proc/meminfo. Especially the MemTotal: 

Nice catch.  I was wondering about that SIGFPE crash.  Try the patch below.

				Jeff

===== arch/um/kernel/mem.c 1.21 vs edited =====
--- 1.21/arch/um/kernel/mem.c   Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/mem.c Mon Jan 26 11:02:13 2004
@@ -30,7 +30,6 @@
 int kmalloc_ok = 0;
 
 static unsigned long brk_end;
-static unsigned long totalram_pages = 0;
 
 void unmap_physmem(void)
 {



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
