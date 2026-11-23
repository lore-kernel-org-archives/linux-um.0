Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E0606A31A
	for <linux-um@archiver.kernel.org>; Mon, 23 Nov 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NYRgqzJb;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=U9z+BU4m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wlk11jmoyLLtkFLQIX1szurCVKjnQyUA7rrp5GNsTak=; b=NYRgqzJbAlOOonFGbCU+XoCrUm
	UI2hiTTi8NdaF4CTXc4Pz/pyudAAmGs1nuD6w8emZj3sw7EYFWeA05z5hzlt3CYapra32JK5MmwSc
	yLinqNmLBEYO3uYS8Js6ZzBx2eHf5hGc4CyazD7evYyJ3vSYO33j18Bo2LIsge7f2rf60etkyBO7I
	zulLnkhDEmq55M3Lnh4wLFx9ifWfieTrUkYWmIJ3vUAwcsA046WCLGH1ePo/WzRGxyOzb2tbq+OEn
	550mlch4v/6/xNnJ3cQhBoK3yAcgSioUQ5aNgowK+oN4ITnbECeg5jRlf1res0AEO/7j61/8jdiAw
	nPaelt1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVQd3-00000002oAx-3bC6;
	Mon, 23 Nov 2026 09:46:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVQcm-00000002o5M-2ybm
	for linux-um@lists.infradead.org;
	Mon, 23 Nov 2026 09:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wlk11jmoyLLtkFLQIX1szurCVKjnQyUA7rrp5GNsTak=;
	t=1795427172; x=1796636772; b=U9z+BU4mSMvRiKZOp7c54l+SXhwHDBkvZI9n9W7UWTu300a
	R7STVwjCtNCjdtCHSrq/zR0kIoL4dN/m/UWyQZjoVJI1daSUyvC86nvZr+6bkOPeUDLs3GiSJQCqW
	yzWS0KcjlX8ZHgJHEypJTRV0BIBtgQthD32cC9VC9Grwaiz+iPAGyB+bDKaYQhlk6FJehoVscNdTx
	zB5+kV/gz3Z5x++NV1r1MbgqUQy9fDm2V6ubU/5Md0bTsbt+JbUV3Bl1gZzsCssKkmeZhZkfS94q0
	06oslWpkto9uji9LPBjfI8Cok1bpruuPSnxnLcklppNPrN0NEPqXOe7sVSS8vX/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1xVQch-0000000AAYZ-1c1Q;
	Mon, 23 Nov 2026 10:46:07 +0100
Message-ID: <97f7310b1acc79a6ac8905e2c2c0356cb9f86b21.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5] um: time: use the host TSC as clocksource for the
 vDSO
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>, 
	linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Thomas Gleixner	 <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Date: Mon, 23 Nov 2026 10:46:06 +0100
In-Reply-To: <CAB2K5aAw7FOAabNZKNV2=dWO9G0wL5OBQrs0oSjGKGwP7jgY5Q@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
	 <CAB2K5aAw7FOAabNZKNV2=dWO9G0wL5OBQrs0oSjGKGwP7jgY5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_014614_357917_6E0D50C9 
X-CRM114-Status: GOOD (  13.28  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sun, 2026-11-22 at 07:42 -0600, Haikal Firmansyah wrote:
> [SNIP]
> @@ -945,11 +1022,30 @@ static void __init um_timer_init(void)
> =C2=A0		return;
> =C2=A0	}
>=20
> -	err =3D clocksource_register_hz(&timer_clocksource,
> NSEC_PER_SEC/TIMER_MULTIPLIER);

This patch is malformed, something incorrectly inserted a newline here.

> +	/*
> +	 * Calibrate the TSC before registering the clocksource, so the
> +	 * timekeeper (and the vDSO) use the TSC rate from the first tick.
> +	 * On failure keep the old os_nsecs() clocksource: timer_read()
> +	 * falls back to it and vdso_clock_mode stays NONE.
> +	 */

I expect that this fallback also needs to be done when UML is running
in time-travel mode. In that case, the clock is independent from the
host clock so this optimization cannot be used.

Benjamin

> +	um_tsc_hz =3D um_calibrate_tsc();
> +	if (um_tsc_hz) {
> +		um_tsc_ok =3D true;
> +		timer_clocksource.name =3D "tsc";
> +		timer_clocksource.vdso_clock_mode =3D VDSO_CLOCKMODE_TSC;
> +		pr_info("UML: TSC clocksource, frequency %llu Hz\n", um_tsc_hz);
> +		err =3D clocksource_register_hz(&timer_clocksource,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u32)um_tsc_hz);
> +	} else {
> +		pr_info("UML: TSC calibration failed, keeping os_nsecs() (no vDSO)\n")=
;
> +		err =3D clocksource_register_hz(&timer_clocksource,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NSEC_PER_SEC / TIMER_MULTIPLIER);
> +	}
> =C2=A0	if (err) {
> =C2=A0		printk(KERN_ERR "clocksource_register_hz returned
> %d\n", err);
> =C2=A0		return;
> =C2=A0	}
> +
> =C2=A0}
>=20
> =C2=A0void read_persistent_clock64(struct timespec64 *ts)

