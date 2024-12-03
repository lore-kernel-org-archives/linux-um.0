Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D1E6C619
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avA5oVf3JIscD1eNMbzcUFCZl8Jw8/vvSBHecLeXRqw=; b=o1ZJsi1ZSM8sKF6dK6Jzh6y/DB
	ZOqYAqz558PuuujR8v+JL9ln/fZFD01eu25/hzdSw6W8BnzZlJxL96zCmMEt/VtCLDZAmXvrAT0HT
	EvV1xqQjgzxMyagNSAbC/uJSpC4b7NIcqG75dEP1KJOv/7oXWM2s0gtlKkVnc/j5a3fbCRt7VRamD
	j6DBVrGk5lYRRpMK94iVu9imH1392LaCoU4c6IYHL3sqDDbyN41tr+t9oeo96kXEF36AHWhlkHyP7
	H5p9LVNaG1Y5fEG0AVcesvYFX3SxW32mduUzcHqWXMyqfREkRC2vXo0VlfHXJcxb0CK7p1GUzoEtM
	mDOnZiWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOSo-00000008jCf-00Dy;
	Tue, 03 Dec 2024 08:40:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOSl-00000008jBU-28Rw
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 08:40:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=avA5oVf3JIscD1eNMbzcUFCZl8Jw8/vvSBHecLeXRqw=;
	t=1733215253; x=1734424853; b=mlEoyIX4SX2kKN6J4jUimXOnLxySUh5zaU1THiBPBHk53CU
	0s/K59WmMT1Yz9+aLD99stu2eO7CSknnx3BxvYxfbOXuyjv+hEtujv4TQo3P7Q/ESTSTPrmjQTYtJ
	aBGEl6wN3MqjtkRW83Ea/3OONzyVi6pjR8dwtEYEAyMDTRHE5ZyRlIw0i3Y8aILNawiCViql+z7WR
	W8y9GSEXJNMEby/wv2DhSeWVuwcRkTttK83G+irw4KdICs2xJAjbPJyNSM6w/xZvxCr4QNMaFwsm8
	Mr7Mj9q8tdT9xxhXadNGtkjJ2bXYkPdfI/WQN3f5SyZnbWZcw0Hf87w2A12vAYpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tIOST-0000000268p-3CoW;
	Tue, 03 Dec 2024 09:40:38 +0100
Message-ID: <029ad08a1aa2dc512b442c988d0edebdd7aef4b0.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
From: Benjamin Berg <benjamin@sipsolutions.net>
To: SeongJae Park <sj@kernel.org>
Cc: linux-um@lists.infradead.org, johannes@sipsolutions.net
Date: Tue, 03 Dec 2024 09:40:34 +0100
In-Reply-To: <20241203070218.240797-1-sj@kernel.org>
References: <20241203070218.240797-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_004055_561289_DEAD92D3 
X-CRM114-Status: GOOD (  28.03  )
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

