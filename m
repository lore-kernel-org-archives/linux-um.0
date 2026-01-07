Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C839CF6BE2
	for <linux-um@archiver.kernel.org>; Wed,  7 Jan 2026 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0+D1N2EwKstZ1cEtH04fsN9pDOjZ6UBkqKLK2OwqQk=; b=qMSKPtOHN1itDvojy8V4g7QrxO
	+RkaYpYrXGdMe1IxMUcVmWfTCxCmEcY+T5C3lm3DP/a3eV2KemgtKFE2S5cB4Qg6y0aIGVmZjP5sA
	JFbemBLDUut2d3G/8gtcY6CeUXrdnWioVgXkvrnNUrsxMW10Vk96ALDjLQxx+EaBHAuBpPaFtcroh
	LxTw7hZW76CqzzdQpMJRw6t8wJBbE1gzo7KpwolW1IpqdL8esAHnLEM7W1/tcPsJmG+lJ7iBRm9aJ
	3u7MBQLYaxgt1jFuyIZ4pta7AZXKQgQlL3sAVCyH97wBjvPBGtCrS6pPDnYgP7jLHhi+zdGX9dW2p
	/tjUkjkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdKBp-0000000E7ef-0iBa;
	Wed, 07 Jan 2026 03:26:29 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdKBm-0000000E7dg-3XoJ
	for linux-um@lists.infradead.org;
	Wed, 07 Jan 2026 03:26:27 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4f4a88e75a5so14721281cf.0
        for <linux-um@lists.infradead.org>; Tue, 06 Jan 2026 19:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767756385; x=1768361185; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h0+D1N2EwKstZ1cEtH04fsN9pDOjZ6UBkqKLK2OwqQk=;
        b=cdVwZzYVzAVazlFr43wqfOzwoccGRNqXHvr1+R/whPGvZQsExye1XhX+AWunlZFECD
         QyLMnx4FOSErbcIqTTuna2SIx3is/9ERbIAOpzw6WkyU7E3wqg5hmYVsv/gs2urHQrJG
         IkNravVL6J3bHdCxIYBufO56YZDo2vMV0pKVmBFTbnRH6SvuF3IyAePa2V8cccxY/TPS
         7boVYUw9OTi+iZ5J9QhW4Yu52O7aNBosDnBUziT9X9WjxV88qXKr0QVqKZ9BO/AdetwO
         R39o22P/AbaZFn+6vsaI+B0SR5IGpT4s4bl9MTuux5r6faXUb/hKi1wTjdxRU436pYiz
         I7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767756385; x=1768361185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0+D1N2EwKstZ1cEtH04fsN9pDOjZ6UBkqKLK2OwqQk=;
        b=KptE1V7hAkcSKRSykTlKMfcpCJf6niZXK6g+4jhEJjLtu4Sy6MJBXcsmgoSPuOmbNZ
         k4Bfy1NWOS7RmYbc1b9ey9ATc3XwL3LPFXc/87BD38T4u1KiXnyOXKyY7UcJoIi7Yz+p
         a7DakIb50MWau4Oi9Q3VBGohRCE9qrHLqHF8ePixulryGot81tf9uAxoYs5QlFuAA+r1
         nbo3g9PnF98ADrqFpLeHgQ1UswC3nlKsfx+aNZg67nmYHOWHnFTLLTRExVqua2VUJ+uM
         beuWD7X2EJU4lLCP5xDcz1+AeJp8etVU869QTONIncxDTpWxP02xtpTKK2TyiH4HlNdI
         iQzw==
X-Gm-Message-State: AOJu0YyvtT/YIj/t6Jrjtx24gW3MMtJZjsJpq5/LXMbOwS4i1PLnmOnw
	P2b2rcYHGdbWKX0DCfGAe26YkKZDk9J0GlTxUwNUiuiUlxS+GCLCv+p1
X-Gm-Gg: AY/fxX7WDDc/Un1yi2HZ18SDB6emIJNVJ7EaRBsl5DF1QIT31yscWlYXequXeNB8ZhD
	423LOhFCdCbG1G+9dKqMMo1lSSnNsuONHrq3k/nD2YArHwZo2RefHQCDbqrzEtiUIf0hKED0uDY
	oFCQEnoaFYvi+Pwg8dILZR4MsSrxI6wrBT9Q/0mBxDqJlGlObypmxuogAryWb13qvtEDijMbc6s
	Ywtmr+NC3tqPBFfHfhWjN7qiZ2qzbSmjuZlKIC10RQGNhUMcyDrzM2AIHXdPkLY/3gFjytXx4q+
	xyF3+jFTGFz5qZ36jFiq4lGZJkU4sBDYfD13XkszBEFt0/T6/+SqGI/YPv4Ptp4XNlGKR4CFvHr
	VM/ny489nA4XMFwMUmq2mQ3ZFIRl1hOqIH+p4HENWezxpgfw8QZQh6cU+i3cF6oVD1Orhx8IPe+
	K7H8zwVpALKnQSbI4jM2JAqsAlFcDS6A1Ja7h4L+7MqZ+dEfqSk5RnmsONDNNUX2dPE8ck9xGxO
	LDamf2i0IZJ3w4=
