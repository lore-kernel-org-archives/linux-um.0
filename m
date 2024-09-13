Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD878FA374F
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=38wjfwv96R7PV+or++4lZxSYB68YsenvfPo2Wumq7JU=; b=xQhWmpTb/m/siE9dWkothzJWz/
	Cw/iTOxeh4/SzMgM+5ogZVFEK91VKomgXVM7LFD9o80w3Yg9tLO+cH96LmEVYiKHiYDqGC2vroUXq
	nHrf5Qp2MlP7s2fZtwsxmt8o3n/L+vhGJE/7+HfCvqXg76dzvjBhAKTpIiEiDDUZOkDwac0C0K3EQ
	9iVi9HLOjYzjzPb1B6QPBwYiQuZqDpvC9bDL8CFaywaOCL7sChMU8AmABLOcsfC5H8GcKHD3TmXO5
	ppEfRsGZCy/Rlr0ZVmBlNNuWymMNPnFNLEsx5cSeZcNx5LeqYG3ps+rcF36U2TMss44mQxIq1mknV
	4fpwt0EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6BU-0000000G0SO-1ave;
	Fri, 13 Sep 2024 13:18:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6BS-0000000G0RD-0itV
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=38wjfwv96R7PV+or++4lZxSYB68YsenvfPo2Wumq7JU=;
	t=1726233477; x=1727443077; b=c2AydlB2YEpMwN2sB2SjH/g7G2qE6cVEWMg2XGAg0rks2e3
	LPixLwV/wdeo5NgKC8DzJzgjlNE8HCBhew3EkBAIccmZxJS+q851jDrWGBS/2JE5tzazaLozlxeA4
	qJGhOb4DDXhgpfiiKX5uslupRaZhD6AYvDnux1LMuiirbnsO8t9dsS2TB0FYBMWXKI+7Rsjp3Lwb1
	N871rbTMg26SNoCM8Q8th/MK0kFtRILa+pTXRY8lzSts/K2iT4PY0RlFP13KzCIiMBYYtM6u6Neq4
	e1PKQxXgqiogFIb5X7VNHHMViE2OehDzCLKg+iLdp3l+XUgo/OEpGdEXR1Ut6xzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6BO-0000000GV5j-3zbs;
	Fri, 13 Sep 2024 15:17:55 +0200
Message-ID: <5e7c3ceb4adeeab1fb9f6295cb2abc4691b47ff3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: always use the internal copy of the FP registers
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
Date: Fri, 13 Sep 2024 15:17:52 +0200
In-Reply-To: <f6422fd4-ac5c-407b-a0f4-e4fefed02dad@antgroup.com>
References: <20240913082244.767799-1-benjamin@sipsolutions.net>
	 <f6422fd4-ac5c-407b-a0f4-e4fefed02dad@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_061758_233556_9B7A84AA 
X-CRM114-Status: GOOD (  13.07  )
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

On Fri, 2024-09-13 at 21:09 +0800, Tiwei Bie wrote:
> On 2024/9/13 16:22, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > [SNIP]
> > diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> > index be2856af6d4c..ad798d40f8a4 100644
> > --- a/arch/um/kernel/process.c
> > +++ b/arch/um/kernel/process.c
> > @@ -290,8 +290,15 @@ unsigned long __get_wchan(struct task_struct *p)
> > =C2=A0
> > =C2=A0int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset=
_t *fpu)
> > =C2=A0{
> > -	int cpu =3D current_thread_info()->cpu;
> > +#ifdef CONFIG_X86_32
> > +	extern int have_fpx_regs;
> > =C2=A0
> > -	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu)=
;
> > +	/* FIXME: A plain copy does not work on i386 with have_fpx_regs */
> > +	if (have_fpx_regs)
> > +		return -1;
> > +#endif
> > +	memcpy(fpu, &t->thread.regs.regs.fp, sizeof(*fpu));
> > +
> > +	return 0;
> > =C2=A0}
>=20
> This function is expected to return a boolean value which should be
> true on success.

Hah, of course. And there I was partially doing all of this because of
your patch fixing exactly that problem (and because the current code
cannot work in SECCOMP mode) =E2=80=A6

Benjamin

