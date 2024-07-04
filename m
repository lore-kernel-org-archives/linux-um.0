Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70504C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/qOrULn6cGU+Hq2OOcS1LyUPYeEe/zjds8QUW7R5tiQ=; b=qkOg8C7sU2rkI0i5pbtGSFM8j9
	IZBHJzCeO5DBa+mImZUascBmpdFXmRctIacQlplEM5+7sDvo7CaBhtcbVknjMPQ1r8Z31l6RA2CJq
	UohIK+6k+FS9Krzfw5a33XX9B6y0xiH07yHY1AfPDHZOJHQt9ZakOTdza2OkTR6XkXaR2EXufcpEw
	5etEkRApBSgJU5NOM07e0lfeqQTfRMJw7zeNyp39tVW1KlKOz4uHdbCopHc6FaZeXcmb2n/LA4BZo
	1i6p3IAbmJepERGMfhUc4PsJy3sGr9/YvFMjecKHaY61HtE/p/hutEUiiW23E8WI1d1HVMfyXllWM
	lhMuEErQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPeL-0000000DtKd-3kBs;
	Thu, 04 Jul 2024 16:49:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPeI-0000000DtJ9-2sPc
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:49:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/qOrULn6cGU+Hq2OOcS1LyUPYeEe/zjds8QUW7R5tiQ=;
	t=1720111774; x=1721321374; b=sH+dyKRfNuAL2lCkhw+NuObaTJOad1NCaQQDGjyfYAFPSDP
	R5ase45nKJgdKu7IgR8qHoG8O2IrJVoyO2tGfM+liGvKw6l3YsFL+yO6SWZdxIl60AgUlTFnVIr9n
	AlWJ/5woL0adMACA1EHp9xCSCcB3XEx5W7OJbOtIQdZvTOZukbfOj+SksXg2716V8EPrMGVUKZN9L
	LFKTCaisWOMpYu04QNNjffswkcTRp9sVCshSqQcn6vyq0gI5auDNfk0YiXzquzFxX3yn+WLNjTf3A
	KmNa0iSfOi4+sScBVBgvgTCgqHgjy4fQyAp3RtZkz/9Eh1flX/RCqO4thxY5V2qg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPPeE-0000000DTnz-27Lu;
	Thu, 04 Jul 2024 18:49:30 +0200
Message-ID: <08f0a23907e7c0736ee97d3e2d58fc605e7ca689.camel@sipsolutions.net>
Subject: Re: [PATCH v7 2/7] um: use execveat to create userspace MMs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 04 Jul 2024 18:49:29 +0200
In-Reply-To: <20240704162717.1417338-3-benjamin@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
	 <20240704162717.1417338-3-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_094934_749155_81523FC0 
X-CRM114-Status: GOOD (  17.20  )
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

On Thu, 2024-07-04 at 18:27 +0200, Benjamin Berg wrote:
>=20
> +	/* set a nice name */
> +	stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");

Is that even needed when you're passing it as argv[0] in execve()? But
whatever, it's fine, just wondering.

> +	/* setup signal stack inside stub data */
> +	stack.ss_flags =3D 0;
> +	stack.ss_size =3D STUB_DATA_PAGES * UM_KERN_PAGE_SIZE;
> +	stack.ss_sp =3D (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
> +	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
> +
> +	/* register SIGSEGV handler (SA_RESTORER, the handler never returns) */
> +	sa.sa_flags =3D SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000;
> +	sa.sa_handler_ =3D (void *) init_data.segv_handler;
> +	sa.sa_restorer =3D NULL;
> +	sa.sa_mask =3D 0L; /* No need to mask anything */

most of that init could be in the initializer, except the dynamic ones
of course; the NULL/0 is also unnecessary I guess (though might want the
sa_mask for the comment)

> +	struct stub_init_data init_data =3D {
> +		.stub_start =3D STUB_START,
> +		.segv_handler =3D STUB_CODE +
> +				(unsigned long) stub_segv_handler -
> +				(unsigned long) __syscall_stub_start,
> +	};
> +	struct iomem_region *iomem;
> +	int ret;
> +
> +	init_data.stub_code_fd =3D phys_mapping(uml_to_phys(__syscall_stub_star=
t),
> +					      &offset);
> +	init_data.stub_code_offset =3D MMAP_OFFSET(offset);
> +
> +	init_data.stub_data_fd =3D phys_mapping(uml_to_phys(stack), &offset);
> +	init_data.stub_data_offset =3D MMAP_OFFSET(offset);

also could move more here into the initializer

> +static int __init init_stub_exe_fd(void)
> +{
> +	size_t len =3D 0;

maybe that should be called 'written'?

> +	int res;

and I technically that should be ssize_t for the write() return value,
not that it'll be big enough to matter

> +	while (len < stub_exe_end - stub_exe_start) {
> +		res =3D write(stub_exe_fd, stub_exe_start + len,
> +			    stub_exe_end - stub_exe_start - len);
> +		if (res < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +
> +			if (tmpfile)
> +				unlink(tmpfile);
> +			panic("%s: Failed write to memfd: %d", __func__, errno);

nit: not always memfd now

> +	if (!tmpfile) {
> +		fcntl(stub_exe_fd, F_ADD_SEALS,
> +		      F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_SEAL);
> +	} else {
> +		/* Only executable by us */
> +		if (fchmod(stub_exe_fd, 00500) < 0) {

now it's also readable, so comment doesn't seem right? maybe just remove
it?

> +			unlink(tmpfile);
> +			panic("Could not make stub binary excutable: %d",
> +			      errno);

perhaps print -errno?

> +		}
> +
> +		close(stub_exe_fd);
> +		stub_exe_fd =3D open(tmpfile, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
> +		if (stub_exe_fd < 0) {
> +			unlink(tmpfile);
> +			panic("Could not reopen stub binary: %d", errno);

same here

johannes

