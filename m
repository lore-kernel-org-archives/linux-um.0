Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067ADCD6E64
	for <linux-um@archiver.kernel.org>; Wed, 11 Oct 2023 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d0H6pbOowemXBocWJCeY30cVmZiz5w9SESYgsYZj3jk=; b=mO1+eHGnEN8Oeo
	zV7sdTNP6oMv9wuSXUKZDwyTtHxfF4PgQ3SD5ACe8RgzfIcDkWUIjX6zoF5eUw/FZBUa0tJuPAK/2
	d266yxdQINfp9Y9lHabaoHockbbbtDM5rvtpeIin5AJJvyw0+vSrn+ki4tgkeuY9r0iMlYgOHhCr+
	L6YkuaGqvp4fht8APCkHiP6yo+UOH3dB2G89ZlQYd9ODzziQ8wDA+9lgEOtx2z9AYPFhSoe/WYp2B
	mEnM0+KKKO2A2CktdK3UwHC1Yjc66U7n8J59ZCAMrY507Y9B5Qde9If1VQlS7frkN18EtGG5YCNGg
	kyqnC6vr4nM8DVMGmmyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYiT-00FtVj-0k;
	Wed, 11 Oct 2023 12:53:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYiN-00FtSX-1p;
	Wed, 11 Oct 2023 12:53:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D6CD4B82123;
	Wed, 11 Oct 2023 12:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF7AC43395;
	Wed, 11 Oct 2023 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697028802;
	bh=BAn9cTmPCgYcwvId5a7izdOqRdwYY/SugU+kfhYDqmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ckftw/lZlJbPMA/dzRJmM/VrLm2xFZ2zbn7DGTxWiomWSOVP6zZhFIJ2BNZzOzfmi
	 WNdYzaNnpb0li5MHShlQK3oR77qATwhquIfYtbS2qcxouWrx/tYNXq544lAjKFQDpA
	 Vz9LMECi3pswPXznVM4zmgrfwP36gbWZmEY2zgeCDANjr1COzuPDnQPEfA7i1xQ8p8
	 bSEXGRHusQV4L7Fpb8YmVEuiGDQpTc2IAutv3bYkXEraZvYfx3GpqleFpTlduIcfsH
	 rSwOf/YNc5EZyzIbjBjWlirtlOXEah9MWUIUlTA8o9qnOzmXTT7DWL5nce0eSzTi43
	 DQnyck+GuK7pA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e562706d29so3984925fac.2;
        Wed, 11 Oct 2023 05:53:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzs53W0JFiBfP6xrjW6oQYT+PfXPP+uXISwcehKbuTBUkZGK5iU
	F228EvzmiPqT91z5mq9lR2TyRs1ytuHwUzYy7F0=
X-Google-Smtp-Source: AGHT+IHunqCCf3/TPbLbNP9iC+WACbBVYbi8Ckvhhj1/4uAEKkWSBuHMfzGgLhnmZ11rboJKnGC/Z4MWi+rIZcz3AOo=
X-Received: by 2002:a05:6870:5611:b0:1d1:3a58:14a5 with SMTP id
 m17-20020a056870561100b001d13a5814a5mr26035580oao.25.1697028802212; Wed, 11
 Oct 2023 05:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-4-masahiroy@kernel.org> <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
In-Reply-To: <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 11 Oct 2023 21:52:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
Message-ID: <CAK7LNATmaSXQYFMZEw2vpn6td10+huck-vy-Rbo5Brys+j_Stg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
To: Guo Ren <guoren@kernel.org>
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
X-CRM114-CacheID: sfid-20231011_055327_894299_9688C6B4 
X-CRM114-Status: GOOD (  11.62  )
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

