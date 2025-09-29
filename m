Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2DCCD182
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zPSrvzWQyFbFs3VVIhJpehyI8dGL3FKzDANiDLrbdg=; b=TI+nfqv4DPZLg0cT0vHkK5qsF1
	KvEqE5Eg5LVLXyG7ryX9QW+Kos6pOYmBOPOF/y5PpfdwVRNu/f9BFC5afMTnASMiFazY+4e9ChfTT
	i1ZHxrLYHF765SWa5g6cK3Ej8+XAPfZXo1Z2FxdwSKFCWkyPpwo7mAJnfcDxFd3L3m53U0VIxdb3I
	63NOjp2We83UZjMJL9hYGueH/i3CMkeXwavr7a0qczwCIeiu/TP/qhQcURKnBU7l0pDyJewfey64N
	f0pvcfbK8FmmJz0tYMKuQQfsCOqxnoRXuKWddORgQTp5038G+/ZRcyRm4fatkxns/3U+HUYq8IrP2
	tuF2O4FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k9K-0000000HZvU-1IWH;
	Mon, 06 Oct 2025 12:17:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3FA7-00000002iZU-3plk;
	Mon, 29 Sep 2025 14:47:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 368E144E5D;
	Mon, 29 Sep 2025 14:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51EEC4CEF4;
	Mon, 29 Sep 2025 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759157255;
	bh=8W8Q+OA2dF6Ur3uVnm6arrgUauWJ5keNKgi5Rakv08M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ixd7lGKjU8rPs4OWaLyHTILBe27JWFNUeW7ErLrq5kAqdgQvDcohTydA9pilDkaVH
	 z52PdLZ/6lQF/TxWojd21t/6vwpwNY0xwdJgToPIfkLHWKKVz+QIaSh4krNdfG/Qsg
	 H3crXkWEyIu0mULyxpLF7vZzJx+xJCpRFqbsU2Dk=
Date: Mon, 29 Sep 2025 16:47:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org" <rric@kernel.org>, "harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com" <sunpeng.li@amd.com>, "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "evan.quan@amd.com" <evan.quan@amd.com>, "james.qian.wang@arm.com" <james.qian.wang@arm.com>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>, "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, "robdclark@gmail.com" <robdclark@gmail.com>, "quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>, "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "sean@poorly.run" <sean@poorly.run>, "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "maz@kernel.org" <maz@kernel.org>, "wens@csie.org" <wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "samuel@sholland.org" <samuel@sholland.org>, "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org" <snitzer@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "rajur@chelsio.com" <rajur@chelsio.com>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>, "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, "joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>, "malattia@linux.it" <malattia@linux.it>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "markgross@kernel.org" <markgross@kernel.org>, "artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "fei1.li@intel.com" <fei1.li@intel.com>, "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "dushistov@mail.ru" <dushistov@mail.ru>, "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "minchan@kernel.org" <minchan@kernel.org>, "ngupta@vflare.org" <ngupta@vflare.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>, "dsahern@kernel.org" <dsahern@kernel.org>, "pablo@netfilter.org" <pablo@netfilter.org>,
 "kadlec@netfilter.org" <kadlec@netfilter.org>, "fw@strlen.de" <fw@strlen.de>, "jmaloy@redhat.com" <jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>, "andrii@kernel.org" <andrii@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, "wad@chromium.org" <wad@chromium.org>, "willy@infradead.org" <willy@infradead.org>, "sashal@kernel.org" <sashal@kernel.org>, "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>, "quic_akhilpo@quicinc.com" <quic_akhilpo@quicinc.com>, "David.Laight@aculab.com" <David.Laight@aculab.com>, "herve.codina@bootlin.com" <herve.codina@bootlin.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 07/19 v6.1.y] minmax: make generic MIN() and MAX() macros
 available everywhere
Message-ID: <2025092955-module-landfall-ed45@gregkh>
References: <20250924202320.32333-1-farbere@amazon.com>
 <20250924202320.32333-8-farbere@amazon.com>
 <2025092923-stove-rule-a00f@gregkh>
 <85a995bb59474300aa3d5f973d279a13@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a995bb59474300aa3d5f973d279a13@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_074736_016727_30AD6099 
X-CRM114-Status: GOOD (  10.92  )
X-Mailman-Approved-At: Mon, 06 Oct 2025 05:16:25 -0700
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

On Mon, Sep 29, 2025 at 02:39:26PM +0000, Farber, Eliav wrote:
> > On Wed, Sep 24, 2025 at 08:23:08PM +0000, Eliav Farber wrote:
> > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > >
> > > [ Upstream commit 1a251f52cfdc417c84411a056bc142cbd77baef4 ]
> >
> > <snip>
> >
> > As this didn't go into 6.6.y yet, I'll stop here on this series for now.
> > Please fix up for newer kernels first and then resend these.
> 
> For 6.6.y I backported 15 commits:
> https://lore.kernel.org/stable/20250922103241.16213-1-farbere@amazon.com/T/#t
> 
> Why weren't all of them picked?

Because one of them broke the build, as I wrote a week ago here:
	https://lore.kernel.org/all/2025092209-owl-whisking-03e3@gregkh/

thanks,

greg k-h

