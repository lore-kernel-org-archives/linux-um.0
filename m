Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkosina@suse.cz>) id 1O4Fhf-0005BY-V8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 15:49:35 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4Fhe-0007Kw-KD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2010 15:49:35 +0000
Date: Tue, 20 Apr 2010 17:49:28 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <20100420142510.GA30011@c-98-229-117-200.hsd1.ma.comcast.net>
Message-ID: <alpine.LNX.2.00.1004201749170.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<74c7d668690f283cf3b8aed92004dc72e872f7ce.1271713955.git.jan.kiszka@web.de>
	<20100420083358.GD4356@cr0.nay.redhat.com>
	<20100420142510.GA30011@c-98-229-117-200.hsd1.ma.comcast.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/5] uml: Drop private round_down definition
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, 20 Apr 2010, Jeff Dike wrote:

> > >Already defined in kernel.h. The official version assumes that 'n' is
> > >power of two - which it is in our case.
> > >
> > >Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
> > >---
> > > arch/um/sys-x86_64/signal.c |    2 --
> > > 1 files changed, 0 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
> > >index 1a899a7..07797d1 100644
> > >--- a/arch/um/sys-x86_64/signal.c
> > >+++ b/arch/um/sys-x86_64/signal.c
> > >@@ -165,8 +165,6 @@ struct rt_sigframe
> > > 	struct _fpstate fpstate;
> > > };
> > > 
> > >-#define round_down(m, n) (((m) / (n)) * (n))
> > >-
> > > int setup_signal_stack_si(unsigned long stack_top, int sig,
> > > 			  struct k_sigaction *ka, struct pt_regs * regs,
> > > 			  siginfo_t *info, sigset_t *set)
> > 
> > Shouldn't this signal.c #include <linux/kernel.h>?
> 
> I agree - if this is going to depend on kernel.h, it should be
> explicitly included.

Yup, I have already added that.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