X-Google-Smtp-Source: AGHT+IH9GJu9+EXUTtQe4Cld6zxjJM86QK6J7IFCcyJYBK6CzHtH8I+HuNVR/4VYN8X8s52VQMmiUw==
X-Received: by 2002:a05:622a:4a:b0:4f0:2afc:3b80 with SMTP id d75a77b69052e-4ffb49e9d4emr13443651cf.56.1767756385253;
        Tue, 06 Jan 2026 19:26:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc7a6sm25982596d6.12.2026.01.06.19.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 19:26:24 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1893BF40068;
	Tue,  6 Jan 2026 22:26:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 22:26:24 -0500
X-ME-Sender: <xms:YNJdafQbBt23LSIEbz2IF1qhwqQHt0EgCbT6qJp2qIw9SeYCKXRblA>
    <xme:YNJdaRPmExH5xTVLA1Yox_Rk8dZneyZeimp9t54EEekJcyhpOJqjiSe2y3vwZIP3L
    B3kz_qznim001-lJ5WNMALvMisxRIlzGL0XQ1umX_7fqBrBiOfZ4w>
X-ME-Received: <xmr:YNJdaaRLcI7x_JFVFPRC5ydhDth-WOMpmDnV_6PNLRCXyBbAKZtfjqEq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnheptdegheelveffudejffegvdelgffhhfelkeeiieefgeevteejvdegveeuffei
    hefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtoheplhhinhhugidquh
    hmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepgiekieeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrih
    gughgvghhrvgihshdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhl
    uhhtihhonhhsrdhnvghtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghp
    segrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugi
    drihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:YNJdac_jLZOivwUm7tjN7Nptb4VG4euEmqJ0Wv6HMzqlsO9NJ1p8zw>
    <xmx:YNJdacVxwWFWoylO8BmFTgUTJhaFRO9xOWd8eqh5MzVRh0DyXNyHIQ>
    <xmx:YNJdaSN2-Th14u-z9vQG5UM94-cgbE1lCeY_z36hd9pX-Mu8_WWMHQ>
    <xmx:YNJdaUekYAthEiyNR16VV_Pak0BjPHMuAIG5COTP6eMArihGZdkW8w>
    <xmx:YNJdaRxjQ3WCvid3eGgh00t0QZaZE5Gp9RhwdMrwyE4NPszKV2_kqgOG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 22:26:23 -0500 (EST)
Date: Wed, 7 Jan 2026 11:26:21 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>,
	hpa <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	dakr <dakr@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86
Message-ID: <aV3SFWYUbN5t9LiW@tardis-2.local>
References: <aVxcAZe6AEXEfx3G@tardis-2.local>
 <20260106034034.60074-1-boqun.feng@gmail.com>
 <1064740857.79527.1767709243348.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1064740857.79527.1767709243348.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_192626_901724_2A84F4F1 
X-CRM114-Status: GOOD (  13.22  )
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

On Tue, Jan 06, 2026 at 03:20:43PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Boqun Feng" <boqun.feng@gmail.com>
> > An: "linux-um" <linux-um@lists.infradead.org>, "x86" <x86@kernel.org>
> > CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
> > <johannes@sipsolutions.net>, "tglx" <tglx@linutronix.de>, "mingo" <mingo@redhat.com>, "bp" <bp@alien8.de>, "dave
> > hansen" <dave.hansen@linux.intel.com>, "hpa" <hpa@zytor.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
> > <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Björn Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin"
> > <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
> > <tmgross@umich.edu>, "dakr" <dakr@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Rust for Linux Kernel"
> > <rust-for-linux@vger.kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
> > Gesendet: Dienstag, 6. Januar 2026 04:40:34
> > Betreff: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86
> 
> > x86 atomic instructions are used for um on UML_X86, therefore atomics
> > on UML_X86 support native atomic RmW as x86 does, hence select
> > ARCH_SUPPORTS_ATOMIC_RMW.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > UM & x86 maintainers,
> > 
> > I need this to avoid a build error for Rust atomics since Rust currently
> > only support Atomic<i8/i16> on ARCH_SUPPORTS_ATOMIC_RMW archs. I will
> > add it to my upcoming PR if I get some Acked-by, thanks!
> > 
> > arch/x86/um/Kconfig | 1 +
> > 1 file changed, 1 insertion(+)
> 
> Acked-by: Richard Weinberger <richard@nod.at>
> 

Queued with both tags applied, thank you both!

Regards,
Boqun

> Thanks,
> //richard

