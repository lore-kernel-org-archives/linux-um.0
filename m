Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 28 Oct 2011 19:51:14 +0800
From: Yong Zhang <yong.zhang0@gmail.com>
Message-ID: <20111028115114.GA1934@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
 <1319277421-9203-19-git-send-email-yong.zhang0@gmail.com>
 <4EAA89EB.4020503@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EAA89EB.4020503@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 18/49] um: irq: Remove IRQF_DISABLED
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Oct 28, 2011 at 12:54:35PM +0200, Richard Weinberger wrote:
> Am 22.10.2011 11:56, schrieb Yong Zhang:
> > Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> > We run all interrupt handlers with interrupts disabled
> > and we even check and yell when an interrupt handler
> > returns with interrupts enabled (see commit [b738a50a:
> > genirq: Warn when handler enables interrupts]).
> > 
> > So now this flag is a NOOP and can be removed.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Richard Weinberger <richard@nod.at>
> 
> BTW: I think it's better when I carry this patch through my UML tree.
> Okay?

Good :)

Thanks,
Yong
