Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F3E9DC8.6090304@xenotime.net>
Date: Fri, 17 Feb 2012 10:34:48 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <20120217165045.2394d944d6efc37104421d2e@canb.auug.org.au>
In-Reply-To: <20120217165045.2394d944d6efc37104421d2e@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: linux-next: Tree for Feb 17 (uml)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/16/2012 09:50 PM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20120216:


uml on x86_64 (defconfig):

   CC      arch/um/kernel/asm-offsets.s
In file included from linux-next-20120217/include/linux/slab.h:12:0,
                  from linux-next-20120217/include/linux/crypto.h:23,
                  from 
linux-next-20120217/arch/x86/um/shared/sysdep/kernel-offsets.h:4,
                  from linux-next-20120217/arch/um/kernel/asm-offsets.c:1:
linux-next-20120217/include/linux/gfp.h: In function 'gfp_zonelist':
linux-next-20120217/include/linux/gfp.h:267:1: error: 
'__enabled_CONFIG_NUMA' undeclared (first use in this function)
linux-next-20120217/include/linux/gfp.h:267:1: note: each undeclared 
identifier is reported only once for each function it appears in
linux-next-20120217/include/linux/gfp.h:267:1: error: 
'__enabled_CONFIG_NUMA_MODULE' undeclared (first use in this function)



-- 
~Randy
