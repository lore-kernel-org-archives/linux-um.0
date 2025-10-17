Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2740CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nX+mtnNcQcWlv9JGlUu/KrtXpqebuR7wZinuAUmv6BM=; b=F3xK5BwglqElI77kXKc3WomKqC
	xonWFTxWC95V9X+o6oIarraXovuHbfu01XIDXRflS9tPclb3eE+f6DFmXQZLpr7aXvluqnk6gMpC+
	oO78cMKEUIi3+Jyj1Qzjzqew+KQNy3RfwLqJ8439w007bJOeE2MC2rCHmWzt4zfHdTi+046Do88nO
	cBU/4yAYSUFHy8Iy6l2BNHvcHqkpcyENnyVLRT5Kqlz3/TNJp9tB7jUNKs5DKn26hjZGZDSlYKwhm
	FuFbCIMxWeCMJHfdwWT+hcFuWND7CxIQKPBrjqlToNgjyi8w3ntsUDjDN5mZap0QRKmLClnJ8F4cJ
	2goAX+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHlrN-00000003HEW-1S5Q;
	Sat, 08 Nov 2025 16:32:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9n1w-00000008Ngy-45IG;
	Fri, 17 Oct 2025 16:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nX+mtnNcQcWlv9JGlUu/KrtXpqebuR7wZinuAUmv6BM=; b=F+WP7BxWQI/jatvclOMgoKWKug
	zCyPuGxxeSxUFA/tB/7fpFFknCC5s8F/tq+6h9o3pZonSl+5H/kbovMGCPqIbUItKdSMsIUWUtluc
	8bWdpcvjge/aEGs+Hshp1TNRzYGac//LcqW6rv9hrHiyFsGDawQlqxAkKOpsoSsvbHHpfXDwz6Jfa
	6iBnNr80kF47+icCXi/x0qVRljg0tb2FVxcg3TmwQ4Z7AIsjw5s9HBHI7QFFlpjvtqxQVXuN7rdV+
	IVu/5lyZGr3uuguD//yGRJRz6wdt+OjqizWqKWOzVnC7Ogw7tJqwRKquLHqQwWI1KwgcB+i8ummV6
	VsMRD1IA==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9n1l-00000007j7U-3PhC;
	Fri, 17 Oct 2025 16:10:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 19A6443AD4;
	Fri, 17 Oct 2025 16:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE17C4CEE7;
	Fri, 17 Oct 2025 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717391;
	bh=BOrYC+tXjLjRqJyXcD4crvrBNK2lkUpKkjfEmyc87bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtSviiKK7XhOypmn1B0JMTFJNg+aK9xkicr5kleBJoGLQsIHX6oRtRnPJgXbXWtLH
	 cVrvwZYIhcft0nkxK/ZQBpXxxHeWHw5/VEilYnGTD4lEZyzXP8wqDKjbklEc7PQZxX
	 jrw7mNWuagcjs3SnKes4mzFKMKH2tiSDMTY+zRgHS/b+KVlZKnLK4gb6spqja1+1F5
	 LtRKkkOtABvH8jmUIF+maywb5ma9DVPFdB4So5FQ7XdD3Y3FN97CNzQWMZICjSRgyi
	 XbXdYmBkEWUiq556ItdRa+tvmxGUk+V9ozsqtDgWFGhyHQtvMVM573eif+FMsCQ1J7
	 ilRe5q/VN9eDQ==
Date: Fri, 17 Oct 2025 17:09:24 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org,
	linux@armlinux.org.uk, jdike@addtoit.com, richard@nod.at,
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
	keescook@chromium.org, kbusch@kernel.org, bvanassche@acm.org,
	ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-edac@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 00/27 5.10.y] Backport minmax.h updates from v6.17-rc7
Message-ID: <20251017160924.GA2728735@ax162>
References: <20251017090519.46992-1-farbere@amazon.com>
 <2025101704-rumble-chatroom-60b5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025101704-rumble-chatroom-60b5@gregkh>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_171004_128242_F7F5AE26 
X-CRM114-Status: GOOD (  16.29  )
X-Mailman-Approved-At: Sat, 08 Nov 2025 08:31:09 -0800
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

On Fri, Oct 17, 2025 at 05:03:02PM +0200, Greg KH wrote:
> On Fri, Oct 17, 2025 at 09:04:52AM +0000, Eliav Farber wrote:
> > This series backports 27 patches to update minmax.h in the 5.10.y
> > branch, aligning it with v6.17-rc7.
> > 
> > The ultimate goal is to synchronize all long-term branches so that they
> > include the full set of minmax.h changes.
> > 
> > - 6.12.y has already been backported; the changes are included in
> >   v6.12.49.
> > - 6.6.y has already been backported; the changes are included in
> >   v6.6.109.
> > - 6.1.y has already been backported; the changes are currently in the
> >   6.1-stable tree.
> > - 5.15.y has already been backported; the changes are currently in the
> >   5.15-stable tree.
> 
> With this series applied, on an arm64 server, building 'allmodconfig', I
> get the following build error.
> 
> Oddly I don't see it on my x86 server, perhaps due to different compiler
> versions?
> 
> Any ideas?
> 
> thanks,
> 
> greg k-h
> 
> ------------------------
> 
> In function ‘rt2800_txpower_to_dev’,
>     inlined from ‘rt2800_config_channel’ at ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:4022:25:
> ./../include/linux/compiler_types.h:309:45: error: call to ‘__compiletime_assert_1168’ declared with attribute error: clamp() low limit -7 greater than high limit 15
>   309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ./../include/linux/compiler_types.h:290:25: note: in definition of macro ‘__compiletime_assert’
>   290 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> ./../include/linux/compiler_types.h:309:9: note: in expansion of macro ‘_compiletime_assert’
>   309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ../include/linux/minmax.h:188:9: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
>       |         ^~~~~~~~~~~~~~~~
> ../include/linux/minmax.h:195:9: note: in expansion of macro ‘__clamp_once’
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^~~~~~~~~~~~
> ../include/linux/minmax.h:218:36: note: in expansion of macro ‘__careful_clamp’
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^~~~~~~~~~~~~~~
> ../drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:24: note: in expansion of macro ‘clamp_t’
>  3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
>       |                        ^~~~~~~

Missing commit 3bc753c06dd0 ("kbuild: treat char as always unsigned")?

Cheers,
Nathan

