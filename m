Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1797CAC5A8
	for <linux-um@archiver.kernel.org>; Sat, 20 Sep 2025 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0vYXtUQVOuP2mhoWd4ropfz+61/nK8dVG+VKmZf9qg=; b=eHPrz6fweUDOMMk28pNofYuu8O
	sRlLDUwSvu0HFc5XiqqFK7Bl2DOKUGLXpv7K4cstBtJPHnhpEiLEStTIG1w02/1aK0hNgozwX2Ij6
	e2CUH8rvY9h6d58tTg35Z8gCaKCv5jCZfgJ/xDGo7FJK2h8WSiUtSBoeEKk2dhZtLb8RxDSYdlXwX
	7Vm7qcbcpntk0Aa4jKvXsS5+4Kf+92+VA1gbzYfYNeqdyTlY5EPfjkuFeHR2kQ535P66b1rsFVDmV
	ObRLeZEIrroQW6u48VaNTc1GdgvvXfN638ChWEe1kLXgJasf9I6jJlljxegCuHwqwbDkI5StCxAsv
	OZ7UHRaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzuih-00000005BEw-1VXK;
	Sat, 20 Sep 2025 10:21:31 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzuid-00000005BDQ-3yzR
	for linux-um@lists.infradead.org;
	Sat, 20 Sep 2025 10:21:29 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so26826725e9.1
        for <linux-um@lists.infradead.org>; Sat, 20 Sep 2025 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758363686; x=1758968486; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0vYXtUQVOuP2mhoWd4ropfz+61/nK8dVG+VKmZf9qg=;
        b=kbuR/1H1+mv8sH90QT5fNxaH9XGAH5+iVLso2dpB6qNeODRSQwdMUk6lC955J98TLu
         XU1IYIuKWN5sv6pFxT9ABJmzkCcIUTMcdPbGP3EhbbGh4nM03+ftFid4CykGnM5PdW7D
         WHG7Y9esELvrAvoM/YEt6/t6W0mRzVkmw8y/njs9T5JBbH7HFejXHax+EFeGhSwfTady
         /qtRchX+xjX2rjcaY6XEFMyKxeahwzABsfuZp2Umi0fj1kVM8rhAXVXDdbevFNa09/cn
         MMixpqEz92vwhA9R2ItCY2c3quavTP3IeCaHoGcirKEDtfsMfwNjaA0Lf01bCgsHOk2i
         FX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758363686; x=1758968486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0vYXtUQVOuP2mhoWd4ropfz+61/nK8dVG+VKmZf9qg=;
        b=GX6zUiZK1ifnwZ5l3oQsmSLK+J0fGNaOmxU61edgcK+DfAz5AfQ6Qryf0nAD90Mrc4
         T7iAbkD/0+NI0dwaP7N7LwHUlA+l9iGXvUTo7OWajG9IKIuufwmCf4248Xytx20reitj
         ttPdA0RMGG1TumJyULUj8RVRBi8tBsRI7TL5Evp5IiX4dF8+iDLrvWBjYNz7T7R2QgCt
         nJMObdMUAsnfasQqLjuAhGwIMBnAnardeynuV+My9shMqlkq+gyogCBUZ3R+rhSpAY+f
         IFnlzBlNwaXMqRi6dcMLYXDqNDcZnUUHcbCmmpld/3WeEAVl/LroXDWaBBR2V1hIXBJ9
         klyg==
X-Forwarded-Encrypted: i=1; AJvYcCW59dloPdXdbSi74H5LLzIBA4e0f1H2ibG9s/1IFFRNlIw/8FY8XqeIIJWoYH9EVl/GQ1k6o8E+RQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywfb2GAdnJvxFuseSMEls7+xG2rjSwuKvIy2swNG2qcuMxlWNNx
	BgSDjuMOsacC/zd9elj6vlEmZnfkH2PnCjguf7S4Wfxnq9c0hQduRqeB
