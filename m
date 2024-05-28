Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE56C25B78
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MM8XJq3ufReL7Zs+uEB0JGE4PBDvmq0xAykbMZU5lf0=; b=JgDvatX/BQBqKZPloN8u6JI4ge
	5CzNaDkWVyntKGyOEMCvmf3mnOdNUSR0i2fYxjP+T8f2abmW+g7/75sUPvHdgLmasind8kcfJ91g9
	ZKUY/TSbXd/d0MoixJHAhmtfNSnyROkpPttHShEG9l/z+cv2MjdYa4qL3EytBgWc5sWEVt4BLlT9p
	Tngi78GFcCz7D/+dSzvITephdFaAes5xX9F9e3SaBXNBNn7KySWP1TYV+ZQ5Q557iI/Fs047UELW2
	NopVK9jbbJzUcMu8dwPiNL/nc4bGHlT+Aa6xv3mdJRs99OW5W3YDLaGseu6msxh/YxcUPDGiaoqYx
	Hd8nJ7Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBu6M-00000000ENS-0neZ;
	Tue, 28 May 2024 10:30:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBu6I-00000000EMq-2ymt
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 10:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MM8XJq3ufReL7Zs+uEB0JGE4PBDvmq0xAykbMZU5lf0=;
	t=1716892237; x=1718101837; b=LR3XeQpnsyDFyU7PF2hwr1dUYPCV7ysFF9lCIX3+ki8qz5n
	r5CaS+6cWkmrB3vD3AJKcylxMZWFw5t+yylhJJL3rqPxO4Yd65o5hQtYn9/wn8Kz/opoVSPb4SZfg
	kqTQPCq8I4G10Egt2UNa6envlfP5TWt6SroX35mn/VMcFL6cDee02JXsHKrcyKFingEHfGesbXHs7
	7PCZc3rgfTbmncTN+01PDSakR1vc0DYRu/V8Ea6FQ7tuFqu7WE9c+MOLbXXlK0eT9dj/9hYyCQwlu
	CQ1mYyijVn9XjKpRDhm+S8B+9GASVd9jXCv0KCx3tdKd7nzIdJIBVvtuHhPalcrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sBu6E-0000000EGQQ-2urV;
	Tue, 28 May 2024 12:30:35 +0200
Message-ID: <388619aff5c8372998992a9f28fd7c71fb36eb51.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org
Date: Tue, 28 May 2024 12:30:31 +0200
In-Reply-To: <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
	 <20240528085419.1964424-4-benjamin@sipsolutions.net>
	 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_033038_781889_9C545E93 
X-CRM114-Status: GOOD (  30.64  )
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

Hi Tiwei,

On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
> On 5/28/24 4:54 PM, benjamin@sipsolutions.net=C2=A0wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > Newer glibc versions are enabling rseq support by default. This remains
> > enabled in the cloned child process, potentially causing the host kerne=
l
> > to write/read memory in the child.
> >=20
> > It appears that this was purely not an issue because the used memory
> > area happened to be above TASK_SIZE and remains mapped.
>=20
> I also encountered this issue. In my case, with "Force a static link"
> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
> it starts up. I worked around this by setting the glibc.pthread.rseq
> tunable via GLIBC_TUNABLES [1] before launching UML.
>=20
> So another easy way to work around this issue without introducing runtime
> overhead might be to add the GLIBC_TUNABLES=3Dglibc.pthread.rseq=3D0 envi=
ronment
> variable and exec /proc/self/exe in UML on startup.

I am not really worried about the overhead, but I agree that setting
GLIBC_TUNABLES is also a reasonable solution to the problem.

Doing the memfd/execveat dance with an embedded static binary would
still be best in my view, but either this or GLIBC_TUNABLES seem fine
in the meantime.

Do you want to submit the patch? Should I re-roll the patchset with
GLIBC_TUNABLES?

Benjamin