that probably means the size detection for the FPU state (i.e.
PTRACE_GETREGSET for NT_X86_XSTATE is incorrect on a 32bit host in some
way.

Is there anything special about the qemu setup or it is just a default
qemu-x86?

Benjamin

On Mon, 2024-12-02 at 23:02 -0800, SeongJae Park wrote:
> Hello,
>=20
>=20
> On Wed, 23 Oct 2024 11:41:20 +0200 Benjamin Berg <benjamin@sipsolutions.n=
et> wrote:
>=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
> > CPU feature should also be sufficiently common to be able to rely on it=
.
> >=20
> > With this, define our internal FP state to be the hosts XSAVE data. Add
> > discovery for the hosts XSAVE size and place the FP registers at the en=
d
> > of task_struct so that we can adjust the size at runtime.
> >=20
> > Next we can implement the regset API on top and update the signal
> > handling as well as ptrace APIs to use them. Also switch coredump
> > creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.
> >=20
> > This considerably improves the signal frames. Previously they might not
> > have contained all the registers (i386) and also did not have the
> > sizes and magic values set to the correct values to permit userspace to
> > decode the frame.
> >=20
> > As a side effect, this will permit UML to run on hosts with newer CPU
> > extensions (such as AMX) that need even more register state.
>=20
> I just found kunit starts failing from the mainline commit of this patch =
on my
> qemu-x86 Debian system, as below.
>=20
> =C2=A0=C2=A0=C2=A0 $ git checkout 3f17fed2149192c7d3b76a45a6a87b4ff22cd58=
6
> =C2=A0=C2=A0=C2=A0 $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/=
damon/tests/ --build_dir ../kunit.out/
> =C2=A0=C2=A0=C2=A0 [...]
> =C2=A0=C2=A0=C2=A0 [22:48:27] Configuring KUnit Kernel ...
> =C2=A0=C2=A0=C2=A0 Regenerating .config ...
> =C2=A0=C2=A0=C2=A0 Populating config with:
> =C2=A0=C2=A0=C2=A0 $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> =C2=A0=C2=A0=C2=A0 [22:48:30] Building KUnit Kernel ...
> =C2=A0=C2=A0=C2=A0 Populating config with:
> =C2=A0=C2=A0=C2=A0 $ make ARCH=3Dum O=3D../kunit.out/ olddefconfig
> =C2=A0=C2=A0=C2=A0 Building with:
> =C2=A0=C2=A0=C2=A0 $ make all compile_commands.json ARCH=3Dum O=3D../kuni=
t.out/ --jobs=3D40
> =C2=A0=C2=A0=C2=A0 [...]
> =C2=A0=C2=A0=C2=A0 [22:48:46] Starting KUnit Kernel (1/1)...
> =C2=A0=C2=A0=C2=A0 [22:48:46] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0=C2=A0 Running tests with:
> =C2=A0=C2=A0=C2=A0 $ ../kunit.out/linux kunit.enable=3D1 mem=3D1G console=
=3Dtty kunit_shutdown=3Dhalt
> =C2=A0=C2=A0=C2=A0 [22:48:46] [ERROR] Test: <missing>: Could not find any=
 KTAP output. Did any KUnit tests run?
> =C2=A0=C2=A0=C2=A0 [22:48:46] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0=C2=A0 [22:48:46] Testing complete. Ran 0 tests: errors: 1
> =C2=A0=C2=A0=C2=A0 [22:48:46] Elapsed time: 19.285s total, 3.805s configu=
ring, 15.475s building, 0.006s running
>=20
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> [...]
> > -void arch_init_registers(int pid)
> > -{
> > -	struct user_fpxregs_struct fpx_regs;
> > -	int err;
> > -
> > -	err =3D ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);
> > -	if (!err)
> > -		return;
> > -
> > -	if (errno !=3D EIO)
> > -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno);
> > -
> > -	have_fpx_regs =3D 0;
> > -}
> > -#else
> > -
> > -int get_fp_registers(int pid, unsigned long *regs)
> > +int arch_init_registers(int pid)
> > =C2=A0{
> > -	return save_fp_registers(pid, regs);
> > +	struct iovec iov =3D {
> > +		/* Just use plenty of space, it does not cost us anything */
> > +		.iov_len =3D 2 * 1024 * 1024,
> > +	};
> > +	int ret;
> > +
> > +	iov.iov_base =3D mmap(NULL, iov.iov_len, PROT_WRITE | PROT_READ,
> > +			=C2=A0=C2=A0=C2=A0 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +	if (iov.iov_base =3D=3D MAP_FAILED)
> > +		return -ENOMEM;
> > +
> > +	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
> > +	ret =3D ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
> > +	if (ret)
> > +		ret =3D -errno;
> > +	munmap(iov.iov_base, 2 * 1024 * 1024);
> > +
> > +	host_fp_size =3D iov.iov_len;
> > +
> > +	return ret;
> > =C2=A0}
>=20
> And seems it fails from the registers initialization step:
>=20
> =C2=A0=C2=A0=C2=A0 $ ../kunit.out/linux
> =C2=A0=C2=A0=C2=A0 Core dump limits :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soft -=
 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hard -=
 NONE
> =C2=A0=C2=A0=C2=A0 Checking that ptrace can change system call numbers...=
OK
> =C2=A0=C2=A0=C2=A0 Checking syscall emulation for ptrace...OK
> =C2=A0=C2=A0=C2=A0 Checking environment variables for a tempdir...none fo=
und
> =C2=A0=C2=A0=C2=A0 Checking if /dev/shm is on tmpfs...OK
> =C2=A0=C2=A0=C2=A0 Checking PROT_EXEC mmap in /dev/shm...OK
> =C2=A0=C2=A0=C2=A0 Failed to initialize default registers
>=20
> I'm not familiar with uml code, so reporting this issue first.=C2=A0 Any =
thought, please?
>=20
>=20
> Thanks,
> SJ
>=20
> [...]
>=20


