Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTWHw-0002Ak-TU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 21:17:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTWHv-0003Cy-EB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 21:17:20 -0700
Date: Sat, 30 Sep 2006 00:15:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060930041559.GE10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	<20060929153853.9bab3ca7.akpm@osdl.org>
	<65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com>
	<20060929161616.7e47c453.akpm@osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060929161616.7e47c453.akpm@osdl.org>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Don't roll my own random MAC
	generator
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: dhollis@davehollis.com, Jason Lunz <lunz@falooley.org>, Ollie Wild <aaw@google.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 04:16:16PM -0700, Andrew Morton wrote:
> arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it appears in.)
> arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared (first use in this function)

Hmmm, I never tried a cross-build before, but I don't even get this far:

  CC      arch/um/sys-i386/user-offsets.s
In file included from /usr/include/features.h:352,
                 from /usr/include/stdio.h:28,
                 from /home/jdike/linux/2.6/linux-2.6.17/arch/um/sys-i386/user-\offsets.c:1:
/usr/include/gnu/stubs.h:7:27: error: gnu/stubs-32.h: No such file or directory
m

I just flew into Ohio and am not in any shape to debug this atm.  I'll have
another look tomorrow.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
