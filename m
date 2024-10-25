Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086E9D0C5F7
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCXn1C4CxsAxZqI3UG1ULJnVNWrEv9ZEQDWdYdYqtPQ=; b=HuzBIy849TIZ3kiB0ac+0PhK+f
	fHD0JauY8yIGU7imSPTvFQxVaxBjLUfHyq10Bq+ri7rb114nb4X4oR9nHGTsi/Gau2ckrQuWkzaqg
	Ef9U+XhMnD6pDc1Xj9ZgbekA0PJEd72NhhRvBL71ufXMBVMQGVeYgCudEHbJv17XyoE6ed+czEn6u
	lHD9YgUnz/I5+7MTwyLZ0HXadqt0TrwKT9IwCO9UTCS3g6ESP8iX1aRY0++39pjxUc0DumyEpgODg
	jL+zOWpObMgIEp1Wdzy6QlyxpKiUfc8GowFt5VgMTwN5JFG5VCF4u/KtQWMvPxoB0NpWAlWJ/moyQ
	i2Aw1itw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Gdb-00000003AuW-19Om;
	Fri, 25 Oct 2024 09:29:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Gc1-00000003Alx-2ySW
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GCXn1C4CxsAxZqI3UG1ULJnVNWrEv9ZEQDWdYdYqtPQ=;
	t=1729848485; x=1731058085; b=LUB+WAQ46VnSWy+Amd1ty8ZoRvbbrgo8n+UlR8mg/AO1OPk
	7wssIHNsW66fm/p1gLHP8oqkC0ECeXil7VI3OuyGs2vlznIdlQ+1Fc7RXfqta9kuZXBMoVP6Vu5zH
	6aAF0o39XWVnTRQ4rWomegHhgVsxW65smMiKc6bRp2dleEReahki2T/wJeeuiEDIqOVmBxU9V0zQy
	aUPGonZAIea+wSzhWJ/e2QUDDJ5EgUNB7y60yaWYYwOVGnHXHIkH3xpEVvQ2gGN1zd4WZjsJvm4D0
	dARUCqyfgNGG8YIqS2ghYzuSNTX931AT3RgEmW/ou6gh5gSSPj6Z68dQLP3gXySQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Gby-00000004Skf-1fH8;
	Fri, 25 Oct 2024 11:28:02 +0200
Message-ID: <ae681534ae7c9484303c41522ec4b6a765a3d3ec.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 07/13] um: nommu: configure fs register on host
 syscall invocation
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:28:01 +0200
In-Reply-To: <de4b12980873dac3074d591ab4ee0241d81c691b.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <de4b12980873dac3074d591ab4ee0241d81c691b.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_022805_767989_4680719C 
X-CRM114-Status: GOOD (  12.02  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
>=20
> +static void sigill(int sig, siginfo_t *si, void *ctx_void)
> +{
> +	longjmp(jmpbuf, 1);
> +}

Should this code use sigsetjmp/siglongjmp?

> +int os_has_fsgsbase(void)
> +{
> +	return has_fsgsbase;
> +}

Why should this be a function rather than just exposing the variable?

> +++ b/arch/um/os-Linux/time.c
> @@ -89,7 +89,8 @@ long long os_nsecs(void)
>  {
>  	struct timespec ts;
> =20
> -	clock_gettime(CLOCK_MONOTONIC,&ts);
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +
>  	return timespec_to_ns(&ts);

unrelated changes

>  #ifndef CONFIG_MMU
> =20
> +static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
> +{
> +	if (os_has_fsgsbase()) {
> +		switch (option) {
> +		case ARCH_SET_FS:
> +			wrfsbase(*arg2);
> +			break;
> +		case ARCH_SET_GS:
> +			wrgsbase(*arg2);
> +			break;
> +		case ARCH_GET_FS:
> +			*arg2 =3D rdfsbase();
> +			break;
> +		case ARCH_GET_GS:
> +			*arg2 =3D rdgsbase();
> +			break;
> +		}
> +		return 0;
> +	} else
> +		return os_arch_prctl(pid, option, arg2);

please use (or don't) {} on all branches


> @@ -39,4 +73,5 @@ __visible void do_syscall_64(struct pt_regs *regs)
>  			current_thread_info()->aux_fp_regs);
>  	}
>  }
> +
>  #endif

unrelated

johannes

