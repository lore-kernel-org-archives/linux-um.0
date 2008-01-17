Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFbZ9-0003E1-S3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 12:42:23 -0800
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152] helo=tuxland.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFbZ9-0001QJ-Br
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 12:42:23 -0800
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 17 Jan 2008 21:42:12 +0100
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117105606.ff89e9e9.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200801172142.14326.m.kozlowski@tuxland.pl>
Subject: Re: [uml-devel] [-mm Patch] uml: fix a building error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>

Hello,

> >> > This patch fixes this building error:
> >> > ...
> >> > drivers/char/mem.c: In function 'read_mem':
> >> > drivers/char/mem.c:136: error: implicit declaration of 
> >function 'unxlate_dev_mem_ptr'
> >> > ...
> >> 
> >> I see this on sparc64 as well:
> >> 
> >>   CC      drivers/char/mem.o
> >> drivers/char/mem.c: In function 'read_mem':
> >> drivers/char/mem.c:136: error: implicit declaration of 
> >function 'unxlate_dev_mem_ptr'
> >> make[2]: *** [drivers/char/mem.o] Error 1
> >> make[1]: *** [drivers/char] Error 2
> >> make: *** [drivers] Error 2
> >> 
> >> Does sparc64 need similar fix?
> >> 
> >
> >The PAT patches strike again.
> >
> >Ingo, I think you might need to toss some cross-compilers into 
> >that build
> >test setup of yours.
> 
> These functions were defined for other archs in asm-generic/iomap.h.
> We need all archs including it in io.h. I now see only few archs are
> including it..
>
> Apart from unxlate, there is also ioremap_wc which is defined in the
> same way.
> 
> I can send a patch for this. But, I don't have cross compiler setup for
> all archs to test. Andrew, I will need your help.

I can confirm that this fixes the build problem for sparc64 here.

Regards,

	Mariusz

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
