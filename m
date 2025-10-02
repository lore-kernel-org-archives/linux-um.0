Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7011ACAC5B8
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/92zpxyjeHvGlOVhJoOGNENC+jRdBRPJKKvWmFCfMhU=; b=lPd2rB+thaipKG1PavdtU9Jupt
	kka2jyEYj3NOuJxjDa/Ewt03MpnTCplG5dLVx051QcvQNN/CLsN3/dDNwZj+KiNd7X4i+5tr2m55T
	atmV/x7/3ITH5HUf5StNbW/N7fH1GpA7vs+HQQHOS+7taRYQjxKtzXhLbPICMlxXet0m7x8U45s+D
	ikzNHPL188KaiU9BkYbvYXfpHWvH6glCMJTm3ZJ4TA+lSUOP8a2+6BIs+9B9NFmpY0sRfX3dDvq/2
	Ia2O3vQLFEzT4xXF4ACckVAgP7Mp8mRi+lRODaJ7TDQuOTSI8tYYzHQRq61BnacHr/U4Xf9JDGAWV
	UbbG6kDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k9Y-0000000HaKa-4BGl;
	Mon, 06 Oct 2025 12:17:21 +0000
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([52.28.197.132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4QF2-0000000BCZY-0W1U;
	Thu, 02 Oct 2025 20:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759438172; x=1790974172;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/92zpxyjeHvGlOVhJoOGNENC+jRdBRPJKKvWmFCfMhU=;
  b=TN1x3zxxRW3K5skGRiaa2Mwe0pqNJIPU54+dTUNUo09eFtgk4tp+v+cO
   vrHc8Z3Eb4XfE4gNb4XTgfBfmjTm51KaIzM+Jr1J5l1Bu17GtkLLrfzQT
   RCZSFZPLe8oZ0+fj3RcMcEIYIWLKXeV27WPy5Ryf4mxgJo44tE3D5aD4B
   6If4IYQ3CTEqXHGlUh8TS1IeVoYO8Wj0qO87RpiGIceU98c46X3EeSwHB
   VD7jg8Tb+GIcsXz+jrWaf27hle1WDYrUHoQGokSiEE36W9RHxmuwWdirG
   mFflb8Y/rYWjpriT9k7rjBOdzCSK65S8DhqTYDuxmGY8EBE0+VGNjYLOY
   Q==;
X-CSE-ConnectionGUID: XeKnj1e6T4m4kCy3QmKu5g==
X-CSE-MsgGUID: BnWh0oe1SOiv0ynMIzPDUw==
X-IronPort-AV: E=Sophos;i="6.18,310,1751241600"; 
   d="scan'208";a="2928085"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 20:49:29 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:15874]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.16:2525] with esmtp (Farcaster)
 id b42f11f5-8c2e-4cce-aeac-cbfeeafa7e73; Thu, 2 Oct 2025 20:49:29 +0000 (UTC)
X-Farcaster-Flow-ID: b42f11f5-8c2e-4cce-aeac-cbfeeafa7e73
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 20:49:20 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 2 Oct 2025
 20:48:55 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <james.morse@arm.com>,
	<rric@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linus.walleij@linaro.org>,
	<dmitry.torokhov@gmail.com>, <maz@kernel.org>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@canonical.com>,
	<malattia@linux.it>, <hdegoede@redhat.com>, <mgross@linux.intel.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<sakari.ailus@linux.intel.com>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<senozhatsky@chromium.org>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>,
	<pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <shuah@kernel.org>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<quic_akhilpo@quicinc.com>, <ruanjinjie@huawei.com>,
	<David.Laight@ACULAB.COM>, <herve.codina@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-um@lists.infradead.org>, <linux-edac@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
	<linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>,
	<linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 03/19 5.15.y] minmax: deduplicate __unconst_integer_typeof()
Date: Thu, 2 Oct 2025 20:47:17 +0000
Message-ID: <20251002204733.35652-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002204733.35652-1-farbere@amazon.com>
References: <20251002204733.35652-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.116.181]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_134932_457049_6BA57653 
X-CRM114-Status: GOOD (  11.61  )
X-Mailman-Approved-At: Mon, 06 Oct 2025 05:16:29 -0700
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5e57418a2031cd5e1863efdf3d7447a16a368172 ]

It appears that compiler_types.h already have an implementation of the
__unconst_integer_typeof() called __unqual_scalar_typeof().  Use it
instead of the copy.

Link: https://lkml.kernel.org/r/20230911154913.4176033-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index aac0b7d23768..62b0c0a3cf30 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -168,27 +168,6 @@
  */
 #define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
 
-/*
- * Remove a const qualifier from integer types
- * _Generic(foo, type-name: association, ..., default: association) performs a
- * comparison against the foo type (not the qualified type).
- * Do not use the const keyword in the type-name as it will not match the
- * unqualified type of foo.
- */
-#define __unconst_integer_type_cases(type)	\
-	unsigned type:  (unsigned type)0,	\
-	signed type:    (signed type)0
-
-#define __unconst_integer_typeof(x) typeof(			\
-	_Generic((x),						\
-		char: (char)0,					\
-		__unconst_integer_type_cases(char),		\
-		__unconst_integer_type_cases(short),		\
-		__unconst_integer_type_cases(int),		\
-		__unconst_integer_type_cases(long),		\
-		__unconst_integer_type_cases(long long),	\
-		default: (x)))
-
 /*
  * Do not check the array parameter using __must_be_array().
  * In the following legit use-case where the "array" passed is a simple pointer,
@@ -203,13 +182,13 @@
  * 'int *buff' and 'int buff[N]' types.
  *
  * The array can be an array of const items.
- * typeof() keeps the const qualifier. Use __unconst_integer_typeof() in order
+ * typeof() keeps the const qualifier. Use __unqual_scalar_typeof() in order
  * to discard the const qualifier for the __element variable.
  */
 #define __minmax_array(op, array, len) ({				\
 	typeof(&(array)[0]) __array = (array);				\
 	typeof(len) __len = (len);					\
-	__unconst_integer_typeof(__array[0]) __element = __array[--__len]; \
+	__unqual_scalar_typeof(__array[0]) __element = __array[--__len];\
 	while (__len--)							\
 		__element = op(__element, __array[__len]);		\
 	__element; })
-- 
2.47.3


