Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593BCCA471
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KzVc5pQt1xJae1laTHwFTkgfsVttwXUFIKNqt4L9XFg=; b=Pr5a4JR17V6/Ob
	zKz8rPIOBFtkSeUsAD2RlpkzBEhXxlokCD1RRH/fIjdlAt/6sdSTjNyUZ9pGUpfepft667ZYGY4Aq
	kLpZKf8+Rko8fCrgC6gprz+9b7vEixlLJY6eYZnfEz1FHOuRWeq639NP6Gt/x3ZH/1NwWFjEZVg+T
	W93amwayj37HYqJDpp5kdoAt5c1F4qfIg/DCqs6xAlLdBj/Tpqh46kcKayyQztXVZL1kxeuHMCB+0
	i2V1xFRoXysKYbPtsOKoM2YllyNbBSMLOcr0pkzxZBRsxacYdu9OSJm4kbvnsu0ZOZBuHthNm9cxl
	nVnWdIRFsX62YTX8ZXKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k9L-0000000HZwf-1UDY;
	Mon, 06 Oct 2025 12:17:07 +0000
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([52.28.197.132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W29-00000003RFX-1i7G;
	Wed, 24 Sep 2025 20:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758745453; x=1790281453;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KzVc5pQt1xJae1laTHwFTkgfsVttwXUFIKNqt4L9XFg=;
  b=XhCfJ/4/IEdAKOrM3wLUEaY97NtjBR0u6/nsqxgNo4NBpnWN7e8yUuKF
   Gn5S+w2kw500qEj2TOaW03nOM6ORjIaq+OcBeONhsQ8NBnykb4U3mbZKo
   KHEIeu/7rZjWKuUi9yeF6Fiv4zd4ScGW2PDjxQ1yp53/xzEL3hv3of+dU
   jX0VnNIUi+/Ye+7ZvR//AJYLRWe532pbO/Ndimj88e1g7I0XWBSzRuS1G
   qcTO+oLQchgFyE58oyijJKDNadykZISN27Iz8crO9vMcO3SasaFUykhkq
   Frh7Bn4cbkJ+ZUt3qjYIH3NL8dUWMGbzcr/kCl0BqYuhg+rJcZA5uLw90
   A==;
X-CSE-ConnectionGUID: +bpb7ezGQtmV8E8VA8qXRA==
X-CSE-MsgGUID: SFde7s01RFKi6zh/6W6ZSQ==
X-IronPort-AV: E=Sophos;i="6.18,291,1751241600"; 
   d="scan'208";a="2525915"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 20:24:01 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:12397]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.5.254:2525] with esmtp (Farcaster)
 id d8c58b1d-ca7d-4c1f-a53d-72dcf5ba6a6f; Wed, 24 Sep 2025 20:24:01 +0000 (UTC)
X-Farcaster-Flow-ID: d8c58b1d-ca7d-4c1f-a53d-72dcf5ba6a6f
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 20:24:00 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 24 Sep 2025
 20:23:26 +0000
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
	<hpa@zytor.com>, <tony.luck@intel.com>, <qiuxu.zhuo@intel.com>,
	<mchehab@kernel.org>, <james.morse@arm.com>, <rric@kernel.org>,
	<harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<evan.quan@amd.com>, <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
	<mihail.atanassov@arm.com>, <brian.starkey@arm.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
	<dmitry.baryshkov@linaro.org>, <sean@poorly.run>, <jdelvare@suse.com>,
	<linux@roeck-us.net>, <linus.walleij@linaro.org>,
	<dmitry.torokhov@gmail.com>, <maz@kernel.org>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <agk@redhat.com>,
	<snitzer@kernel.org>, <dm-devel@redhat.com>, <rajur@chelsio.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <peppe.cavallaro@st.com>,
	<alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@linaro.org>,
	<malattia@linux.it>, <hdegoede@redhat.com>, <markgross@kernel.org>,
	<artur.paszkiewicz@intel.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <sakari.ailus@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <fei1.li@intel.com>, <clm@fb.com>,
	<josef@toxicpanda.com>, <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>, <dushistov@mail.ru>,
	<luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<pmladek@suse.com>, <senozhatsky@chromium.org>,
	<andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
	<minchan@kernel.org>, <ngupta@vflare.org>, <akpm@linux-foundation.org>,
	<yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <fw@strlen.de>, <jmaloy@redhat.com>,
	<ying.xue@windriver.com>, <andrii@kernel.org>, <mykolal@fb.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <shuah@kernel.org>, <keescook@chromium.org>,
	<wad@chromium.org>, <willy@infradead.org>, <farbere@amazon.com>,
	<sashal@kernel.org>, <ruanjinjie@huawei.com>, <quic_akhilpo@quicinc.com>,
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
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 00/19 v6.1.y] Backport minmax.h updates from v6.17-rc7
Date: Wed, 24 Sep 2025 20:23:01 +0000
Message-ID: <20250924202320.32333-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.116.181]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132413_846493_C268D3AA 
X-CRM114-Status: GOOD (  12.33  )
X-Mailman-Approved-At: Mon, 06 Oct 2025 05:16:28 -0700
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

