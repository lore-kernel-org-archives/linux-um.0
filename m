Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78048E77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 10:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=423Vj5fZsGV5eJGSXq4heFmx7126IRBdG9xAKxYQ7SM=; b=j3HaLxgnWm9EsD1TdtUOudxjJ6
	gu9RWW1Xsbv0/joFHCumaBuWk2xGX500MCI1jNeEFR/BNlh8gine4TlPCYY9GgESzHYlKUONpfii1
	KRk2VBGDVibkpDkjhGqYTxPLZ0P8h65ZtuiAPl11JSAiUujWJpK52VKJWdVkO26HNHRvkV5OAPX/i
	nDILKE8tvR8SpNJzd9PIJ9qMu7V5kMk9Px/9Ov9cxluOaGQfDNJRqJWDQHvyymq11KU7SbwcA9qwh
	xI+gkt88ntzTvZst+yZ5HGcc0OgHixmnDLWfR3HSeOkqR8XQgjiRtjJm+pjbaPc6y1Nm/dfJ10eft
	hAXtnhoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfN9-0000000CmCd-0NYQ;
	Fri, 03 Jan 2025 10:57:43 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTfN6-0000000CmAz-1GKX
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 10:57:42 +0000
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id E13981D40AB0;
	Fri,  3 Jan 2025 05:57:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 05:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735901855; x=1735909055; bh=423Vj5fZsG
	V5eJGSXq4heFmx7126IRBdG9xAKxYQ7SM=; b=JuerdEJ1tAgll50QlC4YxQajBf
	DkgtwccDxlugt0VAiPqTYmOx3GXlMhMKhInAHOhPHtCUJNVjyBIs8RCY6PmlgpPd
	xjLcTrvjispwERy/WyDFaFCq44v2e9hYfmST5JDKKoCtNQAdDxPM7g2pWmcNIY8l
	u+d1SFw9C0Oj8nBwS58aWGssWJC174PqAvBZ++Jl35N2Rp2ST42JS/1xPQuCWGuB
	uzNHPEZbLVOj3JElOSs4/va2bTWToNKvpCgV1oXlORCOrAs+PBSaquoBLoELmm6k
	qrzyAnzURUQhidmjBnTvvLUKfN6MZru2w/B99p4zUHA0t9IyaG3GOmEd0mMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735901855; x=
	1735909055; bh=423Vj5fZsGV5eJGSXq4heFmx7126IRBdG9xAKxYQ7SM=; b=G
	cajOF2vlD6eM2BhItchNYObDe20cSKdE7QdHWS3S4zXB201VqahnXDUkhhCiI/Oa
	7boz+JhhU+xUc3f9Q61PUJi6PCNy6gHu5Vy2AE8TMXwUJepQ7OTHmO6nHbXzqhXP
	5wZKIRsd8h43f2+M6Aa0K5COGyPslerP3NPAAvnLWzj418SzIl/c4Cn02vLT/6t9
	MH8LJjiuaiadIx1iLE1XEKOPBtX76ZhMcmqtgzG18nTj7HPNwkKJKR8uTQvLV5pj
	dnUeUPcA3zIoiLlzyomyZAG/83zl83w6LcvXKdit3G8TtXQReL8yXf7vFJaeKZqa
	vDZZtBKg6qDqRt+mQBlPw==
X-ME-Sender: <xms:ncJ3Z6CXVWyExCYlgmBZdOs6uG3V0GYZ8GxhhWzgeULLUuScarTgMw>
    <xme:ncJ3Z0hrIdZeHDl9chKR8qX0FAfe0xnC3zbnBZ_BynCHY7kuWJTtSbb--5j1pW28u
    XAOmloVnrT0Ig>
