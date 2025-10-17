Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A23CCFA1E
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhepguEQ0VZAS3etCeAAj5D/xXUqupnQ1wf0VPifqWY=; b=bYcTQdhhBWBrdKWKt3ZNtMMdad
	8B+eSyllnbvnNQniPpS3JvdKbNTze5VxWxo3UoBdKUiGrvDzqdu1ONfca+gFBZib6LXKYlt/j2O2j
	2MrocfziHCRf8xkTRpwfuImWm1kYUSN1iX7BzYe57bwDG5Ki/kya+wqyD2a9NOAxrtWWIjmsJh23c
	j/6YVKRxSrpwQlW5b22mz0jAg/6zVZQepnvRWv8vmKvaolimu03rsQ5uz8PRSrb2EIxEEH0CIQA4Y
	C5ERohPUty3M09LA9/iTDGYwU6k8ReNGT+9gHnmREGvVcGStn7vbRBUfHI0x97yDrOkdgW7Pi7Osg
	cHy0rjqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHlr7-00000003GuP-3PSo;
	Sat, 08 Nov 2025 16:32:01 +0000
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.12.53.23])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9gW4-00000007F1s-2eT7;
	Fri, 17 Oct 2025 09:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760692372; x=1792228372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FhepguEQ0VZAS3etCeAAj5D/xXUqupnQ1wf0VPifqWY=;
  b=GRFi+xJjt+cUUVOZ7+0RT+vkw280WDvlMR6IcoB020yJyOca67KXWu5f
   S8amOt369dD+z5U7WTNRjQoao9gTmU6r4DrZImXRKOvO5WD3NYBvxyDjD
   70ohBZcFhCo7NO5i9FOZn6rOAzVvF887NsrnY9alQio6mm0rfobmIitla
   tn+YsUGS/ov+prH9hlfUK7swjhF3l1Pvwup79u9V3f5RVbCVlBqKZtgFD
   Bh/+rPIb3ykAm+Vjmo8qFjSEzqVSseVt640PsjsRn36zIz0cVJul7X9DT
   dJLFaCNSJiGuLwqqdumZ78KsgPuSHcYVAKHC41VnBLNutrMK7U4oXx/LV
   Q==;
X-CSE-ConnectionGUID: cM8Z2YstQzm6dtOVWhxkWw==
X-CSE-MsgGUID: qOrZmNbiSUqAkZSp6Df7tQ==
X-IronPort-AV: E=Sophos;i="6.19,236,1754956800"; 
   d="scan'208";a="4952368"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:12:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:10487]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 1bae93ec-5b8e-4b5e-806a-50905ec4eaf8; Fri, 17 Oct 2025 09:12:51 +0000 (UTC)
X-Farcaster-Flow-ID: 1bae93ec-5b8e-4b5e-806a-50905ec4eaf8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 17 Oct 2025 09:12:43 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 17 Oct 2025
 09:12:28 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<tony.luck@intel.com>, <qiuxu.zhuo@intel.com>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <rric@kernel.org>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
	<mihail.atanassov@arm.com>, <brian.starkey@arm.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <sean@poorly.run>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <fery@cypress.com>,
	<dmitry.torokhov@gmail.com>, <agk@redhat.com>, <snitzer@redhat.com>,
	<dm-devel@redhat.com>, <rajur@chelsio.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <malattia@linux.it>,
	<hdegoede@redhat.com>, <mgross@linux.intel.com>, <intel-linux-scu@intel.com>,
	<artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>, <clm@fb.com>,
	<josef@toxicpanda.com>, <dsterba@suse.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>,
	<herve.codina@bootlin.com>, <Jason@zx2c4.com>, <keescook@chromium.org>,
	<kbusch@kernel.org>, <nathan@kernel.org>, <bvanassche@acm.org>,
	<ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <linux-mm@kvack.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<tipc-discussion@lists.sourceforge.net>
CC: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mateusz Guzik
	<mjguzik@gmail.com>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 23/27 5.10.y] minmax.h: reduce the #define expansion of min(), max() and clamp()
Date: Fri, 17 Oct 2025 09:05:15 +0000
Message-ID: <20251017090519.46992-24-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017090519.46992-1-farbere@amazon.com>
References: <20251017090519.46992-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.116.181]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_021252_746516_8CA4CCD8 
X-CRM114-Status: GOOD (  12.75  )
X-Mailman-Approved-At: Sat, 08 Nov 2025 08:31:10 -0800
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

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit b280bb27a9f7c91ddab730e1ad91a9c18a051f41 ]

Since the test for signed values being non-negative only relies on
__builtion_constant_p() (not is_constexpr()) it can use the 'ux' variable
instead of the caller supplied expression.  This means that the #define
parameters are only expanded twice.  Once in the code and once quoted in
the error message.

Link: https://lkml.kernel.org/r/051afc171806425da991908ed8688a98@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 24e4b372649a..6f7ea669d305 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,10 +46,10 @@
  * comparison, and these expressions only need to be careful to not cause
  * warnings for pointer use.
  */
-#define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
-#define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
-#define __sign_use(x, ux) (is_signed_type(typeof(ux)) ? \
-	__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
+#define __signed_type_use(ux) (2 + __is_nonneg(ux))
+#define __unsigned_type_use(ux) (1 + 2 * (sizeof(ux) < 4))
+#define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
+	__signed_type_use(ux) : __unsigned_type_use(ux))
 
 /*
  * Check whether a signed value is always non-negative.
@@ -71,13 +71,13 @@
 #else
   #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L))
 #endif
-#define __is_nonneg(x, ux) statically_true((__signed_type(ux))(x) >= 0)
+#define __is_nonneg(ux) statically_true((__signed_type(ux))(ux) >= 0)
 
-#define __types_ok(x, y, ux, uy) \
-	(__sign_use(x, ux) & __sign_use(y, uy))
+#define __types_ok(ux, uy) \
+	(__sign_use(ux) & __sign_use(uy))
 
-#define __types_ok3(x, y, z, ux, uy, uz) \
-	(__sign_use(x, ux) & __sign_use(y, uy) & __sign_use(z, uz))
+#define __types_ok3(ux, uy, uz) \
+	(__sign_use(ux) & __sign_use(uy) & __sign_use(uz))
 
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -92,7 +92,7 @@
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
 	__auto_type ux = (x); __auto_type uy = (y);	\
-	BUILD_BUG_ON_MSG(!__types_ok(x, y, ux, uy),	\
+	BUILD_BUG_ON_MSG(!__types_ok(ux, uy),		\
 		#op"("#x", "#y") signedness error");	\
 	__cmp(op, ux, uy); })
 
@@ -109,7 +109,7 @@
 	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
 			(lo) <= (hi), true),					\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
-	BUILD_BUG_ON_MSG(!__types_ok3(val, lo, hi, uval, ulo, uhi),		\
+	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
 	__clamp(uval, ulo, uhi); })
 
@@ -149,7 +149,7 @@
 
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
 	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
-	BUILD_BUG_ON_MSG(!__types_ok3(x, y, z, ux, uy, uz),		\
+	BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),			\
 		#op"3("#x", "#y", "#z") signedness error");		\
 	__cmp(op, ux, __cmp(op, uy, uz)); })
 
-- 
2.47.3


