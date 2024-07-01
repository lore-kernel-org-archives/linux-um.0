Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C76DC2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvHSmQn3rtquN3teuP1g0DUjh0TDnOi2v2uajB4mw4M=; b=2T0X6d4yZwiARyjU2AVheMhX84
	xKURxuJtG3NPDf4ARicc1cnlz20ryy/qoISFs5k7nfHA04qk7/x+eSmEG+oIVxyvsCBRfPnOnZ8Rz
	fguxIyQkrYjG2QWXERETw+aur8rhvsL66v83cWbMaiWMN3kscOQwfchlWXmZIbkI17VJXDGCuc84Q
	60GqV4Pi5ZVYAVNxfvtWmEtkwJXosL8/4ZOuGfZXx4Pio2/dMbttHjhUV0KUVh6Ya6CUYN5TVzK4w
	UQ+f9ubhN68zn+LXNpEOxFEcFd+qzpRDF//CpNdDwN4BFmJmESBfPqEf9PvZaoWuXCoV/LAmoSETu
	0wRWPv2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOJMR-000000041Ix-2EYt;
	Mon, 01 Jul 2024 15:54:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOJMP-000000041IB-0AmP
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 15:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GvHSmQn3rtquN3teuP1g0DUjh0TDnOi2v2uajB4mw4M=;
	t=1719849272; x=1721058872; b=OLzmkzNdYEij255lvrMS1iHNkMrOvZfEzB0SL2Tzr68ZMvB
	nZDLqTp0/EJAkshKFdRL4NSsldUiA5cs5sHneE+Cs7YfSV8r46n1i218TSwltTN+PR4ehP19V/PD3
	v9qd1mZg/TAKkUNrrak9MkzRj0o1biAqN4DVby7rIFSx6oVgf105FzHEXqvKhK2d0EeyuQQyx0iQM
	HwlWF51QzHbqoZnGs7SYuKhj8zyf6343plN0b2rjkbeKr8YH9kH0akl/y9pWgFgYFuqiOp8HGPlC0
	A6ZOuPvVNcQx1gG7Kh3mgNohwxXYbbudB5AKfy57ngix+EXlbMvXW4IoSatnaFcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOJMK-00000002eu4-3fms;
	Mon, 01 Jul 2024 17:54:29 +0200
Message-ID: <6969757a8347ad5171a651fb668a28613b08176d.camel@sipsolutions.net>
Subject: Re: [PATCH v9] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Mon, 01 Jul 2024 17:54:27 +0200
In-Reply-To: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_085433_099974_C2D0433E 
X-CRM114-Status: UNSURE (   7.46  )
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


>  arch/um/Kconfig                   |  2 +-
>  arch/um/include/asm/fpu/api.h     |  9 ++--
>  arch/um/include/asm/thread_info.h |  4 +-
>  arch/um/kernel/Makefile           |  4 ++
>  arch/um/kernel/fpu.c              | 71 +++++++++++++++++++++++++++++++
>  arch/um/kernel/irq.c              |  2 +
>  arch/um/kernel/tlb.c              | 13 ++++++

In addition to what Benjamin pointed out (FPU state is in the MM
process, so we probably don't care about save/restore), this also
doesn't build any more, at least it needs:

--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -31,7 +31,6 @@ obj-y +=3D syscalls_64.o vdso/
=20
 subarch-y =3D ../lib/csum-partial_64.o ../lib/memcpy_64.o \
        ../lib/memmove_64.o ../lib/memset_64.o
-subarch-$(CONFIG_PREEMPTION) +=3D ../entry/thunk_64.o
=20
 endif
=20

git am also complained about the extra blank line at EOF here:

> +EXPORT_SYMBOL_GPL(kernel_fpu_end);
> +

johannes

