Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F052FC30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hfFJ6uHlHI9twnvJ8QmC8OT9omTB0pybnptUsDTNR/g=; b=HwAR/cZ2A2bMBTGEl0SUMPktMT
	v7Sn0lrWa2eFJFBlURUZaFpSd3zm1Qv+DMWRcufTYoWg0/sm2Jvnr69hVl5GaxqXbEhZ+MKI6Tfan
	rkEMAmU9Ok3ZJeEIwuv2jtJdmlU1NYYPoGo8BSEHoEKCLL4l6lAjs6SRN4JxWJmvNBPIkSxQ/W/Gn
	CLqU5nqT8h/Zlj1n0TY6ebdhCbmbNmGoKRgi39euv4K36ta3/z4JtzxsmIZnGyv//dbxlIRtgAsVN
	YVjwm566//2CeuezjxiG5Gw8X6oofeoWDjs8GkK/M2psEuhZKPSvtZeebdF2PPXaxY7TL+W0oyfaB
	gUtEa9dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPQQt-0000000E3Ix-1mc3;
	Thu, 04 Jul 2024 17:39:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPQQp-0000000E3IZ-36aj
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 17:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hfFJ6uHlHI9twnvJ8QmC8OT9omTB0pybnptUsDTNR/g=;
	t=1720114783; x=1721324383; b=iq2VCXaJOYkQ+5L6vtJY7/f4DHr6qiGy5F4ckF4BGCTFAqu
	BFGwOT8ssyodlF9OI0IK1qbGnNexUFdPHoRewb8qrw3Wahfq9VoYQ2b8BQln0MFk5SqawBnKkL8LW
	JffzcafqnsXxg3EiYNHLFI2IryjhYZMdK0RPCmsSPZ0gIE9UMDpA7ATNSOHisK5sks0xqBl6RI5Nn
	0iUFf9vFYTh1qMdmRgWfjkW8boFFWdS9b3oUtgUSCCxPvDfpyFdwxvWpwmToEKbzlxMz9y9Y3x9Py
	pEEuXyP1BL5NfV7dbBJenmyLve/UaxCV/ZlstSdgNEnQ0SBJEdJfyNkGhxoVVlfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPQQk-0000000DeY4-40Qk;
	Thu, 04 Jul 2024 19:39:39 +0200
Message-ID: <e52cb9417a092efe009d86fa43e53b77dbe9a72c.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/7] um: use execveat to create userspace MMs
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Thu, 04 Jul 2024 19:39:37 +0200
In-Reply-To: <08f0a23907e7c0736ee97d3e2d58fc605e7ca689.camel@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
	 <20240704162717.1417338-3-benjamin@sipsolutions.net>
	 <08f0a23907e7c0736ee97d3e2d58fc605e7ca689.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_103944_005546_95C51E79 
X-CRM114-Status: GOOD (  20.15  )
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

On Thu, 2024-07-04 at 18:49 +0200, Johannes Berg wrote:
> On Thu, 2024-07-04 at 18:27 +0200, Benjamin Berg wrote:
> >=20
> > +	/* set a nice name */
> > +	stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace"=
);
>=20
> Is that even needed when you're passing it as argv[0] in execve()? But
> whatever, it's fine, just wondering.

It is needed. I added it because the argv[0] was not being used and I
ended up with a number as the process name.

Benjamin

> > +	/* setup signal stack inside stub data */
> > +	stack.ss_flags =3D 0;
> > +	stack.ss_size =3D STUB_DATA_PAGES * UM_KERN_PAGE_SIZE;
> > +	stack.ss_sp =3D (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
> > +	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
> > +
> > +	/* register SIGSEGV handler (SA_RESTORER, the handler never returns) =
*/
> > +	sa.sa_flags =3D SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000;
> > +	sa.sa_handler_ =3D (void *) init_data.segv_handler;
> > +	sa.sa_restorer =3D NULL;
> > +	sa.sa_mask =3D 0L; /* No need to mask anything */
>=20
> most of that init could be in the initializer, except the dynamic ones
> of course; the NULL/0 is also unnecessary I guess (though might want the
> sa_mask for the comment)
>=20
> > +	struct stub_init_data init_data =3D {
> > +		.stub_start =3D STUB_START,
> > +		.segv_handler =3D STUB_CODE +
> > +				(unsigned long) stub_segv_handler -
> > +				(unsigned long) __syscall_stub_start,
> > +	};
> > +	struct iomem_region *iomem;
> > +	int ret;
> > +
> > +	init_data.stub_code_fd =3D phys_mapping(uml_to_phys(__syscall_stub_st=
art),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &offset);
> > +	init_data.stub_code_offset =3D MMAP_OFFSET(offset);
> > +
> > +	init_data.stub_data_fd =3D phys_mapping(uml_to_phys(stack), &offset);
> > +	init_data.stub_data_offset =3D MMAP_OFFSET(offset);
>=20
> also could move more here into the initializer
>=20
> > +static int __init init_stub_exe_fd(void)
> > +{
> > +	size_t len =3D 0;
>=20
> maybe that should be called 'written'?
>=20
> > +	int res;
>=20
> and I technically that should be ssize_t for the write() return value,
> not that it'll be big enough to matter
>=20
> > +	while (len < stub_exe_end - stub_exe_start) {
> > +		res =3D write(stub_exe_fd, stub_exe_start + len,
> > +			=C2=A0=C2=A0=C2=A0 stub_exe_end - stub_exe_start - len);
> > +		if (res < 0) {
> > +			if (errno =3D=3D EINTR)
> > +				continue;
> > +
> > +			if (tmpfile)
> > +				unlink(tmpfile);
> > +			panic("%s: Failed write to memfd: %d", __func__, errno);
>=20
> nit: not always memfd now
>=20
> > +	if (!tmpfile) {
> > +		fcntl(stub_exe_fd, F_ADD_SEALS,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL=
_GROW | F_SEAL_SEAL);
> > +	} else {
> > +		/* Only executable by us */
> > +		if (fchmod(stub_exe_fd, 00500) < 0) {
>=20
> now it's also readable, so comment doesn't seem right? maybe just remove
> it?
>=20
> > +			unlink(tmpfile);
> > +			panic("Could not make stub binary excutable: %d",
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno);
>=20
> perhaps print -errno?
>=20
> > +		}
> > +
> > +		close(stub_exe_fd);
> > +		stub_exe_fd =3D open(tmpfile, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
> > +		if (stub_exe_fd < 0) {
> > +			unlink(tmpfile);
> > +			panic("Could not reopen stub binary: %d", errno);
>=20
> same here
>=20
> johannes
>=20


