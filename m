Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4AC4345F
	for <linux-um@archiver.kernel.org>; Fri, 19 Apr 2024 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3asLfN7f5EtCcB8Rvb62A4fznCxrPy2FMOjUVZSBLSU=; b=i8UPpzcWK4n+ZdXkA3YGAsQuPv
	b4E33mb5Y0JqbjLrb8Oo63ohZaDhqrNxYD3i4xskY1yy5+PrIA+mglsMzu0CGlQIHGDe+D7jk9pXi
	jTiYFXMzWleLL9bVn4OqORr9sUYNyp+HKPUdAGC5sZ5RbtJUiuLAvLE81iAeXT1NXQgsrab1NKFza
	Eun4qjkmwXsYBmeSK/jI6E3owrQ1t5DTFKMn+0LYPjVBuom+J+ThTuK0MSnnlO9VjKoEjF4q+nXCo
	6ievXuFc/MGTdfb2w9fHjM71u0Zrw1wEpKerGYIM1Qz2EJIvlXyDq0141UHR1Ig42hHqvLiWaQ9Mo
	/miSuGPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoaH-00000005oLp-0XuI;
	Fri, 19 Apr 2024 13:47:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxoaD-00000005oKk-1vCf
	for linux-um@lists.infradead.org;
	Fri, 19 Apr 2024 13:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3asLfN7f5EtCcB8Rvb62A4fznCxrPy2FMOjUVZSBLSU=;
	t=1713534433; x=1714744033; b=xNFqWpW3ApNYvFbEaiCVnrfycXRl7U+Q2SZC46kSmN+vEHe
	eDKZkbsSclx+Km+/uIcWrF1oLiMvDiqHdKxGLgroBZcTFPZQh4ABENjh3HDFRUbWn/hsP8Pbs1arc
	xXSTmuoouPmm7fJfCv3Ip5kQEKmyxWkMeZAe9VFLb0r2jinanefQMx7fkvrB92ftP1+MK12TEWOWk
	mfgR4V5J9IR4YuAvhaalNK4mCcGLGtI247+YNOdvB429i1cLjysLsVVTtoRuebYwYp5O8WVhtE1Q5
	bnWbtTvuMAfIlb4x5PstErAItdxvTqpYL3hrsMMagzP5WapNWZTRGvwvqrXUJLVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxoZy-0000000E9hL-25c9;
	Fri, 19 Apr 2024 15:47:02 +0200
Message-ID: <4d5e9840b3603dbee17a1218bdcc4f8cea3c4240.camel@sipsolutions.net>
Subject: Re: [PATCH v9] um: Enable preemption in UML
From: Benjamin Berg <benjamin@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, johannes@sipsolutions.net
Date: Fri, 19 Apr 2024 15:47:00 +0200
In-Reply-To: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_064717_743962_1E198A6F 
X-CRM114-Status: GOOD (  12.31  )
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

Hi,

On Wed, 2024-04-03 at 07:27 +0100, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> 1. Preemption requires saving/restoring FPU state. This patch
> adds support for it using GCC intrinsics as well as appropriate
> storage space in the thread structure. We reuse the space
> which is already allocated for the userspace threads in the
> thread_info structure.

Do we need to store the FPU state even? After all, we cannot simply
overwrite userspace FPU registers in UML.

Seriously wondering about that. It seems to me it would be sufficient
to ensure that only one kernel task is in a
kern_fpu_begin()/kern_fpu_end() section at any point in time.

Now, I don't know how preempt_disable()/preempt_enable() behaves
exactly. But I would assume it makes such a guarantee and then we can
simply map kern_fpu_begin to preempt_disable and kern_fpu_end to
preempt_enable.

> 2. irq critical sections need preempt_disable()/preempt_enable().
>=20
> 3. TLB critical sections need preempt_disable()/preempt_enable().
>=20
> 4. UML TLB flush is also invoked during a fork. This happens
> with interrupts and preempt disabled which disagrees with the
> standard mm locking via rwsem. The mm lock for this code path
> had to be replaced with an rcu.

Hopefully that flush during fork will be gone soon :-)

Benjamin

> [...]

