Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79731CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQeiokNHrgw9YYENbvFNee9O5+3YdnuhO4OZp/5Gs/4=; b=CH31e3VXB2GQAQ++G1EsBsKeG4
	6bZTQhbCBdCBSwS91YA0aL5vGLtzdIL3w6zgIXeuybekrMVJ+kWuJbph+jrWNAWUpHKvoA7HGudxN
	6HpPizflHddiNcGXtgSJW90FRPRtoTotJsq/nCt+ZsTbNN0jgVCG7OVHxLb6VWtAtF0GVkSA3F4SO
	BBbzmGHGN/HASOV+GGSiufr6OjZo5keMGrm+VP9rE2fJdx1OoqZjgZ+VdA2BaJZ0/l7OWED/ifnRn
	Adob/fik4YLSjKLqIlLEfwptkkOR5wjXBgvtqCc+PcqkuuPXngoGvxO9q3qtK6+GUSWUOZYARZk1u
	iOGLADSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQXJn-0000000BxZm-3nP4;
	Fri, 22 May 2026 21:22:07 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQXJl-0000000BxVU-0f3F
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 21:22:06 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49048e043e5so5878455e9.1
        for <linux-um@lists.infradead.org>; Fri, 22 May 2026 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484923; x=1780089723; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQeiokNHrgw9YYENbvFNee9O5+3YdnuhO4OZp/5Gs/4=;
        b=PuEt2Vk02aAu2nOCrjbbcMi2zagvOV9sVsWcq5jkOrEmU7Ga5l2tJs/M0Y2XJNu4y9
         +n/Sm5VLLHTYzsb4Kquenl3LjGLyciHXdl6tt0B0AxpOlRsqiWVgdRbApsHgoI0tmJ0o
         g84qJ/cQJEro640pPCz1jcmxFiKitfHj/MMRRTs2Tt7BGecy3cR/4Z6i6/lTMfzAbAXc
         +h2VWIJPCN3VetYuHyFQtXJdJKBHOuFIBfgtID7McKmqqk4fGK7qL/+A/H3OPjkfcoep
         cE4ftUMFULxzkXBvl/ZzyXcDC1MEJF6aWBZpneCxPoktWHZHGSxWzU1DGaHN+it81slv
         RzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484923; x=1780089723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQeiokNHrgw9YYENbvFNee9O5+3YdnuhO4OZp/5Gs/4=;
        b=pRSHnXD6tU9EEvtBlltrF4GPz8a3KzeGirMwAdYpgRBmiFJlCMbWHT6rH51eXG+XyX
         nlOlKvXba/WTTqKJm4RQYKhWwaacC3W+7PcanS5FVSKMKUvdDn2ROGaG2VjZ7lTXpp4E
         qlYu72p+brXDwVZpaeSmf81WOUolQJHY7Uw29prVBPNeEoZ8bExtHk7hEnTvLCIdB9Hf
         RLSrsNq/bg2Mg1kZ/D4wS52KfOWwke7cKisbuo3jThAm4Ec5nRFXFQN17co5uHM0fSjn
         L5AuhXwyqUJ1whoQCU+8qO8SdeQPeb7CHc9sSPA1wwt+hjuCO6g5d4tyRDsZjKtVQjr6
         JCBA==
X-Forwarded-Encrypted: i=1; AFNElJ8eAHavcemP1eBBw1wnVLeTLiRTLuikfGGeZuAsh13EKTZmR4WBSglPOmEqG0f+hCYYUE1Rt+GH+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2XTx7ZQ4sxaFOOZyKAcFnhNfIdsORyUUuMDKn53EULhWOe/TW
	qLVWMKNtBCsTO02WLGPntwGNIGY2gZwjW3ZfyNNA/3hhEBECVlLWkrui
