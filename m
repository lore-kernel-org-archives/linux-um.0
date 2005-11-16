Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcRyp-0003vt-A5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 10:25:59 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcRyk-0000iX-Ek
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 10:25:56 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC PATCH] fixes for some compilation errors
Message-ID: <20051116191819.GA7635@ccure.user-mode-linux.org>
References: <20051115233006.GA31279@RAM>
	<20051116012309.GB11520@ccure.user-mode-linux.org>
	<1132137733.5720.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132137733.5720.17.camel@localhost>
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
Date: Wed, 16 Nov 2005 14:18:19 -0500
To: Ram Pai <linuxram@us.ibm.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 16, 2005 at 02:42:13AM -0800, Ram Pai wrote:
> make -j32 arch/um/kernel/skas/clone.o ARCH=um
>   CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/kernel/skas/clone.c:39: error: aggregate value used where an
> integer was expected
> make[1]: *** [arch/um/kernel/skas/clone.o] Error 1
> make: *** [arch/um/kernel/skas/clone.o] Error 2

OK, I fixed this.  That was the first patch in the series, and I was 
forgetting to refresh it.

What was the bit about a patch not applying cleanly?  I just pulled my
tarball, and everything is clean.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
