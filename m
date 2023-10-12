Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C684CDB46E
	for <linux-um@archiver.kernel.org>; Thu, 12 Oct 2023 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BorJ9mI55a+fG/9QHtf2p4GlRnZkXwdwCzpMI09hdco=; b=W5vSFDMYJK7Qsx
	tck84XJokZsnT2pPXs2AxR3Uj6iIOerT0VwHSpmTVrzjtNVBJHgLISgCerEAkQ8hwOlG7XOgngyAL
	+F2maypO2Dt8HHULveR7LXczaPc1IcZMV4krlxH8+1dCNHwjQ5lBoHjIiTUELiZyibypT41DUFOjc
	K6h1ZbWGCKkHX7o7NwIp8aJKszQT9XT8E3on0JpJNUtJSqFY6iuNnUWDAKeG4ZzkNBBGs4SuAoj4a
	rYUcBDWWawbUtFU/RNmdyq/31sodGjDCoQQC/FNp9mL3L8GsNTjd47uepgJTF7iNc07WRt4UDZhVt
	igfVouO78WCp3Ldr31Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqp4b-00HXdM-0I;
	Thu, 12 Oct 2023 06:21:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqp4U-00HXbm-0t;
	Thu, 12 Oct 2023 06:21:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AE2FACE26CD;
	Thu, 12 Oct 2023 06:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4319C433C8;
	Thu, 12 Oct 2023 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697091678;
	bh=s6uI62kWxpmT9BzfhoB8YxDyPpu+xLr4/ShPg1QpyT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WiQIwlhLS8bXp+msMDt6HtWr1T26tfn4w3fKoqOTiDGPR/X8vhmm3wd70eY2PB8eE
	 VP2mSP3WUhhNXGnIo64r9818i2nZmyfYofFj6Y+8f/M04/zD+x90U/8EtFjzgzw1LH
	 P4nak5HtVqyUQrH9ejeW5JaFpcilPfuCmRR4x4MlyPyv0Jp//XlSYYw0WXlFnh02tJ
	 CgSCT2TXndecohYXZhukflQAu3v9m9YFGXM8FpROy4zQpaT/qDNr76/3ynKtZZgOoD
	 VNRzW6Dfj2oB4meKo10yzt9RFfc50NjE8uXis0VEAmKjcsWFQxRU9i82uCetg2zv7J
	 UNFWPaJyJ8AFQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1078954a12.1;
        Wed, 11 Oct 2023 23:21:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YztYuLTPOF67L777qapixAlkZmXU+016B9gLWJeOUYHBhNHxKCa
	OeRyZYMUkoiFquewmGYuODajqOSktYn4C4AW/QE=
X-Google-Smtp-Source: AGHT+IHeMn2bhCQxI8gRyeIl8+tWDbyaP2jvXgPlujPGin+1NpHfgUxHO4agK11Du8XZxDTGmxOPLejydycJpfSqufI=
X-Received: by 2002:a05:6402:27ca:b0:53e:197d:a4d with SMTP id
 c10-20020a05640227ca00b0053e197d0a4dmr350877ede.4.1697091677060; Wed, 11 Oct
 2023 23:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-4-masahiroy@kernel.org> <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
 <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
In-Reply-To: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 12 Oct 2023 14:21:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS8Gi+gSPhQcpNj2Yjjr0DZLtOy8S18Am8KtCqRbBLRhw@mail.gmail.com>
Message-ID: <CAJF2gTS8Gi+gSPhQcpNj2Yjjr0DZLtOy8S18Am8KtCqRbBLRhw@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
	Will Deacon <will@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_232122_673071_7288C40C 