X-Gm-Gg: Acq92OEbpclqDPsqj7rst19+9Gp6eeM6+lvPpenlDf1XxdGHMmpj9eT8GbicMEXkUA9
	8z8TqmSIfLTD2dPyZzTLFTq4cbOyCykn66su7g/HxH8o3wkFubQ80uEWs0h6SWRGa+UvbALwUPS
	Al6ZGRfQ6m3np6Nas5AIiHb0F2EJRiRNOWRnJderXaM8KYElFEg8Vb/vIaW9ajOowgDCnK4Oqt1
	9TyAKwfF47k4sAi/NQc7xyIyCZDTzBSlcMfRMjaDdWz7tlWd73mCWjXCqR62Vu13HUnFE4IrJrz
	otGR3OCXfwY69igS7ZzHaH/1GubCmD0XMfjrQlvE3wh60qZuMrdw7CbEfxOh725AMrt1MZs2oDy
	W1Dl/thBvEKDRwebHRxWZ1lkz3CVMv32QC42r7JLuU4SsNnYMl820Q4kiq4fmKcm6tvAxSNsU2K
	yHiJenQGyt6+cbMqmaTNDDvImJg5o2nIZUxbVzc+BH/U+xa1q05KXTQRUKYJfKQK1A
X-Received: by 2002:a05:600c:3b02:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-490425ac8a1mr76344765e9.10.1779484922424;
        Fri, 22 May 2026 14:22:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045620c05sm66878075e9.14.2026.05.22.14.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:22:02 -0700 (PDT)
Date: Fri, 22 May 2026 22:22:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>, Anthony L Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
Message-ID: <20260522222200.50bcdfdd@pumpkin>
In-Reply-To: <be2e816b-3940-4d1e-922f-2c4687d3e09b@suse.com>
References: <20260522141959.1071595-1-arnd@kernel.org>
	<20260522141959.1071595-6-arnd@kernel.org>
	<57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
	<caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>
	<be2e816b-3940-4d1e-922f-2c4687d3e09b@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_142205_231256_37B2EA46 
X-CRM114-Status: GOOD (  22.38  )
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

On Fri, 22 May 2026 21:00:00 +0200
J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote:

> On 22.05.26 20:54, Arnd Bergmann wrote:
> > On Fri, May 22, 2026, at 17:46, Juergen Gross wrote: =20
> >> On 22.05.26 16:19, Arnd Bergmann wrote: =20
> >>>
> >>> --- a/arch/x86/xen/Kconfig
> >>> +++ b/arch/x86/xen/Kconfig
> >>> @@ -10,8 +10,7 @@ config XEN
> >>>    	select X86_HV_CALLBACK_VECTOR
> >>>    	select HIBERNATE_CALLBACKS
> >>>    	depends on X86_64 || (X86_32 && X86_PAE)
> >>> -	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
> >>> -	depends on X86_LOCAL_APIC && X86_TSC
> >>> +	depends on X86_LOCAL_APIC =20
> >>
> >> This is problematic. See commit 93cd05976498.
> >>
> >> Maybe use "depends on X86_LOCAL_APIC && X86_L1_CACHE_SHIFT >=3D 6" ins=
tead? =20
> >=20
> > After patch 6/8, this is always true, so I suppose it would
> > if that came first, right? =20
>=20
> Yes, agreed.
>=20
> >=20
> > On a related note, are there still remaining Xen users on new
> > 32-bit guest kernels? I understand that one could still run
> > modern kernels on 32-bit Xen-4.2 (EOL in 2015), and that 64-bit
> > Xen still supports older 32-bit guest operating systems for
> > compatibility, but I'm not sure if there is any reason to
> > legitimately run a 32-bit linux-7.x kernel on a 64-bit Xen
> > instead of running a better supported 64-bit guest kernel. =20
>=20
>  From the logical point of view I totally agree. OTOH users are humans,
> so they might not agree with that. ;-)

You might just want to test a 32bit kernel ?

-- David

>=20
>=20
> Juergen