> [1] https://www.gnu.org/software/libc/manual/html_node/Tunables.html
>=20
> Regards,
> Tiwei
>=20
> >=20
> > Note that a better approach would be to exec a small static binary that
> > does not link with other libraries. Using a memfd and execveat the
> > binary could be embedded into UML itself and it would result in an
> > entirely clean execution environment for userspace.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > ---
> > =C2=A0arch/um/os-Linux/skas/process.c | 54 ++++++++++++++++++++++++++++=
++---
> > =C2=A01 file changed, 50 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/pr=
ocess.c
> > index 41a288dcfc34..ee332a2aeea6 100644
> > --- a/arch/um/os-Linux/skas/process.c
> > +++ b/arch/um/os-Linux/skas/process.c
> > @@ -255,6 +255,31 @@ static int userspace_tramp(void *stack)
> > =C2=A0int userspace_pid[NR_CPUS];
> > =C2=A0int kill_userspace_mm[NR_CPUS];
> > =C2=A0
> > +struct tramp_data {
> > +	int pid;
> > +	void *clone_sp;
> > +	void *stack;
> > +};
> > +
> > +static int userspace_tramp_clone_vm(void *data)
> > +{
> > +	struct tramp_data *tramp_data =3D data;
> > +
> > +	/*
> > +	 * This helper exist to do a double-clone. First with CLONE_VM which
> > +	 * effectively disables things like rseq, and then the second one to
> > +	 * get a new memory space.
> > +	 */
> > +
> > +	tramp_data->pid =3D clone(userspace_tramp, tramp_data->clone_sp,
> > +				CLONE_PARENT | CLONE_FILES | SIGCHLD,
> > +				tramp_data->stack);
> > +	if (tramp_data->pid < 0)
> > +		tramp_data->pid =3D -errno;
> > +
> > +	exit(0);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * start_userspace() - prepare a new userspace process
> > =C2=A0 * @stub_stack:	pointer to the stub stack.
> > @@ -268,9 +293,10 @@ int kill_userspace_mm[NR_CPUS];
> > =C2=A0 */
> > =C2=A0int start_userspace(unsigned long stub_stack)
> > =C2=A0{
> > +	struct tramp_data tramp_data;
> > =C2=A0	void *stack;
> > =C2=A0	unsigned long sp;
> > -	int pid, status, n, flags, err;
> > +	int pid, status, n, err;
> > =C2=A0
> > =C2=A0	/* setup a temporary stack page */
> > =C2=A0	stack =3D mmap(NULL, UM_KERN_PAGE_SIZE,
> > @@ -286,10 +312,13 @@ int start_userspace(unsigned long stub_stack)
> > =C2=A0	/* set stack pointer to the end of the stack page, so it can gro=
w downwards */
> > =C2=A0	sp =3D (unsigned long)stack + UM_KERN_PAGE_SIZE;
> > =C2=A0
> > -	flags =3D CLONE_FILES | SIGCHLD;
> > +	tramp_data.stack =3D (void *) stub_stack;
> > +	tramp_data.clone_sp =3D (void *) sp;
> > +	tramp_data.pid =3D -EINVAL;
> > =C2=A0
> > =C2=A0	/* clone into new userspace process */
> > -	pid =3D clone(userspace_tramp, (void *) sp, flags, (void *) stub_stac=
k);
> > +	pid =3D clone(userspace_tramp_clone_vm, (void *) sp,
> > +		=C2=A0=C2=A0=C2=A0 CLONE_VM | CLONE_FILES | SIGCHLD, &tramp_data);
> > =C2=A0	if (pid < 0) {
> > =C2=A0		err =3D -errno;
> > =C2=A0		printk(UM_KERN_ERR "%s : clone failed, errno =3D %d\n",
> > @@ -305,7 +334,24 @@ int start_userspace(unsigned long stub_stack)
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, errno);
> > =C2=A0			goto out_kill;
> > =C2=A0		}
> > -	} while (WIFSTOPPED(status) && (WSTOPSIG(status) =3D=3D SIGALRM));
> > +	} while (!WIFEXITED(status));
> > +
> > +	pid =3D tramp_data.pid;
> > +	if (pid < 0) {
> > +		printk(UM_KERN_ERR "%s : second clone failed, errno =3D %d\n",
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, -pid);
> > +		return pid;
> > +	}
> > +
> > +	do {
> > +		CATCH_EINTR(n =3D waitpid(pid, &status, WUNTRACED | __WALL));
> > +		if (n < 0) {
> > +			err =3D -errno;
> > +			printk(UM_KERN_ERR "%s : wait failed, errno =3D %d\n",
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, errno);
> > +			goto out_kill;
> > +		}
> > +	} while (WIFEXITED(status) && (WSTOPSIG(status) =3D=3D SIGALRM));
> > =C2=A0
> > =C2=A0	if (!WIFSTOPPED(status) || (WSTOPSIG(status) !=3D SIGSTOP)) {
> > =C2=A0		err =3D -EINVAL;
>=20
>=20