This series backports 19 patches to update minmax.h in the 6.1.y branch,
aligning it with v6.17-rc7.

The ultimate goal is to synchronize all longterm branches so that they
include the full set of minmax.h changes.

Previous work to update 6.12.48:
https://lore.kernel.org/stable/20250922103123.14538-1-farbere@amazon.com/T/#t
and 6.6.107:
https://lore.kernel.org/stable/20250922103241.16213-1-farbere@amazon.com/T/#t

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in older kernels.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

Andy Shevchenko (1):
  minmax: deduplicate __unconst_integer_typeof()

David Laight (8):
  minmax: fix indentation of __cmp_once() and __clamp_once()
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

Herve Codina (1):
  minmax: Introduce {min,max}_array()

Linus Torvalds (8):
  minmax: avoid overly complicated constant expressions in VM code
  minmax: simplify and clarify min_t()/max_t() implementation
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: add a few more MIN_T/MAX_T users
  minmax: simplify min()/max()/clamp() implementation
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

Matthew Wilcox (Oracle) (1):
  minmax: add in_range() macro

 arch/arm/mm/pageattr.c                        |   6 +-
 arch/um/drivers/mconsole_user.c               |   2 +
 arch/x86/mm/pgtable.c                         |   2 +-
 drivers/edac/sb_edac.c                        |   4 +-
 drivers/edac/skx_common.h                     |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 .../drm/arm/display/include/malidp_utils.h    |   2 +-
 .../display/komeda/komeda_pipeline_state.c    |  24 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   6 -
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/irqchip/irq-sun6i-r.c                 |   2 +-
 drivers/md/dm-integrity.c                     |   2 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  18 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/fjes/fjes_main.c                  |   4 +-
 drivers/nfc/pn544/i2c.c                       |   2 -
 drivers/platform/x86/sony-laptop.c            |   1 -
 drivers/scsi/isci/init.c                      |   6 +-
 .../pci/hive_isp_css_include/math_support.h   |   5 -
 drivers/virt/acrn/ioreq.c                     |   4 +-
 fs/btrfs/misc.h                               |   2 -
 fs/btrfs/tree-checker.c                       |   2 +-
 fs/ext2/balloc.c                              |   2 -
 fs/ext4/ext4.h                                |   2 -
 fs/ufs/util.h                                 |   6 -
 include/linux/compiler.h                      |   9 +
 include/linux/minmax.h                        | 264 +++++++++++++-----
 include/linux/pageblock-flags.h               |   2 +-
 kernel/trace/preemptirq_delay_test.c          |   2 -
 lib/btree.c                                   |   1 -
 lib/decompress_unlzma.c                       |   2 +
 lib/logic_pio.c                               |   3 -
 lib/vsprintf.c                                |   2 +-
 mm/zsmalloc.c                                 |   1 -
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 net/netfilter/nf_nat_core.c                   |   6 +-
 net/tipc/core.h                               |   2 +-
 net/tipc/link.c                               |  10 +-
 .../selftests/bpf/progs/get_branch_snapshot.c |   4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |   2 +
 tools/testing/selftests/vm/mremap_test.c      |   2 +
 48 files changed, 290 insertions(+), 184 deletions(-)

-- 
2.47.3


