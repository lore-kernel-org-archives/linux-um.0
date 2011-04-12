Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 12 Apr 2011 20:41:11 +0200
References: <201104121609.56901.richard@nod.at> <alpine.DEB.2.00.1104121309480.14692@router.home>
In-Reply-To: <alpine.DEB.2.00.1104121309480.14692@router.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104122041.11460.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: this_cpu_cmpxchg16b_emu
To: Christoph Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, penberg@kernel.org, hpa@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 12 April 2011, 20:10:37 schrieb Christoph Lameter:
> On Tue, 12 Apr 2011, Richard Weinberger wrote:
> > This patch implements this_cpu_cmpxchg16b_emu() for UML.
> 
> Is this really necessary? Just undefine CONFIG_CMPXCHG_LOCAL for UML and
> the asm code will not be used.

UML includes arch/x86/Kconfig.cpu which defines CONFIG_CMPXCHG_LOCAL automatically.
Just disabling CONFIG_CMPXCHG_LOCAL for UML is IMHO not very nice.
When chpxchg is available also UML should use it...

Thanks,
//richard
