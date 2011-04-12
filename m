Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 Apr 2011 22:27:03 +0200
References: <201104121609.56901.richard@nod.at> <20110412192014.GF16342@mtj.dyndns.org> <BANLkTimsw1N=0QkEsySBE58GJx7g12XQpQ@mail.gmail.com>
In-Reply-To: <BANLkTimsw1N=0QkEsySBE58GJx7g12XQpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104122227.03688.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: this_cpu_cmpxchg16b_emu
To: Pekka Enberg <penberg@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 12 April 2011, 21:22:47 schrieb Pekka Enberg:
> On Tue, Apr 12, 2011 at 08:41:11PM +0200, Richard Weinberger wrote:
> >> Am Dienstag 12 April 2011, 20:10:37 schrieb Christoph Lameter:
> >> > On Tue, 12 Apr 2011, Richard Weinberger wrote:
> >> > > This patch implements this_cpu_cmpxchg16b_emu() for UML.
> >> > 
> >> > Is this really necessary? Just undefine CONFIG_CMPXCHG_LOCAL for UML
> >> > and the asm code will not be used.
> >> 
> >> UML includes arch/x86/Kconfig.cpu which defines CONFIG_CMPXCHG_LOCAL
> >> automatically. Just disabling CONFIG_CMPXCHG_LOCAL for UML is IMHO not
> >> very nice. When chpxchg is available also UML should use it...
> 
> On Tue, Apr 12, 2011 at 10:20 PM, Tejun Heo <tj@kernel.org> wrote:
> > Ugh... I'd really like to avoid things like this for UML.  Is there
> > any SLUB performance sensitive workload running on UML?  I've never
> > seen any UML in production environment.  Wouldn't it be better to keep
> > things simple?
> 
> Yes, it would be. :-)

Okay. Then let's keep it simple. :-)
I'll disable CONFIG_CMPXCHG_LOCAL for UML.

Has someone looked at my this_cpu_cmpxchg16b_emu() implementation,
is it correct? Especially the call to C stuff.
I've tested it, it works fine.

Thanks,
//richard
