Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFaf7-0005d9-KH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 11:44:30 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFaf6-0006Av-3c
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 11:44:29 -0800
Date: Thu, 17 Jan 2008 11:44:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080117114414.308db9e7.akpm@linux-foundation.org>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117135641.GD2693@hacking>
	<200801171911.16230.m.kozlowski@tuxland.pl>
	<20080117105606.ff89e9e9.akpm@linux-foundation.org>
	<924EFEDD5F540B4284297C4DC59F3DEE5E90DF@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
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
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>

On Thu, 17 Jan 2008 11:38:53 -0800 "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

>  
> 
> >-----Original Message-----
> >From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> >Sent: Thursday, January 17, 2008 10:56 AM
> >To: Mariusz Kozlowski
> >Cc: WANG Cong; linux-kernel@vger.kernel.org; Jeff Dike; 
> >user-mode-linux-devel@lists.sourceforge.net; David Miller; 
> >sparclinux@vger.kernel.org; Ingo Molnar; Thomas Gleixner; 
> >Pallipadi, Venkatesh
> >Subject: Re: [-mm Patch] uml: fix a building error
> >
> >On Thu, 17 Jan 2008 19:11:13 +0100 Mariusz Kozlowski 
> ><m.kozlowski@tuxland.pl> wrote:
> >
> >> Hello,
> >> 
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
> >
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

Well.

- there are a bunch of cross-compiler binaries in
  http://userweb.kernel.org/~akpm/cross-compilers/

- I'll (again) encourage Ingo to add cross-compilation testing to his
  auto-testing setup. 

- I ran out of steam (and the selinux bug crashed my remote
  cross-compilation test box) so I didn't do much cross-compilation testing
  on rc8-mm1: just alpha and ia64 iirc.  

I'd suggest that you just prepare a best-effort patch and when I next get
around to doing more cross-compilation any problems shold get weeded out.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
