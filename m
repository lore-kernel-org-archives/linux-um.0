Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Oct 2010 00:29:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] um: Get rid of __do_IRQ()
In-Reply-To: <20101011151447.1a022f25.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.2.00.1010120028570.2909@localhost6.localdomain6>
References: <1286832575-21474-1-git-send-email-richard@nod.at> <20101011151447.1a022f25.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, peterz@infradead.org, tj@kernel.org, mingo@elte.hu
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 11 Oct 2010, Andrew Morton wrote:

> On Mon, 11 Oct 2010 23:29:35 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > This patch removes __do_IRQ() from user mode linux.
> 
> I'd never actually noticed CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ.
> 
> What's the plan here?  Are all architectures supposed to me migrating
> away from __do_IRQ() and over to generic_handle_irq(), or what?

Yes, that's why __do_IRQ() is deprecated since 3 years.

 
