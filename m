Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644A9CCA472
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8A8mrbjHOp4I+EQv9aLZuINyxZFXeZgTqLUL4/gbts=; b=Gx7WEh/aP2AAFDMHxG5RWVOQvK
	kboANanBfhKEnK8bk+GkQzrQzNN11kmb3BU01JNwGZf5vs7EZFlqIQjRSaafbNQ0G+vdQ2PHoBNin
	+aOUMl4lpoMIbJLWc0DY+Uk4M/+5o84Alb2QL403hwqwqSg/9TzIxpi8SXjy88muBT+dh6llj0V8/
	EX4nNT2mhajwtIA46VbGahrUSRxNXY87ocfSxuYOffsjIL1SG+lffX5bT/U596NA7BGHHJW4HuhQc
	8YlibE1eIAomLG+z8/Euno12JPXNnhsWGORZFe8+wTUfbusMUjSjs4SY/OsvVXGAca/zv2pE421Tu
	veG9F/0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5rvL-00000000kEQ-1L0A;
	Mon, 06 Oct 2025 20:35:11 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5rvJ-00000000kCr-1SYA
	for linux-um@lists.infradead.org;
	Mon, 06 Oct 2025 20:35:10 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso40490635e9.1
        for <linux-um@lists.infradead.org>; Mon, 06 Oct 2025 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759782907; x=1760387707; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8A8mrbjHOp4I+EQv9aLZuINyxZFXeZgTqLUL4/gbts=;
        b=E+skgjV4SSefE8j6gyUtUYiw+qmkWtYweEnCvtTzF5+C8owJ5Gz4Qzv75PiI5LQ7HP
         z8B3QfmgQV5VH3rESxhs6A4xNnLAuC2vDgeIY6aFjyKTJlB/N279vIUx3+u0fg1MkUdE
         nqKKynNGFNTSkkUqsGizhRJlXKvYztkG7uV3/CrYLcPVpZHB9+bQkBzNsqIlHGs7jP6P
         cKNRnKVfqTfpgpBJi++uE7WwV2AkxHhJxnxbUL4E/njXlSkQ72TXAK17kxw/C+96fFvx
         RQ4TzZ+oHt3R1yB4pu2zJ/kvkvB40BhdOehEkYqF4HIx4xwfHbJTUmhMAu1xIyVzTSSU
         1kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782907; x=1760387707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8A8mrbjHOp4I+EQv9aLZuINyxZFXeZgTqLUL4/gbts=;
        b=NzOKby+QCPmLyqc3kEoxEQ5r+zjeQiaxRTyjwJ7xQbBuzERe+9q79p/+Ge5e0oqPo8
         md6jxxoSUtk+HbUXG5vAgqgGeJ7Ge3UJLjoWhfcbcEvNP5SyRmDQGCVMquY7FBzDo1HC
         0C0haSroopcYn1vqiFZGT0Srd3G/u3rtUZ+aF3kqbHoMy2VfSTZ692Fpx++w+2ZhlX0+
         HncRt09OTCq5rrXCWe0wlXWk7po6ouIbwlXskqXAgxRLU8hJqyNBgMR2ZAkq3x0hdHPS
         QGP7vOYIzQAG7RYFH+/PUbWqcpWzyg7wotUM0Se4qPVnzZZp8zJMCcFDiSx/Rs3Qnj/q
         USdA==
X-Forwarded-Encrypted: i=1; AJvYcCUgLY8pkstRKhFJgd3N+m/0YlEhHKjn+8xUlcSJG0s+lrlIGd/mxYxTcten89kXTRoW84Rn1zMccA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzkDRYXhHNT2RlVQuDx1oxWblrtfXwJVLqV+q0IABqTbIUR+s88
	5wwpGr8r5if7JS++sVXC4xWD8xeVSwXhGU6/15k81yQxbYOhGRNwt1ua
X-Gm-Gg: ASbGncuNUyLCUUnaFsXRMSOZVmuFQCfcXLAOpGC5gN/267i+zCVIBOBcRdjh0IXc9LP
	ojMxuk+QMfWynmSYsyGsNdbWuPwtvcYtQqk8ineKMilz5lXp6Q3HwMPyt7QHTU4g2lYUB/rhlU9
	2R40z74HOlxMwg6rpMCDF2/uhx7L94ju4cPPuJXFK0xoQKBi798r1sqxjvXYgXqON7Xahl/jYJO
	KGSYSXh5mwE6L6yGx8qdBv5KDHXemtbU2uTsEgDeumOGSFToV42AqLUXavJJe5EMdUGNLuEg9fl
	g9KeJpfZogU26BXJr/piVVRgP4PR4k/eEQfl8ocYr5nJB1mCNziZDWygif0OwPQqjuTlidk/tC5
	CZshovnrunkAuRytLhoKVXdbO8WJ1AW89DTgNuIk6HWVflCigjx+QnWQZoox1DYEL5jIuqyAqEq
	OqG16+5AnU3rXS