X-Gm-Gg: ASbGncuOpw1HFAaC05CAy4c+q9+t5NWelzG0xBfXiODrmJY3YZsEjlAyrXV6Jv/QsBs
	XkBHXtYTkQRd0PgbIxgPiJ+bgykaEZt8JoMYcRA39I/2W1aNTJlbLr36UVaQQxrpj0tgBpKKsOg
	dcEFo/o4l8CNsVr5WMKl82P8xgH0exOwjsvkgriaLRb/AAoNDvRVZvWpF0AdvaaULK5rupEiZAr
	0YH6murQIaXzAF/0QeVvyfl73xv3Ag7knYcd899XOafgoepaA1wHbndbIwmEk4V+AZAbMJTJdQF
	C+AbKkK/Whvpvy53JNzbiDzHPkmJGXKqYQd7IjEGUvIR2bO281aAdJn+AuLEORHUqpAMVbI6fR8
	TJhJQXzXNuW1CKTP83/QrwtUPjg63LO5XRHD0ygXwdckA9OQw11TlDVKHfYWf
X-Google-Smtp-Source: AGHT+IFiz+7GSgFF/mIUUp0ndfipkNQ39jr+2XK+PXUAveDTslyL1Wu67txaLfdop4/qCEdAg/m1vQ==
X-Received: by 2002:a05:600c:c8f:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-467e6f37d8dmr76782405e9.16.1758363685327;
        Sat, 20 Sep 2025 03:21:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm5624389f8f.56.2025.09.20.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 03:21:25 -0700 (PDT)
Date: Sat, 20 Sep 2025 11:21:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux@armlinux.org.uk, jdike@addtoit.com,
 anton.ivanov@cambridgegreys.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, hpa@zytor.com,
 tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
 james.morse@arm.com, rric@kernel.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, evan.quan@amd.com, james.qian.wang@arm.com,
 liviu.dudau@arm.com, mihail.atanassov@arm.com, brian.starkey@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robdclark@gmail.com, sean@poorly.run, dmitry.torokhov@gmail.com,
 agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com, rajur@chelsio.com,
 davem@davemloft.net, kuba@kernel.org, peppe.cavallaro@st.com,
 alexandre.torgue@st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
 malattia@linux.it, hdegoede@redhat.com, mgross@linux.intel.com,
 intel-linux-scu@intel.com, artur.paszkiewicz@intel.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, dushistov@mail.ru, luc.vanoostenryck@gmail.com,
 rostedt@goodmis.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
 andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
 akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
 pablo@netfilter.org, kadlec@netfilter.org, jmaloy@redhat.com,
 ying.xue@windriver.com, willy@infradead.org, sashal@kernel.org,
 ruanjinjie@huawei.com, David.Laight@ACULAB.COM, herve.codina@bootlin.com,
 Jason@zx2c4.com, bvanassche@acm.org, keescook@chromium.org,
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
Message-ID: <20250920111904.6d9ecb17@pumpkin>
In-Reply-To: <184ce83f-0063-43a0-a1c8-da23c5d03cf7@amd.com>
References: <20250919101727.16152-1-farbere@amazon.com>
	<184ce83f-0063-43a0-a1c8-da23c5d03cf7@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_032128_040465_84169EF5 
X-CRM114-Status: GOOD (  28.12  )
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