X-ME-Received: <xmr:ncJ3Z9m1XYDfuQmpOwos3HoM0I0-2Se522cNPFJ64z61BySOCJsFCJqnGXKgktMJqPuZQuYkJaArSpfl_gEKUjXrvRlAkRFMwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtgfgjgesthekredttddtjeen
    ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
    grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
    rfgrthhtvghrnhepveeuheffhedtffeivdffudehieekkeelleehhfevgefggffgjeejtd
    ffheejgfegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhish
    hisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeegiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrtghoohhpvghrfeestghithhrihig
    rdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhr
    vgihshdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhope
    gsrhgvnhgurghnrdhhihhgghhinhhssehlihhnuhigrdguvghvpdhrtghpthhtohepuggr
    rdhgohhmvgiisehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepuggrnhhivghltheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:ncJ3Z4zPNvCOjmc1oKkrAYZ9xaG0fyawlsfb_9ujyU1cR20qR2SiHQ>
    <xmx:ncJ3Z_TqIX8N6jwrirsSXns9bdjWEmxb5qLaSpMfRfKmd7zOLSLvpw>
    <xmx:ncJ3ZzbeXkzGZLYn9eDgxNT7PS59Rmxit9htXHx6_ndO8uaxw3OOgQ>
    <xmx:ncJ3Z4SybuD-tbCQ01TzhidgZIEhKMy9QHnKqhApQ2nSmKbYzzUrHw>
    <xmx:n8J3Z28oyn0Vw20TlJT55P_RAeGNO_Dj-NJTH4vhK9jKgcdUPujFBW6n>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 05:57:27 -0500 (EST)
Date: Fri, 3 Jan 2025 11:57:25 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, lorenzo.stoakes@oracle.com,
	anton.ivanov@cambridgegreys.com, bp@alien8.de,	brendan.higgins@linux.dev,
 da.gomez@samsung.com, danielt@kernel.org,	dave.hansen@linux.intel.com,
 davidgow@google.com,	dianders@chromium.org, hpa@zytor.com,
 jason.wessel@windriver.com,	jikos@kernel.org, joe.lawrence@redhat.com,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	kgdb-bugreport@lists.sourceforge.net,	kirill.shutemov@linux.intel.com,
 kunit-dev@googlegroups.com,	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	linux-mm@kvack.org,
 linux-modules@vger.kernel.org,	linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org,	live-patching@vger.kernel.org,
 luto@kernel.org,	mark.rutland@arm.com, mbenes@suse.cz, mcgrof@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
	petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at,	rmoar@google.com,
 rostedt@goodmis.org, rppt@kernel.org,	samitolvanen@google.com,
 shuah@kernel.org, song@kernel.org,	tglx@linutronix.de, x86@kernel.org,
 Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <Z3fClUqJ_sMp1HL9@mail-itl>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
 <20250102215714.a37e828cf073ea6a14d30559@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102215714.a37e828cf073ea6a14d30559@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_025740_781249_777333EC 
X-CRM114-Status: GOOD (  17.06  )
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Thu, Jan 02, 2025 at 09:57:14PM -0800, Andrew Morton wrote:
> On Fri, 3 Jan 2025 02:06:10 +0000 Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> 
> > > Hi Mike,
> > >
> > > This commit is making my intel box not boot in mm-unstable :>) I bisected it to
> > > this commit.
> > 
> > For what it's worth, we've found the same under Xen too.
> > 
> > There's one concrete bug in the series, failing to cope with the absence
> > of superpages (fix in
> > https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@suse.com/
> > but not formally posted yet AFAICT).
> > 
> > The rest of the thread then found a crash looking to be the same as
> > reported here, but you've made better progress narrowing it down than we
> > have.
> > 
> 
> Thanks.  I removed this series from mm.git while this is worked on.

The issue under Xen that Andrew linked happens on 6.13-rc5 which AFAICT
doesn't this series yet. So, it's probably a different issue.

- -- 
Best Regards,
Marek Marczykowski-Górecki
Invisible Things Lab
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmd3wpUACgkQ24/THMrX
1yzmigf/XurIB/pN9J44SKwSeCWCQMVu3ZjFfeQ7XiAl3IpiALExuGFtEiAX8sY/
BqA3MWs9AKpBz7qfUQGU3+tRUbEVQz/rHh8FBo3OBwZQJuxntlT291E4/FzIHUzN
JZ0b6AAgU9MaSdOC0A0XGwFDbhTPbbqbHanyaVyCf+2QVCEW4OFcgnlUVBdIs6sW
tXzKWNr70Jkq/XguvrWVBHgg5C3E/SfXZzoRIFCKfMuXfpqVVpa35X/Zf3+V8my/
n0Di7xZXQaXMSv72tQayI+/y2dT4PbLqTE+lhLf2UCXDn15WBHpmyppX9Nn3huEG
L0NRHVLneeo25kRQuzGj04vWFem6MQ==
=0Iqv
-----END PGP SIGNATURE-----

