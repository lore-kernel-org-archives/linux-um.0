Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcsUH-0006IF-Ks for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:44:13 -0800
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcsUG-0001DI-D4
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:44:13 -0800
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAHMi0X0025129
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Nov 2005 17:44:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id
	jAHMi0LZ118386 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Nov 2005 17:44:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jAHMi0xR021065
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Nov 2005 17:44:00 -0500
Subject: Re: [uml-devel] [RFC PATCH] fixes for some compilation errors
From: Ram Pai <linuxram@us.ibm.com>
In-Reply-To: <20051116191819.GA7635@ccure.user-mode-linux.org>
References: <20051115233006.GA31279@RAM>
	<20051116012309.GB11520@ccure.user-mode-linux.org>
	<1132137733.5720.17.camel@localhost>
	<20051116191819.GA7635@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1132267438.5720.179.camel@localhost>
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
Date: Thu, 17 Nov 2005 14:43:59 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 2005-11-16 at 11:18, Jeff Dike wrote:
> On Wed, Nov 16, 2005 at 02:42:13AM -0800, Ram Pai wrote:
> > make -j32 arch/um/kernel/skas/clone.o ARCH=um
> >   CC      arch/um/kernel/skas/clone.o
> > arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> > arch/um/kernel/skas/clone.c:39: error: aggregate value used where an
> > integer was expected
> > make[1]: *** [arch/um/kernel/skas/clone.o] Error 1
> > make: *** [arch/um/kernel/skas/clone.o] Error 2
> 
> OK, I fixed this.  That was the first patch in the series, and I was 
> forgetting to refresh it.
> 
> What was the bit about a patch not applying cleanly?  I just pulled my
> tarball, and everything is clean.

Ok. confirmed. It works now! Patches apply cleanly and compiles cleanly
too.
RP




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
