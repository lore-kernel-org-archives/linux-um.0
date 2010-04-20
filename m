Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Apr 2010 10:25:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 2/5] uml: Drop private round_down definition
Message-ID: <20100420142510.GA30011@c-98-229-117-200.hsd1.ma.comcast.net>
References: <cover.1271713955.git.jan.kiszka@web.de> <74c7d668690f283cf3b8aed92004dc72e872f7ce.1271713955.git.jan.kiszka@web.de> <20100420083358.GD4356@cr0.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100420083358.GD4356@cr0.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 20, 2010 at 04:33:58PM +0800, Amerigo Wang wrote:
> On Mon, Apr 19, 2010 at 11:53:05PM +0200, Jan Kiszka wrote:
> >Already defined in kernel.h. The official version assumes that 'n' is
> >power of two - which it is in our case.
> >
> >Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
> >---
> > arch/um/sys-x86_64/signal.c |    2 --
> > 1 files changed, 0 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
> >index 1a899a7..07797d1 100644
> >--- a/arch/um/sys-x86_64/signal.c
> >+++ b/arch/um/sys-x86_64/signal.c
> >@@ -165,8 +165,6 @@ struct rt_sigframe
> > 	struct _fpstate fpstate;
> > };
> > 
> >-#define round_down(m, n) (((m) / (n)) * (n))
> >-
> > int setup_signal_stack_si(unsigned long stack_top, int sig,
> > 			  struct k_sigaction *ka, struct pt_regs * regs,
> > 			  siginfo_t *info, sigset_t *set)
> 
> Shouldn't this signal.c #include <linux/kernel.h>?

I agree - if this is going to depend on kernel.h, it should be
explicitly included.

				Jeff
