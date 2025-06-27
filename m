Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14000C7EE2A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 05:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLmyL3lNy2QBtuenWSQCFpmIgg5YkMY9f6KTQYjjHMo=; b=lz3XhlHZErWKAup6mOnSSKYCk0
	QtlopCaN4E4L710dan1h/M6E/8qbnNUTWJClqLfeDW+Sa+Tth6VShufnBVOLD2b1BdoqkmQKG3RZP
	IqQkRmWfWOAdGNqgcQFb2nHQll2rMbSzGF7752Y+Uk9/gQ9AiQlksyS8B/slSxK/dICpQ0vOcrYkK
	GwCpjd/aedI+sgzWPSoGX2snQMwSoBEnbobE9YxVtFsBSfcWLmB/p/F7h4nScRtfAJX0A01k/3nOk
	ln41L75EwOMBBx/zVt+KN4jtsBUelgQcpxv11hay/0l2qDBNhDI++Zv4VZgHCrYeCi8109dEhP8BJ
	vEhWqYCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV1JL-0000000DbVy-2SX8;
	Fri, 27 Jun 2025 05:07:39 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV1DB-0000000Dawt-1ydI
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 05:01:18 +0000
Date: Fri, 27 Jun 2025 07:01:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751000473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLmyL3lNy2QBtuenWSQCFpmIgg5YkMY9f6KTQYjjHMo=;
	b=sY/qDFaGhPcTTRd5sQQRbrYMTzHwVHisKylYABz+VX0iGcqdCmypuDchD3uafTsYiEfxqy
	NJbvjmIaUXNzNEMQmuYM95hG3YQUbqRQIVyhEnEG6JG+UlvSjG+VHD77RBsxcWL2k0nSqv
	J5A6XfDO25RY85R68GLQYLJIWEha3vroMQMyEtvMOaCwGY0Xgt1Pqh/8BP2de+k2LqedY+
	i3z4aAXlsJiMi2JoO/owHtyel+WsFeaAm3KU9fwFNMDoUltWv3ofpi6pIQ3b5sXBvPdzmi
	C2enEF50OQKyEdNGd/A1wcKl8zd5x8AyInBCcxTxhdEldIuYQ/nDbmN7rnXaSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751000473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLmyL3lNy2QBtuenWSQCFpmIgg5YkMY9f6KTQYjjHMo=;
	b=pnxmTt3jAIxlItvERpjsFcFLOeAeri4qfdic464HwQl8vJzxDduI/UIbpqCo/C6CCjFAM7
	73uBjJcvCCQbmABg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [RFC 2/2] um: add a mcontext FP register handling test
Message-ID: <20250627064919-a0f8a958-1b09-4b58-99d3-b0c91d513b21@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
 <20250626195714.2123694-3-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626195714.2123694-3-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_220117_657839_BEA85154 
X-CRM114-Status: GOOD (  22.39  )
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

On Thu, Jun 26, 2025 at 09:57:14PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This tests checks whether floating point registers are properly saved
> into the signal context and restored again. The test works by having a
> known value at the top of the FP register stack and in the first xmm
> register. Then SIGUSR1 is triggered and both of these registers are
> modified by changing the values in the mcontext.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/x86/um/Makefile                     |   2 +
>  arch/x86/um/tests/Makefile               |  12 +++
>  arch/x86/um/tests/registers.c            |  22 +++++
>  arch/x86/um/tests/test-fp-save-restore.c | 118 +++++++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 arch/x86/um/tests/Makefile
>  create mode 100644 arch/x86/um/tests/registers.c
>  create mode 100644 arch/x86/um/tests/test-fp-save-restore.c
> 
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index b42c31cd2390..410f5526f1f4 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -15,6 +15,8 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
>  	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
>  	mem_$(BITS).o subarch.o os-Linux/
>  
> +obj-y += tests/
> +
>  ifeq ($(CONFIG_X86_32),y)
>  
>  obj-y += syscalls_32.o
> diff --git a/arch/x86/um/tests/Makefile b/arch/x86/um/tests/Makefile
> new file mode 100644
> index 000000000000..c3a868b078f3
> --- /dev/null
> +++ b/arch/x86/um/tests/Makefile
> @@ -0,0 +1,12 @@
> +include $(srctree)/init/Makefile.nolibc
> +
> +ccflags-y := -I$(obj)

As mentiond before, I'd like to find out why you need this.

> +um-tests-y += registers.o
> +
> +userprogs += test-fp-save-restore
> +test-fp-save-restore-userccflags := -static $(NOLIBC_USERCFLAGS) -msse
> +
> +obj-$(CONFIG_KUNIT_UAPI) += um-tests.o

Create a dedicated Kconfig option for this.
Not everybody who has enabled the framework wants to include these testcases.
Also the tests can stay in a module even if CONFIG_KUNIT_UAPI=y.

> +
> +$(obj)/registers.o: $(obj)/test-fp-save-restore
> diff --git a/arch/x86/um/tests/registers.c b/arch/x86/um/tests/registers.c
> new file mode 100644
> index 000000000000..2c4e55da043c
> --- /dev/null
> +++ b/arch/x86/um/tests/registers.c
> @@ -0,0 +1,22 @@
> +#include <kunit/test.h>

> +#include <kunit/test-bug.h>

Unnecessary.

> +#include <kunit/uapi.h>
> +
> +static void test_mcontext(struct kunit *test)
> +{
> +	KUNIT_UAPI_EMBED_BLOB(test_fp_save_restore, "test-fp-save-restore");

Any reason to have different names between the userprog and the testcase?
Keeping them consistent will make it easier for the user.

> +
> +	kunit_uapi_run_kselftest(test, &test_fp_save_restore);
> +}
> +
> +static struct kunit_case register_test_cases[] = {
> +	KUNIT_CASE(test_mcontext),
> +	{}
> +};
> +
> +static struct kunit_suite register_test_suite = {
> +	.name = "um_registers",
> +	.test_cases = register_test_cases,
> +};
> +
> +kunit_test_suites(&register_test_suite);
> diff --git a/arch/x86/um/tests/test-fp-save-restore.c b/arch/x86/um/tests/test-fp-save-restore.c
> new file mode 100644
> index 000000000000..28a32ca374fe
> --- /dev/null
> +++ b/arch/x86/um/tests/test-fp-save-restore.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test FP register handling in userspace mcontext.
> + *
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +#include <math.h>
> +#include <signal.h>

> +#include <types.h>

types.h is specific to nolibc. Can probably just be dropped.

> +#include <unistd.h>
> +#include <string.h>
> +#include <sys.h>

sys.h is specific to nolibc. Use a standard header instead.

> +#include <asm/sigcontext.h>
> +#include <asm/ucontext.h>
> +
> +#include "../../../tools/testing/selftests/kselftest.h"

I can't say anything about the actual tests.

<snip>

