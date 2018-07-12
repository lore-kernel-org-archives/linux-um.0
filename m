Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdcEG-0007FI-J9
 for linux-um@lists.infradead.org; Thu, 12 Jul 2018 14:05:57 +0000
Received: by mail-pf0-x243.google.com with SMTP id b17-v6so20663547pfi.0
 for <linux-um@lists.infradead.org>; Thu, 12 Jul 2018 07:05:46 -0700 (PDT)
Date: Thu, 12 Jul 2018 17:05:40 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/6] kbuild: clean-up and rename LDFLAGS to KBUILD_LDFLAGS
Message-ID: <20180712140539.4b5xdraq34i5dbii@kshutemo-mobl1>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, openrisc@lists.librecores.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 12, 2018 at 05:01:30PM +0900, Masahiro Yamada wrote:
> 
> This series renames LDFLAGS to KBUILD_LDFLAGS
> after some Makefile cleanups.
> 
> Currently, the last patch does not apply to Linus' tree
> due to missing pre-requisite patches.
> 
> I will resolve conflicts as needed.
> 
> 
> 
> Masahiro Yamada (6):
>   um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
>   ARM: vfp: clean-up arch/arm/vfp/Makefile
>   kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
>   kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
>   kbuild: change ld_flags to contain LDFLAGS_$(@F)
>   kbuild: rename LDFLAGS to KBUILD_LDFLAGS

Thanks! Looks sane to me

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

