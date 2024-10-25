Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2518DD10399
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FbC6SaVrQ/jk1TuGcepBPTSL5kMre04nggkxktXSkAM=; b=BFckyzKDGzxbt2XLgg79vjQXSo
	r8iQJcObgZXFHCWONGbrW1SYWbHuI6xB5UKj6VppMH86ju2zyYOSY3dQcIS4UkfoKghgebKbWpRT8
	IAqOhSKhZcbENYdad4zDl06TItwJQaYoPMpyVUL4z80Ul7ZfL79YvHPZx63axNOroWJlgdigFfUhx
	CSiKi4GTsnzZYQDRiPlF9XV3PSe6khFYDuSgeA0m5mCyLbH1esCZH4J7WGIKg/XS9Fb/8jBiY1Kjp
	xQYDAaU2bmy1GeDzKkbPVW17at/zVVxIODyPJOSbeQCGNKqk09vAkycTJk1p3PcyAhJM8L16O8SjA
	zyFSc2MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MNN-00000004H7Q-3U6u;
	Fri, 25 Oct 2024 15:37:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M9Q-00000004E9M-3yQ6
	for linux-um@bombadil.infradead.org;
	Fri, 25 Oct 2024 15:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FbC6SaVrQ/jk1TuGcepBPTSL5kMre04nggkxktXSkAM=; b=bEnIKo1zUKwCrsjb1G1lJXTsuh
	lwMLXMCgXptdW7PJyzqNxQWJqrIjVU1MDBGQM0AzEN/SktdXAS51DamkQSlzhrVjVlPfMqYSvhb1r
	WvowWjxg2qYdT339RpSL67igseMQJUapTR4N9UDQdFVWACTIvo7fIr8U1lD9fF95yHEI873EpABI+
	X07ZUEWGI0Zp11tnNsTZM+scxF+BaeWXlH8evQFUbbiVttHm1Y8vuFdB7nIe0r/r4KW090d06d+cv
	ahN7SM1pYak1Hnr8R3VBLhACfPQZY2pGtV6bFTQXXpPERqSouBzdWYHldP4mSoUWXM9lPhv+UW0Ve
	jJA0wXrA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M9N-00000008xx9-3XPq
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 15:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FbC6SaVrQ/jk1TuGcepBPTSL5kMre04nggkxktXSkAM=;
	t=1729869771; x=1731079371; b=PdDj7Ff28feLvujAMvsDdgGaPk4kfk/s/6fzrf/KfuNdomz
	3p/liw0QpcuUQs3xay3KrtucUWtsgeSeZFosBdoaW3TC2f5dRPkW+bjJ0eWTTUhrCxIaQyc7avqOy
	O1ONvsesrgNqLlTXkrhuy1AsNdaQuz0wvvc7+obg7c2b7vQMRqCzDXSLz3x2koDW8Mc3ikzGXEamo
	4IGvdCgb34Yi4j48rZuKxeAj481+NwJ4BqEmGBb3u3Vsx9yuV7jY8Pq9W2CW2lx3G0PwXBSKdQuZe
	kAmMJthXWX5wrNtSPst4ez0vjDJ1xkeN2nLTZKb+t7OrbeHk3ySbh2wF8CoOYQDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4M9J-00000004akG-1en8;
	Fri, 25 Oct 2024 17:22:49 +0200
Message-ID: <ed09a50887e876e7799626e03b47a603b43c0c8a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 07/13] um: nommu: configure fs register on host
 syscall invocation
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, ricarkol@google.com
Date: Fri, 25 Oct 2024 17:22:48 +0200
In-Reply-To: <m2ldycnwhv.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <de4b12980873dac3074d591ab4ee0241d81c691b.1729770373.git.thehajime@gmail.com>
	 <ae681534ae7c9484303c41522ec4b6a765a3d3ec.camel@sipsolutions.net>
	 <m2ldycnwhv.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_162254_058514_AFBC0423 
X-CRM114-Status: GOOD (  16.34  )
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

On Fri, 2024-10-25 at 22:27 +0900, Hajime Tazaki wrote:
>=20
> On Fri, 25 Oct 2024 18:28:01 +0900,
> Johannes Berg wrote:
> >=20
> > On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > >=20
> > > +static void sigill(int sig, siginfo_t *si, void *ctx_void)
> > > +{
> > > +	longjmp(jmpbuf, 1);
> > > +}
> >=20
> > Should this code use sigsetjmp/siglongjmp?
>=20
> the code is referred from tools/testing/selftests/x86/fsgsbase.c and
> the original code uses sigsetjmp/siglongjmp indeed.

:)

> I was struggling to pull the definition of sigsetjmp & co from host
> headers as it conflicts with UML definitions of jmp_buf, etc.
>=20
> Will look into detail again but would be nice if you have an
> experience on this.

Hm. This is a userspace side so there shouldn't be much trouble with
that? Worst case put it into its own file in os-Linux/ and don't include
so many shared headers, I guess?

> > > +int os_has_fsgsbase(void)
> > > +{
> > > +	return has_fsgsbase;
> > > +}
> >=20
> > Why should this be a function rather than just exposing the variable?
>=20
> as it is referred in arch/x86/um code.

Yeah but you have to also declare the function somewhere in a header
file - could as well declare "extern int host_has_fsgsbase;" or so?

johannes

