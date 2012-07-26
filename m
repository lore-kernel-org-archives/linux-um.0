Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50115FCF.4060708@xenotime.net>
Date: Thu, 26 Jul 2012 08:18:39 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
In-Reply-To: <20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: linux-next: Tree for July 26 (uml)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 07/25/2012 10:04 PM, Stephen Rothwell wrote:

> Hi all,
> 
> Please do not add anything to linux-next included branches/series that is
> destined for v3.7 until after v3.6-rc1 is released.
> 
> Reminder: do not rebase your branches before asking Linus to pull them ...
> 
> Changes since 20120725:
> 



uml on x86_64 (defconfig) build fails with:

  CC      arch/x86/um/../kernel/module.o
arch/x86/um/../kernel/module.c:96:5: error: redefinition of 'apply_relocate_add'
include/linux/moduleloader.h:64:19: note: previous definition of 'apply_relocate_add' was here
make[2]: *** [arch/x86/um/../kernel/module.o] Error 1



-- 
~Randy
