Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8BAD2E01F
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uoUuKKwQFnvmTc9BvkqayTIJDXoy6SIlieEXZbE7Ooc=; b=yxhkAtTzWPrho9VfgEWR4T5NaC
	36BoGCFSzGssRYjz+qeEbxL1vCHe7SdAlVPtcOMRvcICeTRuza7CFNeESY8BSbhl/aplotM/ML41H
	D9WWHvQp4K9gHRWH/LARNqpEanQAJZ7bTn+4VHi9lU98xhX2yku+WdPgDxVFigO10gnKm63vGUxhn
	Djou7y6qfZQ2OrQ5XsYL3tu51AdKQ+6n39XGOAerhxuq1Z31YXGTIoEpl7h/cFFJf6qs51rcgvf9O
	5g7eGlEA/QdJ44PzME81dLPIcMhQ64kuThKtMGOgO7CzKI4fDqhFmbDlGgOXlFO0nTpcfoCGo+06H
	j063nslA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Vww-0000000DPv4-2zfo;
	Wed, 23 Oct 2024 07:38:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Ves-0000000DMQ3-01UR
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 07:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uoUuKKwQFnvmTc9BvkqayTIJDXoy6SIlieEXZbE7Ooc=;
	t=1729667991; x=1730877591; b=cxGZB7Tfmc/nwEiFMNL+MOraPA6JEp2YE3M/MfZ2lp1s0m4
	gQ2Of4MundoAHA/JhuDQ5kiV5GSVPymsBrOoNlpVH0xpj5KpBjL+J8R4hrW1q72QsCg+A5DWUYACi
	P42FPAJ7fJ1fg7VPNrcDKU8p+kr8801WhDashVKLfVirx6tyyOyTNqh4Xmr9jnP5a/Mz1yE06QuBa
	bfGVbN2vviPmfM47Ug4ExZITRl6yuk2agdKKllpx6DG5tyF0Qd5mchXplGq2BpV+1QxeBam2qDGNn
	zuM2Vx+zGCBaDDIchulzLe003SzZnQJ32/MmyDzytfEMc266uOC6mv5TvvHQ1sLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3Vek-00000002WxT-2f3b;
	Wed, 23 Oct 2024 09:19:46 +0200
Message-ID: <2da6e20fb9aa82f6cc4c0cac6db9a198a4d12d39.camel@sipsolutions.net>
Subject: Re: [PATCH] um: restore process name
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Wed, 23 Oct 2024 09:19:44 +0200
In-Reply-To: <20241010161411.c576e2aeb3e5.I244d4f34b8a8555ee5bec0e1cf5027bce4cc491b@changeid>
References: <20241010161411.c576e2aeb3e5.I244d4f34b8a8555ee5bec0e1cf5027bce4cc491b@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_001954_125317_1752ED89 
X-CRM114-Status: GOOD (  15.72  )
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

I just noticed that this is not completely correct. readlink() does not
append a NULL byte, so you'll probably want to make the buffer one byte
longer and either initialize it or set buf[ret] =3D '\0' (after the
truncation check).

Benjamin

On Thu, 2024-10-10 at 16:14 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> After the execve() to disable ASLR, comm is now "exe",
> which is a bit confusing. Use readlink() to get this
> to the right name again.
>=20
> Disable stack frame size warnings on main.o since it's
> part of the initial userspace and can use larger stack.
>=20
> Fixes: 68b9883cc16e ("um: Discover host_task_size from envp")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> =C2=A0arch/um/os-Linux/Makefile |=C2=A0 2 ++
> =C2=A0arch/um/os-Linux/main.c=C2=A0=C2=A0 | 14 ++++++++++++--
> =C2=A02 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
> index 544e0b344c75..049dfa5bc9c6 100644
> --- a/arch/um/os-Linux/Makefile
> +++ b/arch/um/os-Linux/Makefile
> @@ -12,6 +12,8 @@ obj-y =3D execvp.o file.o helper.o irq.o main.o mem.o
> process.o \
> =C2=A0
> =C2=A0CFLAGS_signal.o +=3D -Wframe-larger-than=3D4096
> =C2=A0
> +CFLAGS_main.o +=3D -Wno-frame-larger-than
> +
> =C2=A0obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) +=3D elf_aux.o
> =C2=A0
> =C2=A0USER_OBJS :=3D $(user-objs-y) elf_aux.o execvp.o file.o helper.o ir=
q.o
> \
> diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
> index 8a52c49c5361..31dba0912a19 100644
> --- a/arch/um/os-Linux/main.c
> +++ b/arch/um/os-Linux/main.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <errno.h>
> =C2=A0#include <signal.h>
> =C2=A0#include <string.h>
> +#include <limits.h>
> =C2=A0#include <sys/resource.h>
> =C2=A0#include <sys/personality.h>
> =C2=A0#include <as-layout.h>
> @@ -112,8 +113,17 @@ int __init main(int argc, char **argv, char
> **envp)
> =C2=A0	/* Disable randomization and re-exec if it was changed
> successfully */
> =C2=A0	ret =3D personality(PER_LINUX | ADDR_NO_RANDOMIZE);
> =C2=A0	if (ret >=3D 0 && (ret & (PER_LINUX | ADDR_NO_RANDOMIZE)) !=3D
> -			 (PER_LINUX | ADDR_NO_RANDOMIZE))
> -		execve("/proc/self/exe", argv, envp);
> +			 (PER_LINUX | ADDR_NO_RANDOMIZE)) {
> +		char buf[PATH_MAX];
> +		ssize_t ret;
> +
> +		ret =3D readlink("/proc/self/exe", buf, sizeof(buf));
> +		if (ret < 0 || ret >=3D sizeof(buf)) {
> +			perror("readlink failure");
> +			exit(1);
> +		}
> +		execve(buf, argv, envp);
> +	}
> =C2=A0
> =C2=A0	set_stklim();
> =C2=A0


