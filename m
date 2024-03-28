Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7BAC54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FA4Cn+pmv1Kg4NDGNqq3mJRB3KCvrBOaWwuzbFCLltY=; b=vzExiqh2tc9d1247p+N4GKoroy
	uoolX9tdGoLRNCnZSKStMlXd3OMMv4yA3kxup9Zkjy/CLZ3ODBmidZVL8GliPWP/E+vAOGe4vAd49
	fCX/3rx5JeGQgS5x2eVPHCBnCYuOK2ORj6yXW6unnVxcQRxvPOuhPKU9u/v7t2sweMSTU0oJz+sY2
	pNHxw2b4WMtUYRFgikPpGbFr3avdl1cTrpB8KCYFuwIQLpGPPhhPHNqb9Yrawpor8UZ0caVmGwMqs
	0OhYJQXXiKse97Fzbxflr7UEVZmifJz1QgoWtBJT0Gs3EGOqM0k65om11T4IKV5izoqr2byhNgP9x
	ghfXZV8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpm2p-0000000DKtf-0y0L;
	Thu, 28 Mar 2024 09:27:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpm2l-0000000DKsi-1cd4
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FA4Cn+pmv1Kg4NDGNqq3mJRB3KCvrBOaWwuzbFCLltY=;
	t=1711618050; x=1712827650; b=h99+AhlqL9q3pfaf4wxNRokWT7iFRBcz8xRGTiG1iKfl50V
	YRDAw5Ig5gG6t47LiRx66TIO1jKwZFYKorg5fnajzAVHAUzkkUkRB3PkBTIJW7WeJVHxh6JTHkTGJ
	Uyn7ZTE1UUh03r7SgbPWfvsgW0dbdH/3Wz9QiNlHp8VyZQ8nPdPsMZA5kCq4hd3lZDC/9wy54lTeN
	htsPqu2EOPx3WSCAjyJqGi4yKuKj8xjEzf9+10iJyVxzJl7FVuvsWkxIatz+uaDm5Frv3UvyaODbJ
	plkSUG2AeHOIjqza/I3Xh1ZOmEMzu1b6vrNaxSCEBtaxNE6YdT90OxYz5MRZdm1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpm2h-00000000pSe-2vpa;
	Thu, 28 Mar 2024 10:27:28 +0100
Message-ID: <4ffdc415c692236dc13302b5fc0290316a17b7cc.camel@sipsolutions.net>
Subject: Re: [PATCH v7] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 28 Mar 2024 10:27:26 +0100
In-Reply-To: <20230928091042.1422353-1-anton.ivanov@cambridgegreys.com>
References: <20230928091042.1422353-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_022731_577646_CD12DF0C 
X-CRM114-Status: GOOD (  10.73  )
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


> @@ -23,7 +23,7 @@ struct thread_info {
>  	int			preempt_count;  /* 0 =3D> preemptable,
>  						   <0 =3D> BUG */
>  	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
> -	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restor=
e
> +	unsigned long aux_fp_regs[FP_SIZE] __aligned(64);	/* auxiliary fp_regs =
to save/restore
>  						   them out-of-band */

nit: that comment looks strange now, maybe pull it up before the member?

 /* auxiliary ... out-of-band */
 unsigned long aux_fp_regs[...] __aligned(64);


> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current_thread_info()->aux_fp_regs, KNOWN_3=
87_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave64(&current_thread_info()->aux_fp_regs, KNOWN_387=
_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current_thread_info()->aux_fp_regs);
> +	}

Why not write this as a chain?

	if (likely(cpu_has(...))
		__builtin_ia32_xsaveopt64(...);
	else if (likely(cpu_has(...)))
		__builtin_ia32_xave64(...);
	else
		__builtin_ia32_fxsave64(...);


and IMHO pulling the "&current_thread_info()->aux_fp_regs" that appears
on all three of them into a local variable would make that more readable
too.

> +#else
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt(&current->aux_fp_regs, KNOWN_387_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave(&current->aux_fp_regs, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave(&current->aux_fp_regs);
> +	}
> +#endif

And all of the above also applies for 32-bit,

> +void kernel_fpu_end(void)

and this as well.

johannes

