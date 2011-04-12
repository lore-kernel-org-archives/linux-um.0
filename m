Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110412192014.GF16342@mtj.dyndns.org>
References: <201104121609.56901.richard@nod.at>
	<alpine.DEB.2.00.1104121309480.14692@router.home>
	<201104122041.11460.richard@nod.at>
	<20110412192014.GF16342@mtj.dyndns.org>
Date: Tue, 12 Apr 2011 22:22:47 +0300
Message-ID: <BANLkTimsw1N=0QkEsySBE58GJx7g12XQpQ@mail.gmail.com>
From: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: this_cpu_cmpxchg16b_emu
To: Tejun Heo <tj@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 12, 2011 at 08:41:11PM +0200, Richard Weinberger wrote:
>> Am Dienstag 12 April 2011, 20:10:37 schrieb Christoph Lameter:
>> > On Tue, 12 Apr 2011, Richard Weinberger wrote:
>> > > This patch implements this_cpu_cmpxchg16b_emu() for UML.
>> >
>> > Is this really necessary? Just undefine CONFIG_CMPXCHG_LOCAL for U=
ML and
>> > the asm code will not be used.
>>
>> UML includes arch/x86/Kconfig.cpu which defines CONFIG_CMPXCHG_LOCAL=
 automatically.
>> Just disabling CONFIG_CMPXCHG_LOCAL for UML is IMHO not very nice.
>> When chpxchg is available also UML should use it...

On Tue, Apr 12, 2011 at 10:20 PM, Tejun Heo <tj@kernel.org> wrote:
> Ugh... I'd really like to avoid things like this for UML. =A0Is there
> any SLUB performance sensitive workload running on UML? =A0I've never
> seen any UML in production environment. =A0Wouldn't it be better to k=
eep
> things simple?

Yes, it would be. :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

