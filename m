Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE56CCFA13
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdiWHbgl6AHEx4BHfyPyYJgEU9DgWqWz/BaU0smVwgs=; b=ilG2oOcZMmdWo5ku+ZbNTQF/JL
	JoTZRleUKcuwgVLiIWdQmZrElR/h2hCpWsn1g/Tz0DS/XXelFbvBnsRKquU3hV/HAiqTF/lXEaMnu
	EY56MiMENLwlnDFgD2qyRfbOmcPd1A69GvV/NIsxoq7tfi8jTV0H3zSXDIlQA3M57LQNPKBuE2Mar
	cDZgTIPnoHlb+UIOmQNGV1D8UUg+3MaA84J7k3beGwywL0wOLmwPVrOm+3/KgPBgHXqzJhtaw0LzQ
	bXGnlLBnjQuf11iClGleuLTYTUUIFpIWzvuvUU47XjgOIoNqwDGzhhWyH08DYtPLelojPEtlSZs7h
	ZF1JvupQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHlrM-00000003HDz-2pxU;
	Sat, 08 Nov 2025 16:32:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9mqg-00000008LVI-2tig;
	Fri, 17 Oct 2025 15:58:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DBD064767;
	Fri, 17 Oct 2025 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687B5C4CEE7;
	Fri, 17 Oct 2025 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716713;
	bh=20X28MMOWSoptgGAWTUrviJnQniEpl6Ktq66BRGKH/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLtxIBv7SZeCQWvR3ANCLmaMyydymZnc8EmPjl/1wQ2ZU6GZiD2nKCaUbGU/mGLlp
	 fTOdia6A6ekGANEzH++1tbYBhBm/NR7Jy2B8blUuCuIxDXrSTaYf19VuAHrRtgTE73
	 ZyIsy6hsoafgxjCLHqBFDNZjVm7M30+2G2ZqFt0Y=
Date: Fri, 17 Oct 2025 17:03:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: stable@vger.kernel.org, linux@armlinux.org.uk, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
	james.qian.wang@arm.com, liviu.dudau@arm.com,
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
	dsterba@suse.com, xiang@kernel.org, chao@kernel.org, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	willy@infradead.org, sashal@kernel.org, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com, Jason@zx2c4.com,
	keescook@chromium.org, kbusch@kernel.org, nathan@kernel.org,
	bvanassche@acm.org, ndesaulniers@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <2025101704-rumble-chatroom-60b5@gregkh>
References: <20251017090519.46992-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017090519.46992-1-farbere@amazon.com>
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

On Fri, Oct 17, 2025 at 09:04:52AM +0000, Eliav Farber wrote:
> This series backports 27 patches to update minmax.h in the 5.10.y
> branch, aligning it with v6.17-rc7.
> 
> The ultimate goal is to synchronize all long-term branches so that they
> include the full set of minmax.h changes.
> 
> - 6.12.y has already been backported; the changes are included in
>   v6.12.49.
> - 6.6.y has already been backported; the changes are included in
>   v6.6.109.
> - 6.1.y has already been backported; the changes are currently in the
>   6.1-stable tree.
> - 5.15.y has already been backported; the changes are currently in the
>   5.15-stable tree.

With this series applied, on an arm64 server, building 'allmodconfig', I
get the following build error.

Oddly I don't see it on my x86 server, perhaps due to different compiler
versions?

Any ideas?

thanks,

greg k-h

------------------------

In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4022:25:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4024:25:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
In function ‘rt2800_txpower_to_dev’,
    inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4028:4:
./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
  290 |                         prefix ## suffix();                             \
      |                         ^~~~~~
./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
  309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^~~~~~~~~~~~~~~~
../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^~~~~~~~~~~~
../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^~~~~~~~~~~~~~~
../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^~~~~~~
make[6]: *** [../scripts/Makefile.build:286: drivers/net/wireless/ralink/rt2x00/rt2800lib.o] Error 1
make[5]: *** [../scripts/Makefile.build:503: drivers/net/wireless/ralink/rt2x00] Error 2
make[4]: *** [../scripts/Makefile.build:503: drivers/net/wireless/ralink] Error 2
make[4]: *** Waiting for unfinished jobs....

