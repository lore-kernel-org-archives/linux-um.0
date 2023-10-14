Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115F9CDB465
	for <linux-um@archiver.kernel.org>; Sat, 14 Oct 2023 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmeOOp0NqBLnj6c4WjLhmCSyxhznb8SJOzuX0RxdpXI=; b=3zKNCQ5OJDJo0d
	uWI26o9S3MJ/qoPA0ngIk0XGms+H7BDKtcX6PPQRjee6UruritegGspntHEQ8Lj3YHMRyyS126qaY
	+u/2agKby3InXr68bI8EaFuWDBDutksNAIO94WfGAOn+MmMrf/i9+dXsg13npAbO2B4O7sr7gH5MW
	VtztwNX/mfl7LwG17p2DNLpCIxfSA926g29P8A7FxxAej6p6NQZzzQRzMybBbdNhF0ZpB0p0kqarS
	y+wzxmxJEigrAiZMcc8FDz5WiGoll6VersGKVpJ4SUJ0dlCVSdrp2LBC6iRS9IILQVpCRkYridYT0
	k/Oq5TGHnlp5OFqth/SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qraDp-004zK4-0d;
	Sat, 14 Oct 2023 08:42:09 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qraDl-004zIe-0k;
	Sat, 14 Oct 2023 08:42:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 29827B8094F;
	Sat, 14 Oct 2023 08:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F746C433C8;
	Sat, 14 Oct 2023 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697272921;
	bh=G4Swg/OELkKA5zlwNUrWJdm9EBLT0JpHuSiYFDVKAVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K+yp/KOZHEM3arVfGghtli0iELZWZqeBdZQjVLVWAUiNiyjaLooZNU+qmDCQBd7ul
	 wJaBzeZOVlPFEUG5h5tlObcnYkX0avwfR0zxFXrVQEiQDnBc/Lml9dt/p9dThylmIB
	 6dy7VAWjVXsKM31JLEaZWzS991xED7EXyxYEqup8PHhHUWT6i4XXZP3blNDWD9gE4P
	 HBZnzVjpf+964c0m1gsJz512u75AQxj5sGo0kVtbsfwjz6xNJ/scm1p3BONbVF4ExA
	 K1tnbxCnRJlB0L9unW/GUHbyPmh79PM5kqNhJnIfBbfDsshHj4MN11rBcR3rT09vWo
	 iM+Y47HqeqnfA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e12f41e496so1689243fac.3;
        Sat, 14 Oct 2023 01:42:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzy0uufI7wPONTpg09EElLRflV5MjDibFt0yTytEORLXSTyljdn
	mNDjgD+IzhC4QwxRtW5Fn8RE8PZyk26kL5xDB4Q=
X-Google-Smtp-Source: AGHT+IEDHn8hDctpEgrOdAxDg4ZGS+fyZbcsCWC8+bRNQUrpKMWoTdaHrZNdtFPEOiGiKHQudHJYv6z04ih1iicSLkY=
X-Received: by 2002:a05:6870:7687:b0:1e9:d6c8:d031 with SMTP id
 dx7-20020a056870768700b001e9d6c8d031mr4746345oab.26.1697272921007; Sat, 14
 Oct 2023 01:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-5-masahiroy@kernel.org> <20231009164424.GB1153868@dev-arch.thelio-3990X>
