Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb345-0002W3-Nt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 13:00:49 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb345-0004eP-49 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 13:00:49 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Bb343-0001y9-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jun 2004 22:00:47 +0200
Received: from p5089f645.dip.t-dialin.net ([80.137.246.69])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jun 2004 22:00:47 +0200
Received: from lists by p5089f645.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jun 2004 22:00:47 +0200
From: Martin Honermeyer <lists@strahlungsfrei.de>
Message-ID: <caq56s$5vg$1@sea.gmane.org>
References: <20040501170905.GA7655@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Subject: [uml-devel] Re: [PATCH] UML/x86_64
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
Date: Thu, 17 Jun 2004 20:53:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

thanks for your work! I just tried the patch on my AMD64 machine. "make
linux ARCH=um" fails with

  CC      arch/um/kernel/ksyms.o
arch/um/kernel/ksyms.c:91: error: `dump_thread' undeclared here (not in a
function)
arch/um/kernel/ksyms.c:91: error: initializer element is not constant
arch/um/kernel/ksyms.c:91: error: (near initialization for
`__ksymtab_dump_thread.value')
arch/um/kernel/ksyms.c:91: error: __ksymtab_dump_thread causes a section
type conflict
make[1]: *** [arch/um/kernel/ksyms.o] Error 1


When commenting out that line in arch/um/kernel/ksyms.c and disabling module
support in the kernel configuration, it works! So, just a little correction
to your patch. Now I'll try and see if it works ;)


Greetings,
Martin


Jeff Dike wrote:

> UML has been ported to x86_64.  The patch for 2.6.4 is available at
> http://www.user-mode-linux.org/mirror/uml-patch-x86-64-2.6.4.bz2
> 
> Note that this is separate from the 2.6.4 UML patch, and must be
> applied to a 2.6.4 + uml-patch-2.6.4 tree.  It will remain separate
> until I get it all merged cleanly into my tree.  At that point, the
> separate x86_64 patch will disappear.
> 
> This patch is fairly nasty in places, and the build is also fairly
> unclean, so avert your eyes if you are squeamish.  This will get
> better as I merge it into my pool.
> 
> The nastiness aside, it does build and you do get a robust UML.
> 
> My thanks go to PathScale (pathscale.com) for sponsoring this work and
> providing access to hardware to make it possible.
> 
> Finally, as I do the merge (and afterwards), I need access to an
> Opteron to make sure I don't break this port.  So, if anyone has such
> a box that I can have access to, let me know.
> 
> Jeff





-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