X-CRM114-Status: GOOD (  17.42  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBPY3QgMTEsIDIwMjMgYXQgODo1M+KAr1BNIE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhp
cm95QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBPY3QgMTEsIDIwMjMgYXQgMTE6MjTi
gK9BTSBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBP
Y3QgOSwgMjAyMyBhdCA4OjQy4oCvUE0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9NYWtlZmlsZQo+ID4gPiArKysg
Yi9hcmNoL3Jpc2N2L01ha2VmaWxlCj4gPiA+IEBAIC0xMzEsMTIgKzEzMSw2IEBAIGVuZGlmCj4g
PiA+ICBsaWJzLXkgKz0gYXJjaC9yaXNjdi9saWIvCj4gPiA+ICBsaWJzLSQoQ09ORklHX0VGSV9T
VFVCKSArPSAkKG9ianRyZWUpL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvbGliLmEKPiA+
ID4KPiA+ID4gLVBIT05ZICs9IHZkc29faW5zdGFsbAo+ID4gPiAtdmRzb19pbnN0YWxsOgo+ID4g
PiAtICAgICAgICQoUSkkKE1BS0UpICQoYnVpbGQpPWFyY2gvcmlzY3Yva2VybmVsL3Zkc28gJEAK
PiA+ID4gLSAgICAgICAkKGlmICQoQ09ORklHX0NPTVBBVCksJChRKSQoTUFLRSkgXAo+ID4gPiAt
ICAgICAgICAgICAgICAgJChidWlsZCk9YXJjaC9yaXNjdi9rZXJuZWwvY29tcGF0X3Zkc28gY29t
cGF0XyRAKQo+ID4gPiAtCj4gPiA+ICBpZmVxICgkKEtCVUlMRF9FWFRNT0QpLCkKPiA+ID4gIGlm
ZXEgKCQoQ09ORklHX01NVSkseSkKPiA+ID4gIHByZXBhcmU6IHZkc29fcHJlcGFyZQo+ID4gPiBA
QCAtMTQ4LDYgKzE0Miw5IEBAIHZkc29fcHJlcGFyZTogcHJlcGFyZTAKPiA+ID4gIGVuZGlmCj4g
PiA+ICBlbmRpZgo+ID4gPgo+ID4gPiArdmRzby1pbnN0YWxsLXkgICAgICAgICAgICAgICAgICs9
IGFyY2gvcmlzY3Yva2VybmVsL3Zkc28vdmRzby5zby5kYmcKPiA+ID4gK3Zkc28taW5zdGFsbC0k
KENPTkZJR19DT01QQVQpICArPSBhcmNoL3Jpc2N2L2tlcm5lbC9jb21wYXRfdmRzby9jb21wYXRf
dmRzby5zby5kYmc6Li4vY29tcGF0X3Zkc28vY29tcGF0X3Zkc28uc28KPiA+IFdoeSBkbyB3ZSBu
ZWVkICI6Li4vY29tcGF0X3Zkc28vY29tcGF0X3Zkc28uc28iIGhlcmU/Cj4KPgo+Cj4KPiBBbGwg
YXJjaGl0ZWN0dXJlcyBleGNlcHQgcmlzY3YgaW5zdGFsbCB2ZHNvIGZpbGVzCj4gdG8gL2xpYi9t
b2R1bGVzLyQodW5hbWUgLXIpL3Zkc28vLgo+Cj4KPgo+IFNlZSB0aGUgZm9sbG93aW5nIGNvZGUg
aW4gYXJjaC9yaXNjdi9rZXJuZWwvY29tcGF0X3Zkc28vTWFrZWZpbGU6Cj4KPgo+IHF1aWV0X2Nt
ZF9jb21wYXRfdmRzb19pbnN0YWxsID0gSU5TVEFMTCAkQAo+ICAgICAgIGNtZF9jb21wYXRfdmRz
b19pbnN0YWxsID0gY3AgJChvYmopLyRALmRiZyAkKE1PRExJQikvY29tcGF0X3Zkc28vJEAKPgo+
Cj4KPgo+IFJpc2N2IGNvcGllcyB0aGUgY29tcGF0IHZkc28gdG8KPiAvbGliL21vZHVsZXMvJCh1
bmFtZSAtcikvY29tcGF0X3Zkc28vLgo+Cj4KPgo+IFRoaXMgY29tbWl0IHByZXNlcnZlcyB0aGUg
Y3VycmVudCBpbnN0YWxsYXRpb24gcGF0aCBhcy1pcy4KPgo+IElmIHRoZSByaXNjdiBtYWludGFp
bmVycyBhZ3JlZSwgd2UgY2FuIGNoYW5nZSB0aGUKPiBpbnN0YWxsYXRpb24gZGVzdGluYXRpb24g
dG8gL2xpYi9tb2R1bGVzLyQodW5hbWUgLXIpL3Zkc28vCj4gZm9yIGNvbnNpc3RlbmN5LgpZZXMs
IGJ1dCBpdCBzaG91bGQgYmUgYW5vdGhlciBwYXRjaC4gVGh4IGZvciB0aGUgY2xhcmlmaWNhdGlv
bi4KClJldmlld2VkLWJ5OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KCj4KPgo+Cj4gLS0K
PiBCZXN0IFJlZ2FyZHMKPiBNYXNhaGlybyBZYW1hZGEKCgoKLS0gCkJlc3QgUmVnYXJkcwogR3Vv
IFJlbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
