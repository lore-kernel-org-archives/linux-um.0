Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F2CD4F5B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fngI9iXD/Vt333vVElkGNHSilob1i0AAeft9TEJ0Eow=; b=3MYMAPXpxxItOZ
	Ibm6PIjgOAU7Ghi+e82kyJFGGZzAuN76pdDXG9JNRo60tOOuzZvdQAMsl/CjsIjfEatlMfbeXXjPb
	Dn1WzPVykH5TESpQ7dkccA/9QHTEGinjGq628SSt/MKUQl6tm7Wn+kw/PAdiI260EqonI5Ngyy4nh
	QW48DGIkQvv3cMmoxtRmP86paj38myeYxxjpxzDCOJz+CHQYgZ0iY1Mq0ZaGvsunLviq+AYJ61oBE
	Ax2mXbzLVveTkYK7hzP2iDEcLlGRyKZGdtnzp9XFHlI8FaLCj0le/tpHr5MGX35vVe/ceeB6ZVXaX
	ZgqSnRSQY149cCla5B6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjeFQ-008wix-1L;
	Fri, 22 Sep 2023 11:23:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjeFO-008wiQ-04
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 11:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v9GSS8wG7Qox+rlkpZcscFaKok8LRPlfQlOBE7EbSII=;
	t=1695381777; x=1696591377; b=fftr2IH90sQ+MdtBRsHzBBE7Ojqq/DCyb6UtIKF1/fqwAxH
	IwVAsWWpO1b+kANUCgdAYJgqs42bFk7JVnVZNXNYSzloW0+9J84uc/ahp36pdpZE7dTv+caMtQbc8
	E1xU54AIQmNmoJMc9ehta1Zbj8kudwIJLbYiy5q3dd7Eyi9y0Jw7sTHeJohZ1dZ69UX+e37aZ3tdW
	Q30BpFHh76Wq6/8B9UHQsUSezXntwHwq83pKQGK1VD9tI98l45MHopgPv/GekVRkmZuRZF1AQfj7V
	oIjaB+x05gb5/jQzAiiVLIsvH45fQ9SPD+5Duf124awc2tBN+Y1i+c5TmC8oHV8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjeFM-00FDgy-06;
	Fri, 22 Sep 2023 13:22:56 +0200
Message-ID: <389fbd9de31ccdaad52674b7de06312e57f2cd54.camel@sipsolutions.net>
Subject: Re: [PATCH v6] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 13:22:55 +0200
In-Reply-To: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
References: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_042258_059028_8108CEE7 
X-CRM114-Status: GOOD (  19.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

> 
> 4. UML TLB flush is also invoked during a fork. This happens
> with interrupts and preempt disabled which disagrees with the
> standard mm locking via rwsem. The mm lock for this code path
> had to be replaced with an rcu.

For the record, even if I figured out this gets rid of the complaints,
I'm not entirely happy with this - yeah it's safe now, but it still
feels entirely wrong.

But I guess we can also do this and then remove it entirely like the
patch I just posted. Order probably doesn't matter much.

(Note my patch removes the locking completely since it's now invoked by
the kernel even under write mmap lock.)

> diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
> new file mode 100644
> index 000000000000..4817276b2a26
> --- /dev/null
> +++ b/arch/um/kernel/fpu.c

> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current->thread.fpu);

:)

OK, I'll stop mentioning it ;-)

> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +

git am complained here about blank line at EOF

> @@ -597,8 +609,13 @@ void force_flush_all(void)
>  	struct vm_area_struct *vma;
>  	VMA_ITERATOR(vmi, mm, 0);
>  
> -	mmap_read_lock(mm);
> +	/* We use a RCU lock instead of a mm lock, because
> +	 * this can be invoked out of critical/atomic sections
> +	 * and that does not agree with the sleepable semantics
> +	 * of the standard semaphore based mm lock.
> +	 */
> +	rcu_read_lock();

Yeah I guess ... Seems like a very mechanical description of what's
going on, rather than a description of why this is correct (which
assumes no preempt and no SMP)?

I'd have preferred that, but with the patch I just posted we'll just
kill this entirely so it doesn't matter in the end.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
