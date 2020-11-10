Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcWha-0007cq-OE
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 16:41:05 +0000
Message-ID: <ca9a4a3d2e6c49cc609db33637089e9110662174.camel@sipsolutions.net>
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 10 Nov 2020 17:40:42 +0100
In-Reply-To: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

On Tue, 2020-11-10 at 16:30 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> UML kernel runs as a normal userspace process and can use the
> optimized glibc strings functions like strcpy, memcpy, etc.
> 
> The support is optional and is turned on/of using a config
> option.
> 
> Using glibc functions results in a slightly smaller executable
> when linked dynamically as well as anything between 1% and 5%
> performance improvements.

Nice! :-)

> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 4b799fad8b48..961cf3af3ff0 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -189,6 +189,17 @@ config UML_TIME_TRAVEL_SUPPORT
>  
>  	  It is safe to say Y, but you probably don't need this.
>  
> +config UML_USE_HOST_STRINGS
> +	bool
> +	default y
> +	prompt "Use glibc strings and memory functions"
> +	help
> +	  UML runs as a normal userspace process. As a result it can use
> +	  the optimized strcpy, memcpy, etc from glibc instead of the
> +          kernel generic equivalents. This provides some minimal speedup
> +	  in the 1% or so range for most applications. It also results in
> +	  a smaller executable.

Looks like some inconsistent tab/spaces indentation there :)

> +++ b/arch/um/os-Linux/string.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> + */
> +
> +#include <stddef.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <os_string.h>
> +
> +inline char *os_strcpy(char *dest, const char *src)

those 'inline' annotations seem strange - they can't possibly do
anything useful here?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

