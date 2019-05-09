Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hOeSU-0006Rp-95
 for linux-um@lists.infradead.org; Thu, 09 May 2019 08:31:21 +0000
Received: by mail-wm1-x333.google.com with SMTP id j187so2005806wmj.1
 for <linux-um@lists.infradead.org>; Thu, 09 May 2019 01:31:16 -0700 (PDT)
Date: Thu, 9 May 2019 10:31:11 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
Message-ID: <20190509083111.GA75918@gmail.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-arch@vger.kernel.org, hjl.tools@gmail.com, mhocko@suse.com, rguenther@suse.de, richard@nod.at, gxt@pku.edu.cn, benh@kernel.crashing.org, jdike@addtoit.com, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, luto@amacapital.net, linux-mm@kvack.org, paulus@samba.org, mpe@ellerman.id.au, yang.shi@linux.alibaba.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, vbabka@suse.cz, anton.ivanov@cambridgegreys.com


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> Reported-by: Richard Biener <rguenther@suse.de>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: x86@kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-um@lists.infradead.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-arch@vger.kernel.org
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I've also added your:

  Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Because I suppose you intended to sign off on it?

Thanks,

	Ingo

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

