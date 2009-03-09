Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1LgoEz-0003Vt-Tq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 22:46:33 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LgoEx-0007EJ-Gd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 22:46:33 +0000
Date: Mon, 9 Mar 2009 23:46:29 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20090309224628.GC3525@cs.unibo.it>
References: <20090308170758.GE6847@cs.unibo.it>
	<20090309221637.GB3525@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090309221637.GB3525@cs.unibo.it>
Subject: Re: [uml-devel] Nesting and other problems on 2.6.29-rc7
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

> The following code contains the same mmap64 call that leads nested uml to fail.
....
I have a simpler code that produces the same crash:
---
#include <sys/mman.h>
main() {
  munmap((void *) 0x100000, 0x1000);
}
---
	renzo

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

