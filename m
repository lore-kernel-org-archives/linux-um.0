Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E63CCD184
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBPqvNFiwkKgijISpeeAo0RvLJMFkjxb+cTy38dnT2Q=; b=f26Ryz9yWLzVzGs9hVqv8PGL6+
	rhngv8clsxQQ2cYA2cXYzjx6MpS0Ucig/+gFPm7x8zBWLFYo3oLel6D4S+luzaGo96oooe+xwYo0d
	jsZcJg09XltU61VvF32lKZTh/BN/K2Pa8EsWD96RDLr7lYxKrHc0N/hizLpWgd5cZTKbilRdAsenn
	pxbmKNaDxlT46i1doe7cBC5wNYVponeRSklg1iQI6LaFv5TE1YJKF/xwXoQJFIRNxbKlaHrZTDTzU
	4sMt1qeVPH8I9d9eENLC5sPBhDX1Uor2AvxfnYHmEUZ8KfSNIoZIEvmDzeSBZulNYB47JxOO4eiK7
	Ex4mQfYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5k92-0000000HZWD-2TaF;
	Mon, 06 Oct 2025 12:16:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Nrl-00000007vne-0H99;
	Sun, 21 Sep 2025 17:28:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 63B6D40468;
	Sun, 21 Sep 2025 17:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22692C4CEE7;
	Sun, 21 Sep 2025 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475727;
	bh=OhAKhAi+AnzI3Qc3qjl3chOvflGQ1Z6G7nQKCQgIA6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNji14LKsaN74d6/6VxXQLAaEWqiMK1odhhlWG54PmdesR086HbzOQPsvLp4l8W8h
	 erd/geKCs7blyB1imhKlNfDZtIHl2vwbNw8z3TSYAfWxPI4STRspwkbfLQuyq+0pRc
	 wfxpVS7OtRaNl868jtRKMkgfZDW20Ck1f7t2BQsw=
Date: Sun, 21 Sep 2025 19:28:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: linux@armlinux.org.uk, jdike@addtoit.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
	james.morse@arm.com, rric@kernel.org, harry.wentland@amd.com,
	sunpeng.li@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
	evan.quan@amd.com, james.qian.wang@arm.com, liviu.dudau@arm.com,
	mihail.atanassov@arm.com, brian.starkey@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robdclark@gmail.com, sean@poorly.run,
	jdelvare@suse.com, linux@roeck-us.net, fery@cypress.com,
	dmitry.torokhov@gmail.com, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, rajur@chelsio.com, davem@davemloft.net,
	kuba@kernel.org, peppe.cavallaro@st.com, alexandre.torgue@st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, malattia@linux.it,
	hdegoede@redhat.com, mgross@linux.intel.com,
	intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, jack@suse.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	willy@infradead.org, sashal@kernel.org, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com, Jason@zx2c4.com,
	bvanassche@acm.org, keescook@chromium.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org, jonnyc@amazon.com
Subject: Re: [PATCH 00/27 5.10.y] Backport minmax.h updates from v6.17-rc6
Message-ID: <2025092136-unelected-skirt-d91d@gregkh>
References: <20250919101727.16152-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919101727.16152-1-farbere@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_102849_136450_0B18DA2D 
X-CRM114-Status: GOOD (  14.30  )
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

On Fri, Sep 19, 2025 at 10:17:00AM +0000, Eliav Farber wrote:
> This series includes a total of 27 patches, to align minmax.h of
> v5.15.y with v6.17-rc6.
> 
> The set consists of 24 commits that directly update minmax.h:
> 1) 92d23c6e9415 ("overflow, tracing: Define the is_signed_type() macro
>    once")

But this isn't in 5.15.y, so how is this syncing things up?

I'm all for this, but I got confused here, at the first commit :)

> 2) 5efcecd9a3b1 ("minmax: sanity check constant bounds when clamping")



> 3) 2122e2a4efc2 ("minmax: clamp more efficiently by avoiding extra
>    comparison")
> 4) f9bff0e31881 ("minmax: add in_range() macro")
> 5) c952c748c7a9 ("minmax: Introduce {min,max}_array()")
> 6) 5e57418a2031 ("minmax: deduplicate __unconst_integer_typeof()")
> 7) f6e9d38f8eb0 ("minmax: fix header inclusions")
> 8) d03eba99f5bf ("minmax: allow min()/max()/clamp() if the arguments
>    have the same signedness.")
> 9) f4b84b2ff851 ("minmax: fix indentation of __cmp_once() and
>    __clamp_once()")
> 10) 4ead534fba42 ("minmax: allow comparisons of 'int' against 'unsigned
>     char/short'")
> 11) 867046cc7027 ("minmax: relax check to allow comparison between
>     unsigned arguments and signed constants")
> 12) 3a7e02c040b1 ("minmax: avoid overly complicated constant
>     expressions in VM code")
> 14) 017fa3e89187 ("minmax: simplify and clarify min_t()/max_t()
>     implementation")
> 15) 1a251f52cfdc ("minmax: make generic MIN() and MAX() macros
>     available everywhere")
> 18) dc1c8034e31b ("minmax: simplify min()/max()/clamp()
>     implementation")
> 19) 22f546873149 ("minmax: improve macro expansion and type
>     checking")
> 20) 21b136cc63d2 ("minmax: fix up min3() and max3() too")
> 21) 71ee9b16251e ("minmax.h: add whitespace around operators and after
>     commas")
> 22) 10666e992048 ("minmax.h: update some comments")
> 23) b280bb27a9f7 ("minmax.h: reduce the #define expansion of min(),
>     max() and clamp()")
> 24) a5743f32baec ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi
>     test in clamp()")
> 25) c3939872ee4a ("minmax.h: move all the clamp() definitions after the
>     min/max() ones")
> 26) 495bba17cdf9 ("minmax.h: simplify the variants of clamp()")
> 27) 2b97aaf74ed5 ("minmax.h: remove some #defines that are only
>     expanded once")

Some of these are also only in newer kernels, which, as you know, is
generally a bad thing (i.e. I can't take patches only for older
kernels.)

I want these changes, as they are great, but can you perhaps provide
patch series for newer kernels first so that I can then take these?

thanks,

greg k-h

