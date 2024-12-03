Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D4EE74AC3
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMI16u+tU14HoVQ/SGuLiyAUi10LvhcTuo6SvnI5dA4=; b=p5NYy6j5OycyDrGyuAkqnQ4AkI
	qXKrI76x/MnTCiq09hZcbPIQzkXi4jIIJLJGGrTKfYo/+aDXbgUni9Mud5kFjXMQW8UyrmsKKsg10
	8lA6smzinkhBN2rtXzVu0z2eN0dew9d6R08D/GXPSN7lHnXNK0xstz862d+UrSIcEw7kSjNVrwdnk
	cItI+nwgAzb4EYzw+1qg0IChW8HBeG/DWZufFPGYeOSg02xQCfVWYe/L+7xdboC01wR+SJdttAZFj
	uLyBZAsUhGxILC1//J0Q8lWQF8kkwETHp2H1pA/lzr+ZfkOBRao8PPv+z+qFUQ/w+fusWfi9+GhXj
	kaWZ9ODw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIWNE-0000000ACx2-2dzU;
	Tue, 03 Dec 2024 17:07:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIWNC-0000000ACw8-2LfL
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 17:07:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DMI16u+tU14HoVQ/SGuLiyAUi10LvhcTuo6SvnI5dA4=;
	t=1733245661; x=1734455261; b=eSIdL4tY4+CIWhVuz9zto1vOaYhPGbH/XcHt0UAaAaYxm6k
	fklRXnhTlqiDNUTrYJzAv8DWeQMxLW3GALuLROR61kMe+lBdjQGhuhuChvAgT0KcUbpaZCVp/mLE0
	18HJcAuJLg3EZ3DWRo6ka3M43Pd4Lr19rFDo0a6qUCH2nnrsYpdkk24hhVWeqYbIFaoEGiolP2HJw
	qSYxuOer/dOSFgq3burUVyysWkL8CAACZLpUincFgURFV21L6PvtSYESIT7aPbSavp3WtocAO+70g
	VZM7dG5kYxgJEX61CtUVSlOAr1EufnzpSSk5KgBDHMxwlsNN3NEDWxCCZsRAS+dw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tIWN8-000000038mD-2pkP;
	Tue, 03 Dec 2024 18:07:38 +0100
Message-ID: <57281ae15f35f1b7ec5b898d12de44c96827cb27.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
From: Benjamin Berg <benjamin@sipsolutions.net>
To: SeongJae Park <sj@kernel.org>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net
Date: Tue, 03 Dec 2024 18:07:36 +0100
In-Reply-To: <20241203155618.1510-1-sj@kernel.org>
References: <20241203155618.1510-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_090742_663901_D509C0CF 
X-CRM114-Status: GOOD (  24.59  )
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

On Tue, 2024-12-03 at 07:56 -0800, SeongJae Park wrote:
> On Tue, 03 Dec 2024 07:01:09 SeongJae Park <sj@kernel.org> wrote:
>=20
> > On Tue, 03 Dec 2024 09:40:34 +0100 Benjamin Berg
> > <benjamin@sipsolutions.net> wrote:
> >=20
> > > Hi,
> > >=20
> > > that probably means the size detection for the FPU state (i.e.
> > > PTRACE_GETREGSET for NT_X86_XSTATE is incorrect on a 32bit host
> > > in some
> > > way.
> > >=20
> > > Is there anything special about the qemu setup or it is just a
> > > default
> > > qemu-x86?
> >=20
> > I use default qemu-system-x86_64 on my system.
> >=20
> > =C2=A0=C2=A0=C2=A0 $ qemu-system-x86_64 --version
> > =C2=A0=C2=A0=C2=A0 QEMU emulator version 8.2.2 (qemu-8.2.2-1.1.hs+fb.el=
9)
> > =C2=A0=C2=A0=C2=A0 Copyright (c) 2003-2023 Fabrice Bellard and the QEMU=
 Project
> > developers
> >=20
> > I forgot saying it is not just x86 but x86_64, sorry.
>=20
> Oh, and seems my qemu has some downstream changes.=C2=A0 I will try to re=
produce the
> issue with upstream versions and report the result again.

I doubt that is the reason. The code tries to detect the size of the
NT_X86_XSTATE register set and something breaks.

Thinking about it a bit, the only good explanation is that the qemu CPU
does not have XSTATE support. This would cause the ptrace syscall to
fetch the NT_X86_XSTATE register set to always fail (with -ENODEV).

Honestly, I just had not expected such an issue. Could you try the
below patch to add a fallback?

Regards,
Benjamin

diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/regist=
ers.c
index 76eaeb93928c..eb1cdadc8a61 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -18,6 +18,7 @@
 #include <registers.h>
 #include <sys/mman.h>
=20
+static unsigned long ptrace_regset;
 unsigned long host_fp_size;
=20
 int get_fp_registers(int pid, unsigned long *regs)
@@ -27,7 +28,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len =3D host_fp_size,
 	};
=20
-	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
 		return -errno;
 	return 0;
 }
@@ -39,7 +40,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len =3D host_fp_size,
 	};
=20
-	if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
 		return -errno;
 	return 0;
 }
@@ -58,9 +59,23 @@ int arch_init_registers(int pid)
 		return -ENOMEM;
=20
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
-	ret =3D ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
+	ptrace_regset =3D NT_X86_XSTATE;
+	ret =3D ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	if (ret)
 		ret =3D -errno;
+
+	if (ret =3D=3D -ENODEV) {
+#ifdef CONFIG_X86_32
+		ptrace_regset =3D NT_PRXFPREG;
+#else
+		ptrace_regset =3D NT_PRFPREG;
+#endif
+		iov.iov_len =3D 2 * 1024 * 1024;
+		ret =3D ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
+		if (ret)
+			ret =3D -errno;
+	}
+
 	munmap(iov.iov_base, 2 * 1024 * 1024);
=20
 	host_fp_size =3D iov.iov_len;


