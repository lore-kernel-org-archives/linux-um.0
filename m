Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eczny-0000YB-CV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:33:02 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ecznv-00084l-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:33:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 3/4] UML - Properly invoke x86_64 system
	calls
References: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180741.37478.blaisorblade@yahoo.it>
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
Date: Fri, 18 Nov 2005 07:41:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net, "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>

On Thursday 17 November 2005 21:37, linux-os (Dick Johnson) wrote:
> On Thu, 17 Nov 2005, Jeff Dike wrote:
> > This patch makes stub_segv use the stub_syscall macros.  This was
> > needed anyway, but the bug that prompted this was the discovery that
> > gcc was storing stuff in RCX, which is trashed across a system
> > call.

> But the C-calling convention used by gcc for 32-bit systems
> is supposed to allow the called-function to destroy general-
> purpose registers but not index registers. In other words,
> ECX, EDX are supposed to be available and EAX is used for
> return-values. The register size isn't supposed to have
> anything to do with it (longword/quadword)!

> In 64-bit world, the same is supposed to apply as well.
> If RCX is now precious, it's a GCC bug that should be fixed.

It's not _normally_ precious, for function calling conventions, but syscalls 
are different.

Read include/asm-x86_64/unistd.h and see that the _syscallX macros contain 
various register clobber. I.e. they explicitly tell GCC "don't use that". We 
(UML code) were missing that. Simple.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
