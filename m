Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C0ECCD187
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:CC:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKvaxmrs9uqyIGzbajJ1O5Hd1/ndu7xAtdLZV5bBh5k=; b=gwqqu3C+m38KCAdhz4LfVjot91
	nJkM39d+hEyI6xidFtQWvOOmKVXMXxJGpDAxcM7+BMvOFQo442C8Qew7aJ5EGHWyOKvsckCskGnOU
	cf34VNb8uClXa4oOOGzVb0jNc2T1inV7thuisZmTi7ChW2USI2ONMh+BpMe5zmqqLOwdFicL3myrO
	SFokHLHRZeg3O/jZx892GXQgqSN+LQCcnMizTNOBTPC1Rat6SDTsQlaA/Vb+Q/2kryB1tpa/tuJwo
	+XovmAs40sQrapthi72ezvGY8UmU3/yvCcO3O75rjWQNJAlcYL3BiHb2GvdvHQNUeXdiDPBiFp0Zg
	YTagM20A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k9V-0000000HaFA-3bKw;
	Mon, 06 Oct 2025 12:17:17 +0000
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([63.176.194.123])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3HZl-000000036hM-0AeP;
	Mon, 29 Sep 2025 17:22:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759166533; x=1790702533;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=gKvaxmrs9uqyIGzbajJ1O5Hd1/ndu7xAtdLZV5bBh5k=;
  b=CZzLp8Cw5FgGMOd+O9ugZE5OTrE+zNIBb8GpJ8oKhbAygHRWImy9IIiB
   RZZ1xP9OETdRVev89YHnq2M/PCi7/N71pUKpxzejv2v/mjbScAkH1Juet
   vsHYox2LwBcjyDrCziuv6eSQJPrQBrGUYCuh/7PROKKw7jXqu7H0434xA
   sf7Ya4v5Hp+ZrxtsRvTPUXqrAIqYQ2yytRn3VSSAZUROS8ZyuwMDul8bM
   29GS995wLHen2GB0xU7fURW2kn41JumgwwtkaMcoAc049oZfr0qdY1hsA
   bGgpkXA4iYAAxqe74rORpahG8ArDojV2ML/eXIwG5kwxAVLz9XwidXfzQ
   A==;
X-CSE-ConnectionGUID: IafcEd3hQO6oGZOiLnLKqg==
X-CSE-MsgGUID: Itl7dVAmRv28mSSF4DAfeA==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2841710"
Subject: RE: [PATCH 07/19 v6.1.y] minmax: make generic MIN() and MAX() macros
 available everywhere
Thread-Topic: [PATCH 07/19 v6.1.y] minmax: make generic MIN() and MAX() macros available
 everywhere
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:22:02 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:7433]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.19.222:2525] with esmtp (Farcaster)
 id 39c95fb2-68e2-4279-8b5a-834631637cab; Mon, 29 Sep 2025 17:22:01 +0000 (UTC)
X-Farcaster-Flow-ID: 39c95fb2-68e2-4279-8b5a-834631637cab
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 17:21:59 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 17:21:59 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Mon, 29 Sep 2025 17:21:59 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org" <rric@kernel.org>, "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com" <sunpeng.li@amd.com>, "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "evan.quan@amd.com" <evan.quan@amd.com>, "james.qian.wang@arm.com" <james.qian.wang@arm.com>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>, "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, "robdclark@gmail.com" <robdclark@gmail.com>, "quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>, "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "sean@poorly.run" <sean@poorly.run>, "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "maz@kernel.org" <maz@kernel.org>, "wens@csie.org" <wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "samuel@sholland.org" <samuel@sholland.org>, "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org" <snitzer@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "rajur@chelsio.com" <rajur@chelsio.com>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, "joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>, "malattia@linux.it" <malattia@linux.it>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "markgross@kernel.org" <markgross@kernel.org>, "artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "fei1.li@intel.com" <fei1.li@intel.com>, "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "dushistov@mail.ru" <dushistov@mail.ru>, "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "minchan@kernel.org" <minchan@kernel.org>, "ngupta@vflare.org" <ngupta@vflare.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>, "dsahern@kernel.org" <dsahern@kernel.org>, "pablo@netfilter.org" <pablo@netfilter.org>,
 "kadlec@netfilter.org" <kadlec@netfilter.org>, "fw@strlen.de" <fw@strlen.de>, "jmaloy@redhat.com" <jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "wad@chromium.org" <wad@chromium.org>, "willy@infradead.org" <willy@infradead.org>, "sashal@kernel.org" <sashal@kernel.org>, "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "quic_akhilpo@quicinc.com" <quic_akhilpo@quicinc.com>, "David.Laight@aculab.com" <David.Laight@aculab.com>, "herve.codina@bootlin.com" <herve.codina@bootlin.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Thread-Index: AQHcLZHEroQ9W2lH4EW9XJumD1KlZrSqNL0AgAAM8ACAAAMmgIAAKtlA
Date: Mon, 29 Sep 2025 17:21:58 +0000
Message-ID: <e754fed7d53040fb92e1ef9b64c64f6e@amazon.com>
References: <20250924202320.32333-1-farbere@amazon.com>
 <20250924202320.32333-8-farbere@amazon.com>
 <2025092923-stove-rule-a00f@gregkh>
 <85a995bb59474300aa3d5f973d279a13@amazon.com>
 <2025092955-module-landfall-ed45@gregkh>
In-Reply-To: <2025092955-module-landfall-ed45@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.172]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_102213_551564_7A963993 
X-CRM114-Status: GOOD (  11.98  )
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

> On Mon, Sep 29, 2025 at 02:39:26PM +0000, Farber, Eliav wrote:
> > > On Wed, Sep 24, 2025 at 08:23:08PM +0000, Eliav Farber wrote:
> > > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > > >
> > > > [ Upstream commit 1a251f52cfdc417c84411a056bc142cbd77baef4 ]
> > >
> > > <snip>
> > >
> > > As this didn't go into 6.6.y yet, I'll stop here on this series for n=
ow.
> > > Please fix up for newer kernels first and then resend these.
> >
> > For 6.6.y I backported 15 commits:
> > https://lore.kernel.org/stable/20250922103241.16213-1-farbere@amazon.co=
m/T/#t
> >
> > Why weren't all of them picked?
>
> Because one of them broke the build, as I wrote a week ago here:
>         https://lore.kernel.org/all/2025092209-owl-whisking-03e3@gregkh/

Fixed:
https://lore.kernel.org/stable/20250929171733.20671-1-farbere@amazon.com/T/=
#t

---
Thanks, Eliav

