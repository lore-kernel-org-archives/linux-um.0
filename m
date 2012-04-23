Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Apr 2012 08:40:27 -0700
From: Anton Vorontsov <anton.vorontsov@linaro.org>
Message-ID: <20120423154027.GA23066@lizard>
References: <20120423070641.GA27702@lizard>
 <20120423070925.GG30752@lizard>
 <4F956DF2.7020408@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F956DF2.7020408@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 7/9] um: Should hold tasklist_lock while traversing
 processes
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Apr 23, 2012 at 04:57:54PM +0200, Richard Weinberger wrote:
> On 23.04.2012 09:09, Anton Vorontsov wrote:
> >Traversing the tasks requires holding tasklist_lock, otherwise it
> >is unsafe.
> >
> >p.s. However, I'm not sure that calling os_kill_ptraced_process()
> >in the atomic context is correct. It seem to work, but please
> >take a closer look.
> >
> >Signed-off-by: Anton Vorontsov<anton.vorontsov@linaro.org>
> >---
> 
> You forgot my Ack and I've already explained why
> os_kill_ptraced_process() is fine.

Ouch, sorry!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
