Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86AEC3ABC5
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 03:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LAjmB/BuVJhNma0CNS0ZtI4c20tsdSol77PmLcH6eY=; b=t9uvjazqhx/iN8Dh4aLCpJQsh9
	MPWwyx/cQF3T7Nkoqb2OYLbumQSZtIcaAJ4WM/CetDmwonwq6C6R5XSNPlan4eEJ631am8VjfUTWh
	1TDefevNzyyMfT7nmmBidp+8uY5uqgxCDXyMagX8eiYi4KADKaGP4nctZ8nV1IBfF/YQlwm7yqWbG
	nBNcMzzlu7UwUv98P3zz/6dHtH2aP18D/U02ywDZPYC54Esayi/8UhccCdbu8Pkw25l4YoAVzEDqW
	yoOFUJWTcLedgjNXR/ukJCLTwQlA0oWlm+AEndZ8T9TN9DNUD4HKQiXp18Dg+etwuw1HK6cIZ7XMH
	fldX/ydw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCVkG-0000000E7kQ-00sE;
	Wed, 07 May 2025 03:46:56 +0000
Received: from abb.hmeau.com ([144.6.53.87])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCTnf-0000000Drkc-1wx9
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 01:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1LAjmB/BuVJhNma0CNS0ZtI4c20tsdSol77PmLcH6eY=; b=OddfQllTz1VCGdH1DC80AhtUTj
	U6FW8c5ZWAC7ure5nx1gtrPgd+TAmQb0hJHi3p6QbulxogVmqvMk2UcXWtJfcX5y/oitHXbM0ht7o
	uiGxNKho6OzxhM7bFJ03FWds1Ys8eMFKI3KE4B+8irwgZTkc20jajPvfTmf+tImmK6SZl8jVjhLC2
	wM4EsuTBCbDoLdpBCOmCm3ktcwHMZt5Anvx8qqwT1Tgeh9XJwRYEfVvukbDNjeb8wUgVDwwIiJswp
	P4XSNQD3c6JRR/QhO3nrFuu7q0YNaZNpJVa7FZKmITCdKoOT07xxZAffA4KrU6xiO24RjMviJhLgZ
	JKAxbzpQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uCTnD-0046hM-2g;
	Wed, 07 May 2025 09:41:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 May 2025 09:41:51 +0800
Date: Wed, 7 May 2025 09:41:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-crypto@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH] um: Include linux/types.h in asm/fpu/api.h
Message-ID: <aBq6X-UYlQG9HUQd@gondor.apana.org.au>
References: <202505070045.vWc04ygs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505070045.vWc04ygs-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_184219_503438_0DACE64D 
X-CRM114-Status: GOOD (  14.44  )
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

On Wed, May 07, 2025 at 12:25:45AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> head:   9b9d4ef0cf750c514735bfd77745387b95cbddda
> commit: 5b90a779bc547939421bfeb333e470658ba94fb6 [50/70] crypto: lib/sha256 - Add helpers for block-based shash
> config: um-randconfig-001-20250506 (https://download.01.org/0day-ci/archive/20250507/202505070045.vWc04ygs-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505070045.vWc04ygs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505070045.vWc04ygs-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from lib/crypto/sha256.c:14:
>    In file included from include/crypto/internal/sha2.h:6:
>    In file included from include/crypto/internal/simd.h:9:
>    In file included from arch/x86/include/asm/simd.h:5:
> >> arch/um/include/asm/fpu/api.h:14:15: error: unknown type name 'bool'
>       14 | static inline bool irq_fpu_usable(void)
>          |               ^
> >> arch/um/include/asm/fpu/api.h:16:9: error: use of undeclared identifier 'true'
>       16 |         return true;
>          |                ^
>    2 errors generated.

I'll add this to the crypto tree if it's OK with the UML maintainers.

Thanks,

---8<---
Include linux/types.h before using bool.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505070045.vWc04ygs-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
index 71bfd9ef3938..3abf67c83c40 100644
--- a/arch/um/include/asm/fpu/api.h
+++ b/arch/um/include/asm/fpu/api.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_UM_FPU_API_H
 #define _ASM_UM_FPU_API_H
 
+#include <linux/types.h>
+
 /* Copyright (c) 2020 Cambridge Greys Ltd
  * Copyright (c) 2020 Red Hat Inc.
  * A set of "dummy" defines to allow the direct inclusion
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