In-Reply-To: <20231009164424.GB1153868@dev-arch.thelio-3990X>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 14 Oct 2023 17:41:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZ78NX13cfGiCeXGxB7A_2CasuAgNv-XzyWM79PD2NwA@mail.gmail.com>
Message-ID: <CAK7LNASZ78NX13cfGiCeXGxB7A_2CasuAgNv-XzyWM79PD2NwA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kbuild: unify no-compiler-targets and no-sync-config-targets
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_014205_568888_05806387 
X-CRM114-Status: GOOD (  15.36  )
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTo0NOKAr0FNIE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRo
YW5Aa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE9jdCAwOSwgMjAyMyBhdCAwOTo0Mjox
MFBNICswOTAwLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6Cj4gPiBOb3cgdGhhdCB2ZHNvX2luc3Rh
bGwgZG9lcyBub3QgZGVwZW5kIG9uIGFueSBpbi10cmVlIGJ1aWxkIGFydGlmYWN0LAo+ID4gaXQg
bm8gbG9uZ2VyIGludm9rZXMgYSBjb21waWxlciwgbWFraW5nIG5vLWNvbXBpbGVyLXRhcmdldHMg
dGhlIHNhbWUKPiA+IGFzIG5vLXN5bmMtY29uZmlnLXRhcmdldHMuCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KPiA+IC0tLQo+ID4K
PiA+ICBNYWtlZmlsZSB8IDEzICstLS0tLS0tLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9NYWtlZmls
ZSBiL01ha2VmaWxlCj4gPiBpbmRleCAyMTcwZDU2NjMwZTguLjk4MmIxYWQzMzI4NyAxMDA2NDQK
PiA+IC0tLSBhL01ha2VmaWxlCj4gPiArKysgYi9NYWtlZmlsZQo+ID4gQEAgLTI3NywxMCArMjc3
LDYgQEAgbm8tZG90LWNvbmZpZy10YXJnZXRzIDo9ICQoY2xlYW4tdGFyZ2V0cykgXAo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAkKHZlcnNpb25faCkgaGVhZGVycyBoZWFkZXJzXyUgYXJjaGhl
YWRlcnMgYXJjaHNjcmlwdHMgXAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAlYXNtLWdlbmVy
aWMga2VybmVsdmVyc2lvbiAlc3JjLXBrZyBkdF9iaW5kaW5nX2NoZWNrIFwKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgb3V0cHV0bWFrZWZpbGUgcnVzdGF2YWlsYWJsZSBydXN0Zm10IHJ1c3Rm
bXRjaGVjawo+ID4gLSMgSW5zdGFsbGF0aW9uIHRhcmdldHMgc2hvdWxkIG5vdCByZXF1aXJlIGNv
bXBpbGVyLiBVbmZvcnR1bmF0ZWx5LCB2ZHNvX2luc3RhbGwKPiA+IC0jIGlzIGFuIGV4Y2VwdGlv
biB3aGVyZSBidWlsZCBhcnRpZmFjdHMgbWF5IGJlIHVwZGF0ZWQuIFRoaXMgbXVzdCBiZSBmaXhl
ZC4KPiA+IC1uby1jb21waWxlci10YXJnZXRzIDo9ICQobm8tZG90LWNvbmZpZy10YXJnZXRzKSBp
bnN0YWxsIGR0YnNfaW5zdGFsbCBcCj4gPiAtICAgICAgICAgICAgICAgICAgICAgaGVhZGVyc19p
bnN0YWxsIG1vZHVsZXNfaW5zdGFsbCBtb2R1bGVzX3NpZ24ga2VybmVscmVsZWFzZSBpbWFnZV9u
YW1lCj4gPiAgbm8tc3luYy1jb25maWctdGFyZ2V0cyA6PSAkKG5vLWRvdC1jb25maWctdGFyZ2V0
cykgJWluc3RhbGwgbW9kdWxlc19zaWduIGtlcm5lbHJlbGVhc2UgXAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgaW1hZ2VfbmFtZQo+ID4gIHNpbmdsZS10YXJnZXRzIDo9ICUuYSAlLmkgJS5r
byAlLmxkcyAlLmxsICUubHN0ICUubW9kICUubyAlLnJzaSAlLnMgJS5zeW10eXBlcyAlLwo+ID4g
QEAgLTI4OCw3ICsyODQsNiBAQCBzaW5nbGUtdGFyZ2V0cyA6PSAlLmEgJS5pICUua28gJS5sZHMg
JS5sbCAlLmxzdCAlLm1vZCAlLm8gJS5yc2kgJS5zICUuc3ltdHlwZXMgJQo+ID4gIGNvbmZpZy1i
dWlsZCA6PQo+ID4gIG1peGVkLWJ1aWxkICA6PQo+ID4gIG5lZWQtY29uZmlnICA6PSAxCj4gPiAt
bmVlZC1jb21waWxlciAgICAgICAgOj0gMQo+ID4gIG1heS1zeW5jLWNvbmZpZyAgICAgIDo9IDEK
PiA+ICBzaW5nbGUtYnVpbGQgOj0KPiA+Cj4gPiBAQCAtMjk4LDEyICsyOTMsNiBAQCBpZm5lcSAo
JChmaWx0ZXIgJChuby1kb3QtY29uZmlnLXRhcmdldHMpLCAkKE1BS0VDTURHT0FMUykpLCkKPiA+
ICAgICAgIGVuZGlmCj4gPiAgZW5kaWYKPiA+Cj4gPiAtaWZuZXEgKCQoZmlsdGVyICQobm8tY29t
cGlsZXItdGFyZ2V0cyksICQoTUFLRUNNREdPQUxTKSksKQo+ID4gLSAgICAgaWZlcSAoJChmaWx0
ZXItb3V0ICQobm8tY29tcGlsZXItdGFyZ2V0cyksICQoTUFLRUNNREdPQUxTKSksKQo+ID4gLSAg
ICAgICAgICAgICBuZWVkLWNvbXBpbGVyIDo9Cj4gPiAtICAgICBlbmRpZgo+ID4gLWVuZGlmCj4g
PiAtCj4KPiBNSVBTIGFuZCBMb29uZ0FyY2ggc2VlbSB0byBoYXZlIGdyb3duIGEgdXNhZ2Ugb2Yg
bmVlZC1jb21waWxlciBpbgo+IDRmZTRhNjM3NGM0ZCAoIk1JUFM6IE9ubHkgZmlkZGxlIHdpdGgg
Q0hFQ0tGTEFHUyBpZiBgbmVlZC1jb21waWxlciciKQo+IGFuZCA1NGMyYzlkZjA4M2YgKCJMb29u
Z0FyY2g6IE9ubHkgZmlkZGxlIHdpdGggQ0hFQ0tGTEFHUyBpZgo+IGBuZWVkLWNvbXBpbGVyJyIp
LiBXaXRoIHRoaXMgcmVtb3ZhbCwgc2hvdWxkIHRob3NlIGJlIHVwZGF0ZWQgYXMgd2VsbD8KCgpS
aWdodCwgYnV0IG1heS1zeW5jLWNvbmZpZyBhbmQgbmVlZC1jb21waWxlciBhcmUgbm90CmludGVy
Y2hhbmdlYWJsZSBkdWUgdG8gdGhlIGZvbGxvd2luZyBjb2RlLgoKaWZuZXEgKCQoS0JVSUxEX0VY
VE1PRCksKQogICAgICAgIG1heS1zeW5jLWNvbmZpZyA6PQplbmRpZgoKCkkgd2lsbCBrZWVwIGJv
dGguCgoKLS0gCkJlc3QgUmVnYXJkcwpNYXNhaGlybyBZYW1hZGEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K