On Fri, 19 Sep 2025 14:11:37 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 19.09.25 12:17, Eliav Farber wrote:
> > This series includes a total of 27 patches, to align minmax.h of
> > v5.15.y with v6.17-rc6.
> >=20
> > The set consists of 24 commits that directly update minmax.h:
> > 1) 92d23c6e9415 ("overflow, tracing: Define the is_signed_type() macro
> >    once")
> > 2) 5efcecd9a3b1 ("minmax: sanity check constant bounds when clamping")
> > 3) 2122e2a4efc2 ("minmax: clamp more efficiently by avoiding extra
> >    comparison")
> > 4) f9bff0e31881 ("minmax: add in_range() macro")
> > 5) c952c748c7a9 ("minmax: Introduce {min,max}_array()")
> > 6) 5e57418a2031 ("minmax: deduplicate __unconst_integer_typeof()")
> > 7) f6e9d38f8eb0 ("minmax: fix header inclusions")
> > 8) d03eba99f5bf ("minmax: allow min()/max()/clamp() if the arguments
> >    have the same signedness.")
> > 9) f4b84b2ff851 ("minmax: fix indentation of __cmp_once() and
> >    __clamp_once()")
> > 10) 4ead534fba42 ("minmax: allow comparisons of 'int' against 'unsigned
> >     char/short'")
> > 11) 867046cc7027 ("minmax: relax check to allow comparison between
> >     unsigned arguments and signed constants")
> > 12) 3a7e02c040b1 ("minmax: avoid overly complicated constant
> >     expressions in VM code")
> > 14) 017fa3e89187 ("minmax: simplify and clarify min_t()/max_t()
> >     implementation")
> > 15) 1a251f52cfdc ("minmax: make generic MIN() and MAX() macros
> >     available everywhere")
> > 18) dc1c8034e31b ("minmax: simplify min()/max()/clamp()
> >     implementation")
> > 19) 22f546873149 ("minmax: improve macro expansion and type
> >     checking")
> > 20) 21b136cc63d2 ("minmax: fix up min3() and max3() too")
> > 21) 71ee9b16251e ("minmax.h: add whitespace around operators and after
> >     commas")
> > 22) 10666e992048 ("minmax.h: update some comments")
> > 23) b280bb27a9f7 ("minmax.h: reduce the #define expansion of min(),
> >     max() and clamp()")
> > 24) a5743f32baec ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi
> >     test in clamp()")
> > 25) c3939872ee4a ("minmax.h: move all the clamp() definitions after the
> >     min/max() ones")
> > 26) 495bba17cdf9 ("minmax.h: simplify the variants of clamp()")
> > 27) 2b97aaf74ed5 ("minmax.h: remove some #defines that are only
> >     expanded once")
> >=20
> > 2 prerequisite commits that adjust users of MIN and MAX macros (to
> > prevent compilation issues):
> > 13) 4477b39c32fd ("minmax: add a few more MIN_T/MAX_T users")
> > 17) cb04e8b1d2f2 ("minmax: don't use max() in situations that want a C
> >     constant expression")
> >=20
> > 1 additional commit introduced to resolve a build failures during the
> > backport:
> > 16) lib: zstd: drop local MIN/MAX macros in favor of generic ones
> >=20
> > The primary motivation is to bring in commit (8).
> > In mainline, this change allows min()/max()/clamp() to accept mixed
> > argument types when both share the same signedness.
> > Backported patches to v5.10.y that use such forms trigger compiler
> > warnings, which in turn cause build failures when -Werror is enabled.
> >=20
> > Originaly I aligned 5.10.y to 5.15.y, but David Laight commented that I
> > need to pick up the later changes (from Linus) as well.
> >=20
> > Andy Shevchenko (2):
> >   minmax: deduplicate __unconst_integer_typeof()
> >   minmax: fix header inclusions
> >=20
> > Bart Van Assche (1):
> >   overflow, tracing: Define the is_signed_type() macro once
> >=20
> > David Laight (11):
> >   minmax: allow min()/max()/clamp() if the arguments have the same
> >     signedness.
> >   minmax: fix indentation of __cmp_once() and __clamp_once()
> >   minmax: allow comparisons of 'int' against 'unsigned char/short'
> >   minmax: relax check to allow comparison between unsigned arguments and
> >     signed constants
> >   minmax.h: add whitespace around operators and after commas
> >   minmax.h: update some comments
> >   minmax.h: reduce the #define expansion of min(), max() and clamp()
> >   minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
> >   minmax.h: move all the clamp() definitions after the min/max() ones
> >   minmax.h: simplify the variants of clamp()
> >   minmax.h: remove some #defines that are only expanded once
> >=20
> > Eliav Farber (1):
> >   lib: zstd: drop local MIN/MAX macros in favor of generic ones
> >=20
> > Herve Codina (1):
> >   minmax: Introduce {min,max}_array()
> >=20
> > Jason A. Donenfeld (2):
> >   minmax: sanity check constant bounds when clamping
> >   minmax: clamp more efficiently by avoiding extra comparison
> >=20
> > Linus Torvalds (8):
> >   minmax: avoid overly complicated constant expressions in VM code
> >   minmax: add a few more MIN_T/MAX_T users
> >   minmax: simplify and clarify min_t()/max_t() implementation
> >   minmax: make generic MIN() and MAX() macros available everywhere
> >   minmax: don't use max() in situations that want a C constant
> >     expression
> >   minmax: simplify min()/max()/clamp() implementation
> >   minmax: improve macro expansion and type checking
> >   minmax: fix up min3() and max3() too
> >=20
> > Matthew Wilcox (Oracle) (1):
> >   minmax: add in_range() macro
> >=20
> >  arch/arm/mm/pageattr.c                        |   6 +-
> >  arch/um/drivers/mconsole_user.c               |   2 +
> >  arch/x86/mm/pgtable.c                         |   2 +- =20
>=20
> >  drivers/edac/sb_edac.c                        |   4 +-
> >  drivers/edac/skx_common.h                     |   1 -
> >  .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
> >  .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
> >  .../drm/arm/display/include/malidp_utils.h    |   2 +-
> >  .../display/komeda/komeda_pipeline_state.c    |  24 +-
> >  drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   6 -
> >  drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
> >  drivers/hwmon/adt7475.c                       |  24 +-
> >  drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
> >  drivers/md/dm-integrity.c                     |   2 +-
> >  drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
> >  .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  18 +-
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
> >  drivers/net/fjes/fjes_main.c                  |   4 +-
> >  drivers/nfc/pn544/i2c.c                       |   2 -
> >  drivers/platform/x86/sony-laptop.c            |   1 -
> >  drivers/scsi/isci/init.c                      |   6 +- =20
>=20
> I do see the value to backport the infrastructure, but why are driver spe=
cific changes backported as well?

