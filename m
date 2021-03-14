Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLTzD-00EMbj-QQ
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 16:53:05 +0000
Message-ID: <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 17:53:01 +0100
In-Reply-To: <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com


> 
> +#else
> +
> +#include <asm-generic/nommu_context.h>
> +
> +extern void force_flush_all(void);
> 
nit: no need for "extern"

> +#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
> +#include <asm-generic/page.h>
> +
> +#define __va_space (8*1024*1024)
> +
> +#ifndef __ASSEMBLY__
> +#include <mem.h>

Is that <shared/mem.h>? I think we should start including only with that
prefix.

> +
> +void *uml_kmalloc(int size, int flags)
> +{
> +	return kmalloc(size, flags);
> +}

That could probably still be shared?

> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_rw(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_nx(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_x(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}

UML for now no longer has these either.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

