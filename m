Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6663CAC5A0
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljaNSHFaAB7vPIqRAfpf2zZp/E4Kj5AHAbIRWmCt5G8=; b=tsrtlJqaeP38N1PVEuVexq1srh
	TJaLqgCkoLi+dntylurHz9yBwKnqJTO2ohtLMtnZO3HLjiuyyLghxAa5FwURNbE8Ho1GZGkW2WcJH
	dgi0W8BuDFUWk7xf0wA0mAGXM3N9Cr0UukSi48VU/ZawJYwxQrdpUODgBzsj5SZfQDhDCI4jc2r10
	qLtWgNoMeSPoMDB0ZAreduk6+RPkS2lTTz/S2yA9zeorAUxhqtyjamDxv5qe54tX9sHUMblr0/pTA
	UqVN7yRPtcSR700I1+dKjCp5vgViIHmFJfG2z1Yjn7GZObszE6J2o8zshdLTqDkCsfOMy2GOy2ic2
	rXRktPiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztsQ-000000057Pp-14Ud;
	Sat, 20 Sep 2025 09:27:30 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uztsO-000000057On-2UNo
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 09:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758360445;
	bh=z6nFBm/6KBHsni14dRJDIKagzxF52mvycFfafnL7LV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltSH3R6av551BbQt6pulW0ogU5VDIjQhgZtgt67XKFU+AnExhcUEA+6ZaKpO1ctfb
	 7Ju7J7ukHtTXVEq+aQanFmS7PAddtImfcNNxepeZqisfDq7dgSJnv4irflKsdKofkP
	 wy+T7iMxrverwhW+LWCxINdIF8gmPnJOHkL2OFKU=
Date: Sat, 20 Sep 2025 11:27:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 10/11] tools/nolibc: add ptrace support
Message-ID: <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-11-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-11-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_022728_812681_054C98AE 
X-CRM114-Status: GOOD (  18.65  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2025-09-19 17:34:19+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add ptrace support, as it will be useful in UML.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 +
>  4 files changed, 56 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/ptrace.h

(...)

> diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
> new file mode 100644
> index 000000000000..3119abdeeecb
> --- /dev/null
> +++ b/tools/include/nolibc/sys/ptrace.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * ptrace for NOLIBC
> + * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +/* make sure to include all global symbols */
> +#include "../nolibc.h"
> +
> +#ifndef _NOLIBC_SYS_PTRACE_H
> +#define _NOLIBC_SYS_PTRACE_H
> +
> +#include "../sys.h"
> +#include "uio.h"
> +
> +
> +#include <linux/ptrace.h>
> +
> +/*
> + * long ptrace(int op, pid_t pid, void *addr, void *data);
> + *
> + * However, addr may also be an integer in some cases.

This comment is a bit confusing. It reads like it can be an integer as
in 'int' datatype. But the kernel expects an integer compatible with
'void *', so 'unsigned long'. I think we can drop the comment.

> + */
> +static __attribute__((unused))
> +long sys_vptrace(int op, pid_t pid, va_list args)
> +{
> +	return my_syscall4(__NR_ptrace, op, pid,
> +			   va_arg(args, void *), va_arg(args, void *));
> +}
> +
> +static __attribute__((unused))
> +ssize_t sys_ptrace(int op, pid_t pid, ...)

ptrace(2) does not document addr and data to be optional.
While it does acknowledge the fact that it is variadic on glibc,
users are still recommended to always supply all arguments.
I'd prefer to keep it simple and avoid the va_list.

> +{
> +	va_list args;
> +
> +	va_start(args, pid);
> +	return sys_vptrace(op, pid, args);
> +	va_end(args);
> +}
> +
> +static __attribute__((unused))
> +ssize_t ptrace(int op, pid_t pid, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, pid);
> +	return __sysret(sys_vptrace(op, pid, args));
> +	va_end(args);
> +}
> +
> +#endif /* _NOLIBC_SYS_PTRACE_H */

(...)

