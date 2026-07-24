Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E068C531C9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4aC+5JJRva2sGlK9ilJsruLTwzkRy334sCagEv1fugA=; b=s1jw26jdTqVpSkNNpMuhp/R8Tx
	s+mv53mRTpgkOybR4PyzMFBWe85SDBV0WXqRFzy7Bb7MLnfLD0N00DJs5vQopimVAG2AUtI7hglZ/
	zQVHENDsqEqP2B8iPadaMmjw7Q3LSCIMjlN0DouCpODrbhwZEXlxU8re46+O7V31MkPgH1SyMN0fP
	zrMu19em9bJWZ4GbXNKhgujTV26SPDVKntlANUziuhthY74fGWtzuOUUQJOYyzqEVYKOtAAxc4tQp
	gtIKQRK/7+qsRKcojA9pXkX4N3VDbjb+/M5aVDAVOa5xBZ5pyPukaqfjL3SRRw/4XURinrsQfE5Tf
	Xfe90PBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9ie-0000000FdXl-1pOB;
	Fri, 24 Jul 2026 06:49:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9ic-0000000FdXQ-23BK
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4aC+5JJRva2sGlK9ilJsruLTwzkRy334sCagEv1fugA=;
	t=1784875754; x=1786085354; b=cuIHmuYYqVNOHkHSyUCr+S3vYS/YAawGwzsh+D6aypfeu0V
	oXUx0xATNked4v3ZEm5V1LbHDKuqMPYv8gqiE730zPZpFStiQXvQpD7wtdfpmO9VtYT0o/HdFBpIw
	Faj4MFPY4oZDgBZvPx6cD9jAqCbiXA/WuvnGXVLmMCuE3SXB8td6ZplIRxIGFdC9CCxnfY0/i4y5X
	1da2Zr5TRVZ/SWbjEXHzh5O92ziTAnXo1JTf6P8qsUNHquUyanmfM5Ccd4vZbp/REx+rM4SA4jxNC
	Jub4GBPCUn/9w21hKKZFnZd+hrB0377NjoDzTPiE0rJ1dcY0CllVQaqFwo2fM3LA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wn9iX-000000020xn-02rz;
	Fri, 24 Jul 2026 08:49:09 +0200
Message-ID: <d3df4236387840a77c74de7cb006771897a0ac68.camel@sipsolutions.net>
Subject: Re: [PATCH v2 10/10] Documentation: um: document nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, liam@infradead.org, ljs@kernel.org, 
	ricarkol@google.com
Date: Fri, 24 Jul 2026 08:49:08 +0200
In-Reply-To: <m1fr189ael.wl-thehajime@gmail.com> (sfid-20260724_082009_043274_DA4AC8AB)
References: <20260723093633.140989-12-johannes@sipsolutions.net>
		<20260723113633.19c6669dc151.Ibd7a532eef856a1ea39699a263dfa8a9ded9dc20@changeid>
	 <m1fr189ael.wl-thehajime@gmail.com> (sfid-20260724_082009_043274_DA4AC8AB)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_234914_547909_83706D56 
X-CRM114-Status: GOOD (  16.90  )
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

On Fri, 2026-07-24 at 15:20 +0900, Hajime Tazaki wrote:
> > UML models this with
> > +a **userspace runner** - an ordinary uml-userspace stub host process, =
started
> > +exactly like an MMU userspace process, but with the whole of "physical=
" memory
> > +(the physmem file) mapped into it at the kernel's addresses:
> > +
> > +- The runner ``exec()``'s the stub just like the MMU case.  The only e=
xtra step
> > +  is that, once it is up, the kernel maps the entire physmem file into=
 it in one
> > +  go, at the same addresses the kernel uses.
> > +- Because NOMMU never remaps, that single mapping is all a runner ever=
 needs:
>=20
> I was actually not sure what you mean here: "NOMMU never remaps".
> could you care to elaborate ?
> the subsequent parts are clear to me.

Yeah maybe, that's a bit cryptic. I mean, we have an MMU-less base
kernel, so there's never any request to remap for anything, so

> > +  there is no per-mm host process, no TLB sync and no ``mmap()`` of in=
dividual
> > +  page-table entries into a child.  Userspace code and data - placed i=
n memory
> > +  by the loader - are directly executable and accessible.

the original mapping that we make into that process is left alone
forever. The map machinery in the stub is used only exactly once.

> For the alpine packages, I'll contact the distribution once this UML
> is upstreamed.  And update this part with more proper information
> rather than my personal repository.

Sure. It seemed far simpler to point to it than to try to have
instructions on how to build it (I didn't even try), and I'm assuming
you don't plan to remove it :)

johannes

