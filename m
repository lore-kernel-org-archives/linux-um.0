Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC045C1B0D9
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJBErG/pSE3mwR2gO0Zf0GO3sxAtsZqzG79Fy9J4HfA=; b=4kCR7e176hnC4MrZf8Hl87B39U
	DwK7h7IpZiL80Xp48m0gV5GH4CW+pUOnSBoFPpHSXRcVX+TvyrilpeLzdc6kfNTU6IENvPcuMpJAZ
	t0pJnJDNanftMPu/ZKCQTmqeB/oYpf9Uz+rwonvnmu0KhUR/ldg3QRatwDkfZ+mWW9udi8QcdxGE7
	gjzkpIzbCsriAwKNPYYeaX7BtgYVLiU7xt0RoxHuajwhQm6WlcXYSSw7IHpqKnW+BGQHBVvshPeCP
	d1GjbYm+anudSMZQz+QNitEn6x3Q17ND1cL8mCNo23xyMMvgei7knZ+vmf6wNK/mzedASV+YrIkQH
	c/xU9VgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnIYI-0000000487A-1mwG;
	Wed, 26 Feb 2025 14:38:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHJy-00000003ohN-0C4N
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 13:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qJBErG/pSE3mwR2gO0Zf0GO3sxAtsZqzG79Fy9J4HfA=;
	t=1740575967; x=1741785567; b=EFuc4s2SFRxf/O2C43/ElAU9gJggzaA//bEJIhZ1XcLIfwu
	901YjMOumdFETZUgj75sLvJwbYot2z0y6C7VxxsWw1G9WXNlvUYGOz4B0gA57qrjKERd3CSHR0cp/
	h82UXtjGLSmNqZv41akJHQpR9DrVtoOdM8jBauh/4IBsFlnRwEVw4R5dyNcW1Fwb89Pbk+Mkic3fc
	VzsDY6CZKva4Qc+dyic1d0Z+Q63CVcdp/HaXIWIsph4s0/tAmDL3Fut9nQlqyBks+nf4F1pWtH1It
	N3E+Po67uwEiiiXP78B8RkLZ2eMm6WjMAr6zkYe25fRYbj92vbrX3ph4ELf8f5Tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tnHJs-0000000BUdH-0WaR;
	Wed, 26 Feb 2025 14:19:24 +0100
Message-ID: <159a83bf5457edbabcc1e88ee5ab98cf58ca6cb0.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, 	briannorris@chromium.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Date: Wed, 26 Feb 2025 14:19:19 +0100
In-Reply-To: <Z78SVdv5YKie-Mcp@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
	 <20241217202745.1402932-4-benjamin@sipsolutions.net>
	 <Z78SVdv5YKie-Mcp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_051930_093225_6906336B 
X-CRM114-Status: GOOD (  20.39  )
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

On Wed, 2025-02-26 at 14:08 +0100, Ingo Molnar wrote:
>=20
> * Benjamin Berg <benjamin@sipsolutions.net> wrote:
>=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > The init_task instance of struct task_struct is statically allocated an=
d
> > may not contain the full FP state for userspace. As such, limit the cop=
y
> > to the valid area of init_task and fill the rest with zero.
> >=20
> > Note that the FP state is only needed for userspace, and as such it is
> > entirely reasonable for init_task to not contain parts of it.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAM=
IC_TASK_STRUCT and use it on x86")
> > ---
> > =C2=A0arch/x86/kernel/process.c | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index f63f8fd00a91..1be45fe70cad 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
> > =C2=A0 */
> > =C2=A0int arch_dup_task_struct(struct task_struct *dst, struct task_str=
uct *src)
> > =C2=A0{
> > -	memcpy(dst, src, arch_task_struct_size);
> > +	/* init_task is not dynamically sized (incomplete FPU state) */
> > +	if (unlikely(src =3D=3D &init_task)) {
> > +		memcpy(dst, src, sizeof(init_task));
> > +		memset((void *)dst + sizeof(init_task), 0,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch_task_struct_size - sizeof(=
init_task));
> > +	} else {
> > +		memcpy(dst, src, arch_task_struct_size);
>=20
> Note that this patch, while it still applies cleanly, crashes/hangs the=
=20
> x86-64 defconfig kernel bootup in the early boot phase in a KVM guest
> bootup.

Oh, outch. It seems that arch_task_struct_size can actually become
smaller than sizeof(init_task) if the CPU does not have certain
features.

See fpu__init_task_struct_size, which does:

  int task_size =3D sizeof(struct task_struct);
  task_size -=3D sizeof(current->thread.fpu.__fpstate.regs);
  task_size +=3D fpu_kernel_cfg.default_size;

I'll submit a new version of the patch and then also switch to use
memcpy_and_pad.

Benjamin

