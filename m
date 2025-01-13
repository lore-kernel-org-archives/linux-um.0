Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56121E7719F
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 07:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofeEM4eNkaqQZvFq/DeQyUyzpit7C8vAjv1E4obK3RA=; b=TOpQfvfVdr6EL0XN2pDw2gRcYU
	Hk8ccs0t53H2yihiZSpfEX/0kYw25tJmRpKqWvXvbCv0o4vEj0WHpuV+QErH4/uY4z7E1rxzBTZ41
	4qNDpaVhPhxqKK60lF+I/gE9rWC4iSS8bJ7IpojJpjqydibLwD9vE+qls2XMHR1QtGy3huP77+G1H
	6m9czNdo4SS62YCRt7vZRMCmxQYVEaMyrqrlssGWRdrT2vGHipzaUMU9rFAdmGm/BrCx9PXqgkGfH
	wi2FniddaQ+I8RYi34I5l7utIkPM4ITHrlIjHu418hmdkz5ageq4J5pSXs1BCgkXLG0C3dz3xonSU
	EEq/iHIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEYb-00000004CGI-2rhV;
	Mon, 13 Jan 2025 07:08:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEYZ-00000004CDU-2Icv
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 07:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ofeEM4eNkaqQZvFq/DeQyUyzpit7C8vAjv1E4obK3RA=;
	t=1736752093; x=1737961693; b=c1q99+WF0r7+25l2DDSlSPYqZAXOCW7j6xlLK53TERTQ43N
	eTwK9JpzPiwP7aPJitZliJIRs1iWb9PPRxO15CG5iaYV/D5HrPoFh+guryEbwnb6e6vfU8eogwa4C
	uqrz3ZgV4iDkV5xsYTp36F/DEXIa/dC99OI8+P36iajOW/akO6M9UM0jbmMPaHyxA81jA48K4g7wu
	QF10wErQhebSrPZhX3hBHWsy+tJLVrchUaBdLO9vR1uAq+wqAZmImaYE2OYBz7t7rofLsxjnp//n3
	hqS5oLLeEsVC9S4ENt57HffGwyKpF7DLW9+5HM91UVLAfuJJKlbx9iD8hZ9pIZrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tXEYT-0000000DOQq-1QgZ;
	Mon, 13 Jan 2025 08:08:09 +0100
Message-ID: <9e550a96e9522b282c81bccecbf4af1cd2dbd7b7.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
From: Benjamin Berg <benjamin@sipsolutions.net>
To: development@efficientek.com
Cc: linux-um@lists.infradead.org
Date: Mon, 13 Jan 2025 08:08:07 +0100
In-Reply-To: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
References: <20250110161305.558223-1-benjamin@sipsolutions.net>
	 <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_230815_593479_8FD221FB 
X-CRM114-Status: GOOD (  35.53  )
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

On Sun, 2025-01-12 at 14:07 -0600, Glenn Washburn wrote:
> On Fri, 10 Jan 2025 17:13:05 +0100
> Benjamin Berg <benjamin@sipsolutions.net> wrote:
>=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > The stub execution uses the somewhat new close_range and execveat
> > syscalls. Of these two, the execveat call is essential, but the
> > close_range call is more about stub process hygiene rather than safety
> > (and its result is ignored).
> >=20
> > Replace both calls with a raw syscall as older machines might not have =
a
> > recent enough kernel for close_range (with CLOSE_RANGE_CLOEXEC) or a
> > libc that does not yet expose both of the syscalls.
> >=20
> > Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
>=20
> This change fixes the immediate issue, allowing the compile to complete
> successfully.
>=20
> > Reported-by: Glenn Washburn <development@efficientek.com>
> > Closes: https://lore.kernel.org/20250108022404.05e0de1e@crass-HP-ZBook-=
15-G2
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > ---
> > =C2=A0arch/um/os-Linux/skas/process.c | 16 +++++++++++++---
> > =C2=A01 file changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/pr=
ocess.c
> > index f683cfc9e51a..64e89921bc7f 100644
> > --- a/arch/um/os-Linux/skas/process.c
> > +++ b/arch/um/os-Linux/skas/process.c
> > @@ -181,6 +181,10 @@ extern char __syscall_stub_start[];
> > =C2=A0
> > =C2=A0static int stub_exe_fd;
> > =C2=A0
> > +#ifndef CLOSE_RANGE_CLOEXEC
> > +#define CLOSE_RANGE_CLOEXEC	(1U << 2)
> > +#endif
> > +
> > =C2=A0static int userspace_tramp(void *stack)
> > =C2=A0{
> > =C2=A0	char *const argv[] =3D { "uml-userspace", NULL };
> > @@ -202,8 +206,12 @@ static int userspace_tramp(void *stack)
> > =C2=A0	init_data.stub_data_fd =3D phys_mapping(uml_to_phys(stack), &off=
set);
> > =C2=A0	init_data.stub_data_offset =3D MMAP_OFFSET(offset);
> > =C2=A0
> > -	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
> > -	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
> > +	/*
> > +	 * Avoid leaking unneeded FDs to the stub by setting CLOEXEC on all F=
Ds
> > +	 * and then unsetting it on all memory related FDs.
> > +	 * This is not strictly necessary from a safety perspective.
> > +	 */
> > +	syscall(__NR_close_range, 1, ~0U, CLOSE_RANGE_CLOEXEC);
>=20
> Was this intentional to change the fd parameter from 0 to 1?

Ah, no, that was an accident. It is fine (zero FD is replaced anyway
later), but it should be zero.
=C2=A0
> > =C2=A0	fcntl(init_data.stub_data_fd, F_SETFD, 0);
> > =C2=A0	for (iomem =3D iomem_regions; iomem; iomem =3D iomem->next)
> > @@ -224,7 +232,9 @@ static int userspace_tramp(void *stack)
> > =C2=A0	if (ret !=3D sizeof(init_data))
> > =C2=A0		exit(4);
> > =C2=A0
> > -	execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
> > +	/* Raw execveat for compatibility with older libc versions */
> > +	syscall(__NR_execveat, stub_exe_fd, (unsigned long)"",
> > +		(unsigned long)argv, NULL, AT_EMPTY_PATH);
>=20
> I think it would look nicer to leave the call unchanged and define a stub
> function like libc does, but only if we detect that the stubs are
> undefined. I have a glibc specific patch for this, and then realized
> that it should be more generic to cover other libcs. So this patch here
> is more general. I think to have what I'd like, I'd need to add and run
> a test binaries that check for these functions, like autotools does.
> I'm not aware that this is really done in the kernel build system,
> though I do know that there are binaries built during build for
> generating binaries to be included in the kernel. So in theory I don't
> think it should be too much trouble to do. Basically the idea would be
> to have a system for testing host libc and outputting a config.h which
> will define for instance, HAVE_EXECVEAT, if support is detected in the
> linked libc for execveat. And in process.c define a stub around the
> syscall() for execveat if not defined HAVE_EXECVEAT.
>=20
> So perhaps for now, this is the best solution, but ultimately it would
> be nice to have the above and ultimately reverse these changes.

Exactly, I am not aware of any configure infrastructure that would make
it easy to do a test compile for discovery. I doubt it makes sense to
add such an infrastructure just for this.

Benjamin

