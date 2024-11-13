Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78544D41C17
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9c+QMjucCNR1+cmEP5futdaVPW76iv6bA48yEkio5hI=; b=PdMRaRIgspnqmn5AWqWgS+cGeT
	y1qxV7J/9FyNZONRYK2SKDiyMbEiDCqZf5Ob23oc+0JvLa6ybX350/5g0X9sOxlcmQAoyo8CLOtlN
	o+U3wJtGfJqFIFL8CkEqa0jWkjl7IvTHx4dtiDit1JYznaWscUA4R/QtHSnE0LSfo2TO+KYD/Nuhn
	qIli1qjshfn5MQ1wNmB88XEPncVQ0ozeM9c9zPHFvP5pe7gOliZDO2/FqlxcLa9noDmkGUeYl7CMd
	Lo7kicDLsSDAkFTys5qkm2EoZvW4/0ny4BeUxs/rM5p46hAT5ArKNwCsBahD88CtaSh7EwbmGC8Id
	BlXFhXsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8u9-000000067vy-0evD;
	Wed, 13 Nov 2024 08:39:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8s6-000000067Ty-1B2l
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 08:37:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9c+QMjucCNR1+cmEP5futdaVPW76iv6bA48yEkio5hI=;
	t=1731487026; x=1732696626; b=tZzmGvrzuSkGh4z8KlWemsp7kIU/Mp2Y3oQ+/lXkhF0GgHh
	gJG+ybGuWELLhfzgzLx6N1O9LuTtdegEjpjuhTntaOTLoe+/rqEQDpw9TBWSnK5SbBSqdolYoZVFW
	Da20QNNSOW3B5K74Bj+8Rs+zUB2wsMUwnAuKsSyBtpM2V0yDM+5L4DAOpQkrGZQDhNTvOF6t/Nunm
	Ulz7WPIs5l/tv5AjV8n6xHKxGTlRcIslkScWrPQdTinlzPxEJ7D/7Z8BY1U3NYAkInWLVVFgS3vbr
	xQMUDvyK5VKHA6+kQVvj0msEnqqdLLgZMxFD/sV+bdCp64OLr8G3i1pywGkoO/rA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tB8s1-00000003mOe-1rzZ;
	Wed, 13 Nov 2024 09:37:02 +0100
Message-ID: <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com,  ebiederm@xmission.com, kees@kernel.org,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
Date: Wed, 13 Nov 2024 09:36:58 +0100
In-Reply-To: <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	 <m2pln0f6mm.wl-thehajime@gmail.com>
	 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_003706_341880_6B4B3EF3 
X-CRM114-Status: GOOD (  14.18  )
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

(sorry, fat-fingered that)

On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> >=20
> > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) &&=
 !MMU)
> > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTE=
NSA) && !MMU)
> > > >=20
> > > > s/UML/X86/?
> > >=20
> > > I guess the fdpic loader can be used to X86, but this patchset only
> > > adds UML to be able to select it.  I intended to add UML into nommu
> > > family.
> >=20
> > While currently x86-nommu is supported for UML only, this is really
> > x86-specific. I still hope UML will get support for other architectures
> > one day, at which point a dependency on UML here will become wrong...
> >=20
>=20
> X86 isn't set for UML, X64_32 and X64_64 are though.
>=20
> Given that the no-MMU UM support even is 64-bit only, that probably
> should then really be (UML && X86_64).
>=20
> But it already has !MMU, so can't be selected otherwise, and it seems
> that non-X86 UML=20

... would require far more changes in all kinds of places, so not sure
I'd be too concerned about it here.

johannes

