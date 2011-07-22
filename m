Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jul 2011 16:01:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20110722160127.ec061ab6.akpm@linux-foundation.org>
In-Reply-To: <1311239914-8301-7-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
	<1311239914-8301-7-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 07/10] um: Set __HAVE_ARCH_GATE_AREA for x86_64
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 21 Jul 2011 11:18:31 +0200
Richard Weinberger <richard@nod.at> wrote:

> Implement arch_vma_name() and make get_gate_vma(),
> in_gate_area() and in_gate_area_no_mm() a nop.
> 
> We need arch_vma_name() to support vDSO.

Well this is awkward.

>  arch/um/sys-x86_64/asm/elf.h |    1 +
>  arch/um/sys-x86_64/mem.c     |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)

Your um-clean-up-vm-flagsh.patch deleted arch/um/sys-x86_64/mem.c.

There's not really any appropriate .c file in arch/um/sys-x86_64 for
these functions so I changed the patch to reinstate mem.c.

Then I changed my maind and dropped it ;) Hopefully none of the other
patches depended on this one.

Then I looked at um-implement-a-x86_64-vdso.patch, got nervous and
undropped um-set-__have_arch_gate_area-for-x86_64.patch.

