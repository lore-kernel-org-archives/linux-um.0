Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C97C2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZRTL//Jwo395Oz7qCChZ4ttnbS/UsIQQ3iEvPRHEa8=; b=rst2IJnvNC2Qcx49cHzzvD5Vjd
	EM3E2couRcySkfVcBkwmH1eKe7PTmWlkGehXoa6nnev8614kJMZqMF6bauYT2sbRmg3ZAQtFxgpny
	9UnFNQcz1+CidzLgtL8hEYsGjiZVIvk4nqIVqMCNal6v4W4mvsTp3bg16KpCFTj2Y1dZ8V1HR91CP
	wER7zm0o0vIwgt8j69hQPXqpsWdUK82U3OQJ0xbpNoZW9Gy0xufxNeL63Zt+5YNdK+taukORb3zcZ
	Y7WMPJnz7n5RuFn57wZxY72F1S8N5BUDFo3BCpZjZ4EDVwFEzF08SXBbF/RqthSgf/uhB6JfxHEeK
	gbUmJyCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sONW5-00000004luq-00gW;
	Mon, 01 Jul 2024 20:20:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sONW2-00000004luM-3PGY
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 20:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PZRTL//Jwo395Oz7qCChZ4ttnbS/UsIQQ3iEvPRHEa8=;
	t=1719865246; x=1721074846; b=WjI8UldV7/4+f715yukIp3MwuR/AARoooMxs7NF69n5Qjiy
	WJ4OC1/0VCsWzV1rvC+X7Fcx/WUN9mBE1zWOob4yCpjzAjp5NGBiJWW0adm/JcWadkBCRD2t7BNWF
	F4sGBEz3AREOiwXZ86J7KspdOKuFESLLnAQWS2LOGOamxr6kVTFvzroaxqPJTd4pVej80NJSoAu3L
	PrVGgK/l/z1Z/jn3saqg2IT+R5WslMsCwV2dAA1jnVJBTZqr3DOQKMsFKqKG+X0QHFaDB+2rzEjX7
	TZX9/2j/wEZzH80RZpZYl7JjvSP+np8ZMGt9RgvFiHEazeaEf9swuNhTK4WYSjZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sONVy-00000003DlF-1xiv;
	Mon, 01 Jul 2024 22:20:42 +0200
Message-ID: <c900d5ab0131ee3445cc2ed8a08caf671f2f4552.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/7] um: use execveat to create userspace MMs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Mon, 01 Jul 2024 22:20:41 +0200
In-Reply-To: <20240626135350.493110-4-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
	 <20240626135350.493110-4-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_132047_160144_11A40488 
X-CRM114-Status: GOOD (  14.02  )
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

On Wed, 2024-06-26 at 15:53 +0200, Benjamin Berg wrote:
>=20
> +static int __init init_stub_exec_fd(void)
> +{
> +	size_t len =3D 0;
> +	int res;
> +	char tmpfile[] =3D "/tmp/uml-userspace-XXXXXX";


That seems awkward, perhaps it should use make_tempfile() from mem.c?

> +		stub_exec_fd =3D mkostemp(tmpfile, O_CLOEXEC);

mkostemp() also requires _GNU_SOURCE according to the man page? It also
doesn't matter since you reopen the file anyway.

> +		/* Only executable by us */
> +		if (fchmod(stub_exec_fd, 00100) < 0) {
> +			unlink(tmpfile);
> +			panic("Could not make stub binary excutable: %d",
> +			      errno);
> +		}
> +
> +		close(stub_exec_fd);
> +		stub_exec_fd =3D open(tmpfile, O_CLOEXEC);

Hmm. Technically, I think you _have_ to open for reading, writing, or
both; not none? But then I guess you have to make it readable?

Might also want O_NOFOLLOW here?

> diff --git a/arch/x86/um/stub_elf.c b/arch/x86/um/stub_elf.c
> new file mode 100644
> index 000000000000..2bf1a717065d
> --- /dev/null
> +++ b/arch/x86/um/stub_elf.c

Is stub_elf really the right name? In practice it's going to be an ELF
file, but ... who cares? Not sure why it should be called "elf" vs. just
"stub" or "exec_stub" or something like that.

Also, is it really x86-specific?

> +++ b/arch/x86/um/stub_elf_embed.S

surely that isn't x86-specific?

johannes

