Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D43D41C18
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYh4HiRg/u8aVibDhRGMBXFvHABp1YG7/ORYPm3vBNE=; b=qsv7/7DARMPWJC4waTeBmjcrvf
	pfi8KTIh++udHn+NvC9Z5pjspnK+LurWjlLAdfJ75sgjzgJMytmDyXbyPTjK/hBXAHC4frgiR137U
	oByjXq5rcPE3dhXIwajUR9eTI3LW/9VnfPiZM5gBuUNmAiORBJ4zutldZvH8W6IpPswv4g1lRRqU+
	XZ/9jpvjSu+DtvJ+4/UHKJjn3snarr56NumHR5vuWssG1NN6KhOXjctpiJ0pSIuQtQ03Ak3sjn4cd
	kBL7YxDgpDF1mYPz9LHJDrtk1mzlvKcmcpIhW+fBtYQO5WGZyKbzfcSi7X5pFwYZd51CkC7HLLwQW
	9SNAfA0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8sL-000000067Wc-14vs;
	Wed, 13 Nov 2024 08:37:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8rE-000000067MW-0Vkc
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 08:36:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QYh4HiRg/u8aVibDhRGMBXFvHABp1YG7/ORYPm3vBNE=;
	t=1731486970; x=1732696570; b=j5zZgmKRU6yq4JBzgzILZrtxRFgRlSQN8Gxq7UprSc9i68x
	MmukSMwKIcz4OEU70986Hc8E+f88h8h6TmEpN+FYfyFZLEoj5ovMYt2D9eM0mp4NzHyd4kvEYgmzQ
	so0BcD8gEsLzRxMas33U1zalqDNFdrpo+OzMteXpklABRM3U7z4qUNDigKEBL4YgdLfne5UA9zDnV
	BJResjSKd/EkM/5adeKcaENCNflXbSVl2ee3/1kO4puHQO79smY9jsHFxrVN+/mMbwSLVFbNFIZ/J
	Rzg1uvJcqlEZrV6csu4BtQlyGRKlj8I5DINhugq9fZK0rNpEa535lRt3BWddSOpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tB8r6-00000003mN8-26Et;
	Wed, 13 Nov 2024 09:36:04 +0100
Message-ID: <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com,  ebiederm@xmission.com, kees@kernel.org,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
Date: Wed, 13 Nov 2024 09:36:02 +0100
In-Reply-To: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	 <m2pln0f6mm.wl-thehajime@gmail.com>
	 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_003612_453789_A5C2A5D3 
X-CRM114-Status: GOOD (  10.77  )
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

On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
>=20
> > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !=
MMU)
> > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENS=
A) && !MMU)
> > >=20
> > > s/UML/X86/?
> >=20
> > I guess the fdpic loader can be used to X86, but this patchset only
> > adds UML to be able to select it.  I intended to add UML into nommu
> > family.
>=20
> While currently x86-nommu is supported for UML only, this is really
> x86-specific. I still hope UML will get support for other architectures
> one day, at which point a dependency on UML here will become wrong...
>=20

X86 isn't set for UML, X64_32 and X64_64 are though.

Given that the no-MMU UM support even is 64-bit only, that probably
should then really be (UML && X86_64).

But it already has !MMU, so can't be selected otherwise, and it seems
that non-X86 UML=20

johannes

