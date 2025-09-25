Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AEBCAC5B1
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asg/wIOQU6oTMSdWU7AhpZft64WmK9LC+UVPup9kdTI=; b=oMZgh/GGHdH1BbR4I0druO+a2v
	wPlPKdc7EYEn2FhopoEhAJuqBKJF5UKVGCjd3E+guimL6yLRSDI2UOay3UT3m2voPo3kEG4/cYn+u
	qj387E9j9ptuN/kGE26RZ1XpE5Xm74U03T691iB3Mbgo6qFesowGRyE2nMutVjwSbOKoRtwNSuYz3
	1TTN9oTHbO2yJ2YjmmHavnuIN65ac7ItJI/8e3npO+MSY7EC3isTAp0kF3exM/BJKQxwCKpVmB4To
	FaO1EZWAfGDADBlKCthBvhfr3IIQ6u94Iv30Au+Vx/LPClu4xCoGzoPRTCJbppXLIg0t8/KDhqNCs
	l36gWmEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1opt-0000000B7cD-35JD;
	Thu, 25 Sep 2025 16:28:49 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1opr-0000000B7Yo-08f6
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 16:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817723;
	bh=ViftyZNJLwL+w43YF2pKIJLCB+qRR8fKArxSDZUl458=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq19cwaR8MNLNlnMZiQ/x32HF5WWgKHLRObfDyvuEuTzGRcJ88eLayfIB4O2kkbv4
	 EX67BIPp6RGg9Orbsm5ZMVm0m/HXmjHM2O62YDyPxgG4qfvzydL2Dt9P6vXLXFBpbd
	 j9C8/0tJhURuk6CvyrVL7zFnM5iLGyi8vTuSNep4=
Date: Thu, 25 Sep 2025 18:28:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 11/12] tools/nolibc: add ptrace support
Message-ID: <b2f2a592-da69-4fdb-8d84-8354895b3295@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-12-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924142059.527768-12-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_092847_247131_6E140926 
X-CRM114-Status: GOOD (  18.36  )
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

On 2025-09-24 16:20:58+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add ptrace support, as it will be useful in UML.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> v3:
> - Only use variardic for ptrace and not for sys_ptrace
> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 +
>  4 files changed, 48 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/ptrace.h

(...)

> diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
> new file mode 100644
> index 000000000000..5d1e52965878
> --- /dev/null
> +++ b/tools/include/nolibc/sys/ptrace.h
> @@ -0,0 +1,44 @@
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
> + */
> +static __attribute__((unused))
> +long sys_ptrace(int op, pid_t pid, void *addr, void *data)
> +{
> +	return my_syscall4(__NR_ptrace, op, pid, addr, data);
> +}
> +
> +static __attribute__((unused))
> +ssize_t ptrace(int op, pid_t pid, ...)
> +{
> +	ssize_t ret;
> +	va_list args;
> +
> +	va_start(args, pid);
> +	ret = __sysret(sys_ptrace(op, pid,
> +				  va_arg(args, void *),
> +				  va_arg(args, void *)));
> +	va_end(args);

My understanding of the last discussion was not to use varargs here
either. Instead I wanted to stick to the prototype from the manpage.

> +
> +	return ret;
> +}
> +
> +#endif /* _NOLIBC_SYS_PTRACE_H */

(...)

