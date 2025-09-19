Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678CFCAC5B8
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JRUlUXU3Dk+icKuiOL9Xs0c0wDaZV6bPawHQ91OSf6I=; b=cfANLtevECk9crIN6CPLHQ/9Om
	Zv73FvhR/oj4h/MfJntiBpB7YpTp87UOr3ud+iWhohUjkJSB2XkTRUxtvwiNCjUsNGa2SOo8zO2pw
	zl0x682JVcGae9RzR7W6bZThHFH1s3Y2Qxm+Xwp6ei3NC89OvOGDaY6s0blucnSNekkFFPq/ybmPS
	MUJIiKQn4N3YcvQK7W8fP5j+rh+yIvnstaRuXL5vvGxXKAcwVf6tAl29ayVz6LC6RPTsmDEmFf5EK
	Lu9EwfaqFXlfc9RAq89ZSJ/it/apV0uVJ9YGu5tcMFh47Yigs/qG9VegzAuWoIaNRi+SiWfGF12Sg
	CSEipHpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k8s-0000000HZHT-2q1x;
	Mon, 06 Oct 2025 12:16:38 +0000
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([18.197.217.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzYLY-00000002ZBD-1QLp;
	Fri, 19 Sep 2025 10:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758277688; x=1789813688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRUlUXU3Dk+icKuiOL9Xs0c0wDaZV6bPawHQ91OSf6I=;
  b=COYRGIa4CeNuHz1SznnWzpwJxIsa0GxeWH2c4YgFNOGpf+THfwOA5+6G
   xexyTujDw3U7MtJeKsCLKnpJw3zubJUAmp1w1CtnnZ9IphCFiuFknrZsF
   ZOh3T7d/qaIOuN+838zA2eaEpr0eOUi4Usn3Xl/nSYnSYgdz47wyLElXF
   lcAr7Xi0XYd0cKGNpXcoJ5ypz5bjoFasOqga/HwrwN0BYIkyWMD/xfWdw
   XQf3RTY9tYMfQg+kWGWh1rdcSMX3XKgYvjCUhjZI2o/fW78oLr7sYqS2P
   GNhL4UuYuEABfTjwqZSEybwbMTjbW2FzjX4Q3J9UtYo7UuRgNA+Vo7LBQ
   Q==;
X-CSE-ConnectionGUID: k0041p2hSZicGj9SBzuyeQ==
X-CSE-MsgGUID: NEhkCUfaSzGxvja9LkAB8g==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2369813"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:27:58 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:2448]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id 0c644fca-fa1d-4734-b200-ca1980af847d; Fri, 19 Sep 2025 10:27:57 +0000 (UTC)
X-Farcaster-Flow-ID: 0c644fca-fa1d-4734-b200-ca1980af847d
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 10:27:42 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 19 Sep 2025
 10:27:13 +0000
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <jdike@addtoit.com>, <richard@nod.at>,
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
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <clm@fb.com>, <josef@toxicpanda.com>,
	<dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <pmladek@suse.com>,
	<sergey.senozhatsky@gmail.com>, <andriy.shevchenko@linux.intel.com>,
	<linux@rasmusvillemoes.dk>, <minchan@kernel.org>, <ngupta@vflare.org>,
	<akpm@linux-foundation.org>, <kuznet@ms2.inr.ac.ru>,
	<yoshfuji@linux-ipv6.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <jmaloy@redhat.com>, <ying.xue@windriver.com>,
	<willy@infradead.org>, <farbere@amazon.com>, <sashal@kernel.org>,
	<ruanjinjie@huawei.com>, <David.Laight@ACULAB.COM>,
	<herve.codina@bootlin.com>, <Jason@zx2c4.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<linux-edac@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
	<freedreno@lists.freedesktop.org>, <linux-hwmon@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-btrfs@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<linux-mm@kvack.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <tipc-discussion@lists.sourceforge.net>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"David Laight" <David.Laight@aculab.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
Subject: [PATCH 17/27 5.10.y] minmax: don't use max() in situations that want a C constant expression
Date: Fri, 19 Sep 2025 10:17:17 +0000
Message-ID: <20250919101727.16152-18-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919101727.16152-1-farbere@amazon.com>
References: <20250919101727.16152-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.116.181]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_032808_665554_914CE1A4 
X-CRM114-Status: GOOD (  13.89  )
X-Mailman-Approved-At: Mon, 06 Oct 2025 05:16:26 -0700
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit cb04e8b1d2f24c4c2c92f7b7529031fc35a16fed ]

We only had a couple of array[] declarations, and changing them to just
use 'MAX()' instead of 'max()' fixes the issue.

This will allow us to simplify our min/max macros enormously, since they
can now unconditionally use temporary variables to avoid using the
argument values multiple times.

Cc: David Laight <David.Laight@aculab.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/input/touchscreen/cyttsp4_core.c | 2 +-
 fs/btrfs/tree-checker.c                  | 2 +-
 lib/vsprintf.c                           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 02a73d9a4def..c10140c9aafa 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -857,7 +857,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[MAX(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 35b94fe5e78e..cba6293d5574 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -587,7 +587,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[MAX(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b08b8ee1bbc0..90372391ce90 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1078,7 +1078,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+	char sym[MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
-- 
2.47.3