T24gV2VkLCBPY3QgMTEsIDIwMjMgYXQgMTE6MjTigK9BTSBHdW8gUmVuIDxndW9yZW5Aa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDg6NDLigK9QTSBNYXNhaGly
byBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPiB3cm90ZToKCj4gPiAtLS0gYS9hcmNoL3Jp
c2N2L01ha2VmaWxlCj4gPiArKysgYi9hcmNoL3Jpc2N2L01ha2VmaWxlCj4gPiBAQCAtMTMxLDEy
ICsxMzEsNiBAQCBlbmRpZgo+ID4gIGxpYnMteSArPSBhcmNoL3Jpc2N2L2xpYi8KPiA+ICBsaWJz
LSQoQ09ORklHX0VGSV9TVFVCKSArPSAkKG9ianRyZWUpL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvbGliLmEKPiA+Cj4gPiAtUEhPTlkgKz0gdmRzb19pbnN0YWxsCj4gPiAtdmRzb19pbnN0
YWxsOgo+ID4gLSAgICAgICAkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNoL3Jpc2N2L2tlcm5lbC92
ZHNvICRACj4gPiAtICAgICAgICQoaWYgJChDT05GSUdfQ09NUEFUKSwkKFEpJChNQUtFKSBcCj4g
PiAtICAgICAgICAgICAgICAgJChidWlsZCk9YXJjaC9yaXNjdi9rZXJuZWwvY29tcGF0X3Zkc28g
Y29tcGF0XyRAKQo+ID4gLQo+ID4gIGlmZXEgKCQoS0JVSUxEX0VYVE1PRCksKQo+ID4gIGlmZXEg
KCQoQ09ORklHX01NVSkseSkKPiA+ICBwcmVwYXJlOiB2ZHNvX3ByZXBhcmUKPiA+IEBAIC0xNDgs
NiArMTQyLDkgQEAgdmRzb19wcmVwYXJlOiBwcmVwYXJlMAo+ID4gIGVuZGlmCj4gPiAgZW5kaWYK
PiA+Cj4gPiArdmRzby1pbnN0YWxsLXkgICAgICAgICAgICAgICAgICs9IGFyY2gvcmlzY3Yva2Vy
bmVsL3Zkc28vdmRzby5zby5kYmcKPiA+ICt2ZHNvLWluc3RhbGwtJChDT05GSUdfQ09NUEFUKSAg
Kz0gYXJjaC9yaXNjdi9rZXJuZWwvY29tcGF0X3Zkc28vY29tcGF0X3Zkc28uc28uZGJnOi4uL2Nv
bXBhdF92ZHNvL2NvbXBhdF92ZHNvLnNvCj4gV2h5IGRvIHdlIG5lZWQgIjouLi9jb21wYXRfdmRz
by9jb21wYXRfdmRzby5zbyIgaGVyZT8KCgoKCkFsbCBhcmNoaXRlY3R1cmVzIGV4Y2VwdCByaXNj
diBpbnN0YWxsIHZkc28gZmlsZXMKdG8gL2xpYi9tb2R1bGVzLyQodW5hbWUgLXIpL3Zkc28vLgoK
CgpTZWUgdGhlIGZvbGxvd2luZyBjb2RlIGluIGFyY2gvcmlzY3Yva2VybmVsL2NvbXBhdF92ZHNv
L01ha2VmaWxlOgoKCnF1aWV0X2NtZF9jb21wYXRfdmRzb19pbnN0YWxsID0gSU5TVEFMTCAkQAog
ICAgICBjbWRfY29tcGF0X3Zkc29faW5zdGFsbCA9IGNwICQob2JqKS8kQC5kYmcgJChNT0RMSUIp
L2NvbXBhdF92ZHNvLyRACgoKCgpSaXNjdiBjb3BpZXMgdGhlIGNvbXBhdCB2ZHNvIHRvCi9saWIv
bW9kdWxlcy8kKHVuYW1lIC1yKS9jb21wYXRfdmRzby8uCgoKClRoaXMgY29tbWl0IHByZXNlcnZl
cyB0aGUgY3VycmVudCBpbnN0YWxsYXRpb24gcGF0aCBhcy1pcy4KCklmIHRoZSByaXNjdiBtYWlu
dGFpbmVycyBhZ3JlZSwgd2UgY2FuIGNoYW5nZSB0aGUKaW5zdGFsbGF0aW9uIGRlc3RpbmF0aW9u
IHRvIC9saWIvbW9kdWxlcy8kKHVuYW1lIC1yKS92ZHNvLwpmb3IgY29uc2lzdGVuY3kuCgoKCi0t
IApCZXN0IFJlZ2FyZHMKTWFzYWhpcm8gWWFtYWRhCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
