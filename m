Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A606C4345F
	for <linux-um@archiver.kernel.org>; Sun, 21 Apr 2024 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgRqHtHSfZ3uIGyhmPrupjW/iBaUzgeBThW7KUcNnmY=; b=Sd/W4mJSfzic10BiKeOk7XyGlu
	yoE9OWJwgpsbR2XWWKF1jWkEEyba6pAvAS2fjpFqd6IEeWeAuFExfpVH+89nJBPw419DgDIHe3KcN
	GlRo/WPCK4s084h42eRhvd9EH1lawKDWPH2Cti1ewjvR3E+PQXYZ0UJS8EqchyCYji8NE6GA42GdI
	UlCq/Q1+l0zU7DCpfk/0Tp04roM8AmHsX619omV9ilhTJphlcuwsJf7R0uS2JzA4NMdqd9RBNvE4k
	nIG3Z8zamYGBiulMxHAScwoHlii83ttEak6VI6bMK2ys81kkKVTt25kf2bntHlVNfPPH8GCVE0hAi
	MBsoCXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryUfB-0000000AJwO-2yfd;
	Sun, 21 Apr 2024 10:43:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryUf8-0000000AJvo-0vkh
	for linux-um@lists.infradead.org;
	Sun, 21 Apr 2024 10:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KgRqHtHSfZ3uIGyhmPrupjW/iBaUzgeBThW7KUcNnmY=;
	t=1713696185; x=1714905785; b=e0tP/B58u3beFPq6sO9Zj0Y6702+oamJB33EHd9Y8voPnxG
	Ssch4+dyMdjbDIYCm4piIr3pK/RV+rYD9IqqTwwVnC63NWoSOmvxXzfG2JjjE2UX9Ra7vcXgNPGni
	JwoNXZxOe/RZO4dDjZAP2XoV8NOKnQdfx9nNh31lTwpCOArHDXhRWmicyndqftD1dJxKfEfHvwiiZ
	kwqGiDWDCahSNCHSlVC5LNe2mmTAraVBvy7E65bXrPn0FFx2SnuEVqVDf79SOUHbn8StBwLfHM7Ui
	0QdHe5iGUFWYDFethXc5wavwl4crbAkC6eKsxs474dZmV0MBQ07WnRv+e/2ThD0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ryUex-0000000GzpK-1ISh;
	Sun, 21 Apr 2024 12:42:59 +0200
Message-ID: <3cd9154ca64e7bc1aaef3481914159a27f3695f1.camel@sipsolutions.net>
Subject: Re: [PATCH v9] um: Enable preemption in UML
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at, johannes@sipsolutions.net
Date: Sun, 21 Apr 2024 12:42:57 +0200
In-Reply-To: <f70c5eda-0d2f-4845-843d-d770e4ed507f@cambridgegreys.com>
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
	 <4d5e9840b3603dbee17a1218bdcc4f8cea3c4240.camel@sipsolutions.net>
	 <f70c5eda-0d2f-4845-843d-d770e4ed507f@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_034310_592410_3B10DFF3 
X-CRM114-Status: GOOD (  31.97  )
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

On Sat, 2024-04-20 at 13:22 +0100, Anton Ivanov wrote:
> On 19/04/2024 14:47, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Wed, 2024-04-03 at 07:27 +0100, anton.ivanov@cambridgegreys.com
> > wrote:
> > > From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > >=20
> > > 1. Preemption requires saving/restoring FPU state. This patch
> > > adds support for it using GCC intrinsics as well as appropriate
> > > storage space in the thread structure. We reuse the space
> > > which is already allocated for the userspace threads in the
> > > thread_info structure.
> >=20
> > Do we need to store the FPU state even?=20
>=20
> Everybody else does :)

As far as I can tell, not really.

The way I understand the x86 codeis that it tries to leave the FPU
untouched in the hope that it will return to the same userspace task.
However, if the kernel starts using the FPU, then it saves the FPU
registers into the current task struct and sets a flag that the FPU
state needs to be restored when returning to userspace.
See TIF_NEED_FPU_LOAD, switch_fpu_prepare and kernel_fpu_begin_mask.

We have multiple things confirming this for me:
 * storing only happens if "current" is not a KTHREAD or USER_WORKER
   (i.e. proper userspace, we e.g. in a syscall, not a kernel thread)
 * we set TIF_NEED_FPU_LOAD, which is documented with "load FPU on
   return to userspace"
 * the in_kernel_fpu per-CPU boolean is set and must be unset later
 * __schedule must only be called with preemption disabled
 * switch_fpu_prepare does not save FPU registers for KTHREAD or
   USER_WORKER either

So, for me, all the effort is purely an optimization for the common
case that a userspace process is switching into kernel space for a
syscall (or pagefault), and we are coming back to the same process
afterwards without scheduling.
In that case, we can just leave the entire FPU registers untouched and
everything is great.

But, that case is irrelevant for us, because we always store the FPU
registers of userspace processes anyway (equivalent to just setting the
TIF_NEED_FPU_LOAD flag). And, for kernel tasks we never do that, but
neither does x86.

So, yeah, the more I look at it, the more certain I am that we should
basically just do:

#define kernel_fpu_begin preempt_disable
#define kernel_fpu_end preempt_enable

And, of course, add the preempt_* in various locations as you already
have done.

Benjamin

>=20
> > After all, we cannot simply
> > overwrite userspace FPU registers in UML.
>=20
> Correct, but you can have kernel threads as well.
> >=20
> > Seriously wondering about that. It seems to me it would be
> > sufficient
> > to ensure that only one kernel task is in a
> > kern_fpu_begin()/kern_fpu_end() section at any point in time.
>=20
> So what happens if you have a task which wants fpu and cannot get it
> at=20
> this point?
>=20
> >=20
> > Now, I don't know how preempt_disable()/preempt_enable() behaves
> > exactly. But I would assume it makes such a guarantee and then we
> > can
> > simply map kern_fpu_begin to preempt_disable and kern_fpu_end to
> > preempt_enable.
> >=20
> > > 2. irq critical sections need preempt_disable()/preempt_enable().
>=20
> Yes. Otherwise RAID, crypto, ipsec can mess up things.
>=20
> > >=20
> > > 3. TLB critical sections need preempt_disable()/preempt_enable().
>=20
> I think I added those.
>=20
> > >=20
> > > 4. UML TLB flush is also invoked during a fork. This happens
> > > with interrupts and preempt disabled which disagrees with the
> > > standard mm locking via rwsem. The mm lock for this code path
> > > had to be replaced with an rcu.
> >=20
> > Hopefully that flush during fork will be gone soon :-)
>=20
> Hurrah!!!
>=20
> >=20
> > Benjamin
> >=20
> > > [...]
> >=20
> >=20
>=20


