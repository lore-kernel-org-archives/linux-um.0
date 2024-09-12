Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1736EED63A
	for <linux-um@archiver.kernel.org>; Thu, 12 Sep 2024 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X405vKpajqLpEgidAx2nmx+uo0oSPArWretG9DItQ0g=; b=C/++C6P51ppKDA18ZZM1TsiY7V
	XH10YDV/tNv5W1GKfJQMGgM5aW8yDZ0NStb+lOv7p8ntdyavuwxiAJRg+Zr7gxYB5ZahF8opYZujd
	gielgP5G9OXS8aMPZgC67lUMLS7fvAbe+W4mmKzPpFWYF0aCYG7N2ZTnlRPrcpId8DmvJEEvS9ZqO
	4pbbdADXdsPEzfzcacR38tmOCCiQpb0WFa8Wyo5Koz8ibXuFTLHtLrnvAkNJqwn4aDM8gD8HI/5Vh
	EQXdfM1nr5mLwIdTAEKXhyfoY4fbsfU3LJ4JxFjWKSN5xQUSRWcKRRaMmP40G61e5z6gT7tn74Vyz
	YTe9r1GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soovp-0000000DyYQ-14sH;
	Thu, 12 Sep 2024 18:52:41 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soour-0000000DyPe-0g7b
	for linux-um@lists.infradead.org;
	Thu, 12 Sep 2024 18:52:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C951363CF3DA;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fdg0EdIOomSn; Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 272D263CF3E9;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oxJZREg1ixr5; Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0C51863CF3DA;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Date: Thu, 12 Sep 2024 20:51:38 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
In-Reply-To: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
References: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
Subject: Re: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix the return value of elf_core_copy_task_fpregs
Thread-Index: VafjHGNkbF6XAN0sHcypTXWfv3/Q1g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_115141_364153_41B477D8 
X-CRM114-Status: GOOD (  10.31  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Tiwei Bie" <tiwei.btw@antgroup.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kern=
el@vger.kernel.org>, "Tiwei Bie"
> <tiwei.btw@antgroup.com>
> Gesendet: Mittwoch, 28. August 2024 15:51:40
> Betreff: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs

> This function is expected to return a boolean value, which should be
> true on success and false on failure.
>=20
> Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> arch/um/kernel/process.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index be2856af6d4c..3cc2b663aa78 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
> int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
> {
> =09int cpu =3D current_thread_info()->cpu;
> +=09int pid =3D userspace_pid[cpu];
>=20
> -=09return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu)=
;
> +=09return save_i387_registers(pid, (unsigned long *) fpu) =3D=3D 0;

Why a new local variable?

Thanks,
//richard