They will be about removing local definitions of MIN() and MAX() freeing
them up for simple implementations (usable as constant initialisers) and th=
en
using them in places where the compound statements in min() and max() can't
be used.

Linus did all those changes - so he didn't have to wait for the maintainers
to apply the changes (etc).

	David
=20
>=20
> I mean the changes are most likely correct but also not valuable in anywa=
y as bug fix.
>=20
> Regards,
> Christian.
>=20
> >  .../pci/hive_isp_css_include/math_support.h   |   5 -
> >  fs/btrfs/misc.h                               |   2 -
> >  fs/btrfs/tree-checker.c                       |   2 +-
> >  fs/ext2/balloc.c                              |   2 -
> >  fs/ext4/ext4.h                                |   2 -
> >  fs/ufs/util.h                                 |   6 -
> >  include/linux/compiler.h                      |  15 +
> >  include/linux/minmax.h                        | 267 ++++++++++++++----
> >  include/linux/overflow.h                      |   1 -
> >  include/linux/trace_events.h                  |   2 -
> >  kernel/trace/preemptirq_delay_test.c          |   2 -
> >  lib/btree.c                                   |   1 -
> >  lib/decompress_unlzma.c                       |   2 +
> >  lib/logic_pio.c                               |   3 -
> >  lib/vsprintf.c                                |   2 +-
> >  lib/zstd/zstd_internal.h                      |   2 -
> >  mm/zsmalloc.c                                 |   1 -
> >  net/ipv4/proc.c                               |   2 +-
> >  net/ipv6/proc.c                               |   2 +-
> >  net/netfilter/nf_nat_core.c                   |   6 +-
> >  net/tipc/core.h                               |   2 +-
> >  net/tipc/link.c                               |  10 +-
> >  44 files changed, 306 insertions(+), 164 deletions(-)
> >  =20
>=20
>=20


