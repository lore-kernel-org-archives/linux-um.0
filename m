Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Apr 2011 04:20:14 +0900
From: Tejun Heo <tj@kernel.org>
Message-ID: <20110412192014.GF16342@mtj.dyndns.org>
References: <201104121609.56901.richard@nod.at>
 <alpine.DEB.2.00.1104121309480.14692@router.home>
 <201104122041.11460.richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201104122041.11460.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: this_cpu_cmpxchg16b_emu
To: Richard Weinberger <richard@nod.at>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, penberg@kernel.org, hpa@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 12, 2011 at 08:41:11PM +0200, Richard Weinberger wrote:
> Am Dienstag 12 April 2011, 20:10:37 schrieb Christoph Lameter:
> > On Tue, 12 Apr 2011, Richard Weinberger wrote:
> > > This patch implements this_cpu_cmpxchg16b_emu() for UML.
> > 
> > Is this really necessary? Just undefine CONFIG_CMPXCHG_LOCAL for UML and
> > the asm code will not be used.
> 
> UML includes arch/x86/Kconfig.cpu which defines CONFIG_CMPXCHG_LOCAL automatically.
> Just disabling CONFIG_CMPXCHG_LOCAL for UML is IMHO not very nice.
> When chpxchg is available also UML should use it...

Ugh... I'd really like to avoid things like this for UML.  Is there
any SLUB performance sensitive workload running on UML?  I've never
seen any UML in production environment.  Wouldn't it be better to keep
things simple?

Thanks.

-- 
tejun