X-Google-Smtp-Source: AGHT+IEnzSpQE+ROtayFnE2b4dPjTQF2CaZO9TdUfVNFcX6ejR4aNYCswD7XdVH/ajIMwYylIXY+YQ==
X-Received: by 2002:a05:600c:2287:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-46fa29f13dfmr4596085e9.14.1759782906754;
        Mon, 06 Oct 2025 13:35:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723591fcsm172334545e9.10.2025.10.06.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:35:06 -0700 (PDT)
Date: Mon, 6 Oct 2025 21:35:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eliav Farber <farbere@amazon.com>, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, james.morse@arm.com, rric@kernel.org,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, sean@poorly.run, jdelvare@suse.com,
 linux@roeck-us.net, linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
 maz@kernel.org, wens@csie.org, jernej.skrabec@gmail.com, agk@redhat.com,
 snitzer@redhat.com, dm-devel@redhat.com, davem@davemloft.net,
 kuba@kernel.org, mcoquelin.stm32@gmail.com,
 krzysztof.kozlowski@canonical.com, malattia@linux.it, hdegoede@redhat.com,
 mgross@linux.intel.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
 dushistov@mail.ru, luc.vanoostenryck@gmail.com, rostedt@goodmis.org,
 pmladek@suse.com, senozhatsky@chromium.org,
 andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
 minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, jmaloy@redhat.com,
 ying.xue@windriver.com, shuah@kernel.org, willy@infradead.org,
 sashal@kernel.org, quic_akhilpo@quicinc.com, ruanjinjie@huawei.com,
 David.Laight@aculab.com, herve.codina@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, tipc-discussion@lists.sourceforge.net,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 07/19 5.15.y] minmax: simplify and clarify
 min_t()/max_t() implementation
Message-ID: <20251006213242.3462e746@pumpkin>
In-Reply-To: <2025100648-capable-register-101b@gregkh>
References: <20251003130006.41681-1-farbere@amazon.com>
	<20251003130006.41681-8-farbere@amazon.com>
	<2025100648-capable-register-101b@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_133509_414292_10DFCCBF 
X-CRM114-Status: GOOD (  23.13  )
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

On Mon, 6 Oct 2025 12:47:45 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

(I've had to trim the 'To' list to send this...)

> On Fri, Oct 03, 2025 at 12:59:54PM +0000, Eliav Farber wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >=20
> > [ Upstream commit 017fa3e89187848fd056af757769c9e66ac3e93d ]
> >=20
> > This simplifies the min_t() and max_t() macros by no longer making them
> > work in the context of a C constant expression.
> >=20
> > That means that you can no longer use them for static initializers or
> > for array sizes in type definitions, but there were only a couple of
> > such uses, and all of them were converted (famous last words) to use
> > MIN_T/MAX_T instead.
> >=20
> > Cc: David Laight <David.Laight@aculab.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Eliav Farber <farbere@amazon.com> =20
>=20
> Eliav, your testing infrastructure needs some work, this patch breaks
> the build on this kernel tree:
>=20
> In file included from ./include/linux/kernel.h:16,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/wait.h:7,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from fs/erofs/internal.h:10,
>                  from fs/erofs/zdata.h:9,
>                  from fs/erofs/zdata.c:6:
> fs/erofs/zdata.c: In function =E2=80=98z_erofs_decompress_pcluster=E2=80=
=99:
> fs/erofs/zdata.h:185:61: error: ISO C90 forbids variable length array =E2=
=80=98pages_onstack=E2=80=99 [-Werror=3Dvla]
>   185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page =
*), 96U)
>       |                                                             ^~~~

That constant seems to get (renamed and) changed to 32 in a later patch.
I'm not sure of the rational for the min() at all.
I think THREAD_SIZE is the size of the kernel stack? Or at least related to=
 it.
The default seems to be 8k on x86-64 and 4k or 8k on i386.
So it is pretty much always going to be 96.

Linus added MIN() that can be used for array sizes.
But I'd guess this could just be changed to 32 - need to ask the erofs guys.

	David


> ./include/linux/minmax.h:49:23: note: in definition of macro =E2=80=98__c=
mp_once_unique=E2=80=99
>    49 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy); })
>       |                       ^
> ./include/linux/minmax.h:164:27: note: in expansion of macro =E2=80=98__c=
mp_once=E2=80=99
>   164 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>       |                           ^~~~~~~~~~
> fs/erofs/zdata.h:185:9: note: in expansion of macro =E2=80=98min_t=E2=80=
=99
>   185 |         min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page =
*), 96U)
>       |         ^~~~~
> fs/erofs/zdata.c:847:36: note: in expansion of macro =E2=80=98Z_EROFS_VMA=
P_ONSTACK_PAGES=E2=80=99
>   847 |         struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
>=20
> I'll drop this whole series, please do a bit more testing before sending
> out a new version.
>=20
> thanks,
>=20
> greg k-h
>=20


