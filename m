Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31959D0C5F6
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFsw/tzAfvYUM0vHU4s7P8IrJU3dk+UIrwXE/KVLcNc=; b=1llyQapegJ6rtkJo2ZAVgu6OTF
	q2FWF0hHNIgmFmLAkgg7t6H4GF9CZwIphMPkCMffF+MVJAG42eKd/EQQBT/LPv6/NRCxBIgvtiiAT
	mdN/v74Hg6Gn4/kOG9f/1ZwYILHr+LvCekEl9tIvbZG2tGNY5bSbt57K56lgE4fQP4uMLsWfGUbh6
	frKugPki7tLcXddtdJQ+iDZu/yjyn3DGtzaP2nhhDnygrZKKsKpngizAw9LhxVpv8x+nEWwj54DUe
	BtsgFZnJoE1HBz5GM3IrryR571+2HomMbYYxBgmHpTYgEx2Gv1Gw2X+9UsV0qKfGdy1Oz4oNNOIbA
	mnOLJukA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ged-00000003B6q-3sGJ;
	Fri, 25 Oct 2024 09:30:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Geb-00000003B6N-1LMF
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zFsw/tzAfvYUM0vHU4s7P8IrJU3dk+UIrwXE/KVLcNc=;
	t=1729848645; x=1731058245; b=evg95NQXa+sDtkeOBPivLCzQTCoUL+53E1ba411ggqDYimQ
	x1WJkgqjtz5zSLtxr8cR+sIK0F3Mdc63Av8o29l1YaPnbS+DgduFyXBf+z5vNeKtNqzchyh/gKqcX
	4hyia08G1K8903I04FaK+V+BEt7NXrNvCB6oqvV08DKbY4Uf2M6+2XKIvDjb8Ia6ndXT590RTyeFT
	YmEE9o4L6gk46gfRD51gbqguV2RXndi+ZM/73410PG0VMfSEvnJMs7pKY3zaMSXSHAbyNRrYBBVnZ
	iYIVxRskmJjg1L3Xhtsf77n7gMAvlqQS2MjcZ76lyf6YJzm+WdWY2oyCVNyCKVFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GeY-00000004SpG-3CVn;
	Fri, 25 Oct 2024 11:30:43 +0200
Message-ID: <1bc0681692a102674c73d10132f3228301cc784b.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 09/13] x86/um: nommu: signal handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:30:41 +0200
In-Reply-To: <f3c873365cccce18b2f1889984bf521d3cfb68f2.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <f3c873365cccce18b2f1889984bf521d3cfb68f2.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_023045_378403_BDEDC911 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
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
> This commit updates the behavior of signal handling under !MMU
> environment. 1) the stack preparation for the signal handlers and
> 2) retoration of stack after rt_sigreturn(2) syscall.  Those are=C2=A0

typo: restoration

> @@ -562,6 +574,20 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	unsigned long sp =3D PT_REGS_SP(&current->thread.regs);
>  	struct rt_sigframe __user *frame =3D
>  		(struct rt_sigframe __user *)(sp - sizeof(long));
> +#ifndef CONFIG_MMU
> +	/**
> +	 * we enter here with:
> +	 *
> +	 * __restore_rt:
> +	 *     mov $15, %rax
> +	 *     call *%rax (translated from syscall)
> +	 *
> +	 * (code is from musl libc)
> +	 * so, stack needs to be popped of "call"ed address before
> +	 * looking at rt_sigframe.
> +	 */
> +	frame =3D (struct rt_sigframe __user *)((unsigned long)frame + sizeof(l=
ong));
> +#endif
>  	struct ucontext __user *uc =3D &frame->uc;

you shouldn't put code in the middle of variable declarations ...

I see why, but probably just split #if/#else/#endif?

johannes

