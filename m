Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253EDC7EE3A
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3NQB0LaMOuOLSsjswwsVjVaFmxh6KgfrT2IeZttHzzQ=; b=2ahiuWyi7tBKvo
	JGYApk8I9KuyOFwXAzTswAua0zom5JBua52ruItLkMs2k5YnsdTgJQXCGUp6HBDECc0mgDh6rs0Fk
	cf2b5FHxHyNPDdTUYiCnSmkE3nUUkH2eZQP9ed7MUqvxu1T3903DNgMjhk3HfdibooYQVsxmVoHdT
	U9J0noxpCocrqLb4YsDv8y/mhmQvJCMDJufFfLCmOu/i/IJx3cMPWeUUTmUN7AwrDXsspey1wQpGg
	Jo3Qvhpt8E4ygpokcDnNeVshCSENiilqmzHa8BpvWoObvojQQPw8EtYDz03Q4Xt/xMwd7hFMN7fJK
	a27hGFgMsIpFjfpYY9lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FWk-00HMhM-20;
	Thu, 25 May 2023 18:17:30 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FWg-00HMg0-0f;
	Thu, 25 May 2023 18:17:27 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba6d024a196so764574276.2;
        Thu, 25 May 2023 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038645; x=1687630645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEt/V8+3jpKdaWf/91twz9m1AxbB8mw1sieW7q1FOX4=;
        b=qpx33W23LxzGgtt7x0f+jHNiqnq/vW7f+lo4R60odkrqHHbvAvDFwCToA7ZeGOtlZu
         1pix82nq+XRaSlrOoV5XSSn7dUtYbrVRPJSVcc+Y0QUEIud/VeliblGAWTefKuC3uiLW
         Y767SW9acPu7TamxQ3rDZ7ad1waallUvH2KGWMSoPdMgQ6uqByETyo++E8JgCnYWaIR7
         T+3+xQi6fbJlgvqxHEFBxTPhg1oh030qaBtpvB360U8uoO6SqTXFxFoolc38s3Jd+HWF
         qSuZfJvCEliq2Q2QxhelaN+CYntsdlTkVUzhuGY+pHQjjIlm9D34YIwBuMF1/x8S1rOB
         qR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038645; x=1687630645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEt/V8+3jpKdaWf/91twz9m1AxbB8mw1sieW7q1FOX4=;
        b=FmuVpxU1W5JJQAVLN7tgXz71MkO8inbgI5D4eH/NcLG+v/Ke/OxrfqdhM4zG6oc4I1
         DFbdh9el44eI9uBrsNTpPLMTknR/TTBGt353RKOjl3XbvrQDNOi7ITrLDZ8UrOH+cnPA
         j9Wsc4eSpw0ydnPRbE1D86U3cpVPZfFLxlLw3WMluVcT9pQ5DYXITv+QiUMRuawGEAlu
         MULtpcL2PvLvGiaunUt622I4m4nrUibKmqTR7v6+Bv14KuwUsQ3TSMtxcyUhrLixWRmJ
         fi2mpsjoqjTe9zJPbaWVcnNVEOp+g9GgMVHpn6VKU9kgUu7uURtqq4rbLqLBbzctPlWm
         I+0A==
X-Gm-Message-State: AC+VfDwOX4jyOLV1bGmGN+affQBf8I54+2Nlg72ZIou76TS/VWZv71DD
	lsi+56+YFmKhVs64iYWeKzogQLHEB9OS0PMubxk=
X-Google-Smtp-Source: ACHHUZ4CxdCafEVA2N8+YE3r54vbJuyNv4iSvWQn7ibpFdu7Q8YcRob13nPjv7XKdbKB6AoaGk0hrDu/6J2TDu7u8Qo=
X-Received: by 2002:a25:ac6:0:b0:ba7:bb4c:7960 with SMTP id
 189-20020a250ac6000000b00ba7bb4c7960mr4320550ybk.26.1685038645132; Thu, 25
 May 2023 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-14-vishal.moola@gmail.com> <20230525091900.GY4967@kernel.org>
In-Reply-To: <20230525091900.GY4967@kernel.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 25 May 2023 11:17:14 -0700
Message-ID: <CAOzc2pxNRbohxxNnaKtBNOBgOschHMj278-6hWZK9A1oJOgujA@mail.gmail.com>
Subject: Re: [PATCH v2 13/34] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_111726_243452_0B2C94C8 
X-CRM114-Status: GOOD (  19.09  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMjoxOeKAr0FNIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE1heSAwMSwgMjAyMyBhdCAxMjoyODowOFBNIC0w
NzAwLCBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4gPiBDcmVhdGVzIHB0ZGVzY19wdGVf
Y3RvcigpLCBwdGRlc2NfcG1kX2N0b3IoKSwgcHRkZXNjX3B0ZV9kdG9yKCksIGFuZAo+ID4gcHRk
ZXNjX3BtZF9kdG9yKCkgYW5kIG1ha2UgdGhlIG9yaWdpbmFsIHBndGFibGUgY29uc3RydWN0b3Iv
ZGVzdHJ1Y3RvcnMKPiA+IHdyYXBwZXJzLgo+Cj4gSSB0aGluayBwZ3RhYmxlX3BYWV9jdG9yL2R0
b3IgbmFtZXMgd291bGQgYmUgYmV0dGVyLgoKSSBoYXZlIGl0IGFzIHB0ZGVzYyB0byBrZWVwIGl0
IGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZnVuY3Rpb25zLiBJCmFsc28gdGhpbmsg
aXQgbWFrZXMgbW9yZSBzZW5zZSBhcyBpdCdzIGluaXRpYWxpemluZyBzdHVmZiB0cmFja2VkIGJ5
IGEgcHRkZXNjLgoKPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xlKSA8dmlz
aGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGluY2x1ZGUvbGludXgvbW0uaCB8IDU2
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaAo+ID4gaW5k
ZXggNThjOTExMzQxYTMzLi5kYzYxYWVjYTkwNzcgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L21tLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaAo+ID4gQEAgLTI4NDcsMjAgKzI4
NDcsMzQgQEAgc3RhdGljIGlubGluZSBib29sIHB0bG9ja19pbml0KHN0cnVjdCBwdGRlc2MgKnB0
ZGVzYykgeyByZXR1cm4gdHJ1ZTsgfQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBwdGxvY2tfZnJl
ZShzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpIHt9Cj4gPiAgI2VuZGlmIC8qIFVTRV9TUExJVF9QVEVf
UFRMT0NLUyAqLwo+ID4KPiA+IC1zdGF0aWMgaW5saW5lIGJvb2wgcGd0YWJsZV9wdGVfcGFnZV9j
dG9yKHN0cnVjdCBwYWdlICpwYWdlKQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBwdGRlc2NfcHRl
X2N0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQo+ID4gIHsKPiA+IC0gICAgIGlmICghcHRsb2Nr
X2luaXQocGFnZV9wdGRlc2MocGFnZSkpKQo+ID4gKyAgICAgc3RydWN0IGZvbGlvICpmb2xpbyA9
IHB0ZGVzY19mb2xpbyhwdGRlc2MpOwo+ID4gKwo+ID4gKyAgICAgaWYgKCFwdGxvY2tfaW5pdChw
dGRlc2MpKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiAtICAgICBfX1NldFBh
Z2VUYWJsZShwYWdlKTsKPiA+IC0gICAgIGluY19scnV2ZWNfcGFnZV9zdGF0ZShwYWdlLCBOUl9Q
QUdFVEFCTEUpOwo+ID4gKyAgICAgX19mb2xpb19zZXRfdGFibGUoZm9saW8pOwo+ID4gKyAgICAg
bHJ1dmVjX3N0YXRfYWRkX2ZvbGlvKGZvbGlvLCBOUl9QQUdFVEFCTEUpOwo+ID4gICAgICAgcmV0
dXJuIHRydWU7Cj4gPiAgfQo+ID4KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgcGd0YWJsZV9wdGVf
cGFnZV9jdG9yKHN0cnVjdCBwYWdlICpwYWdlKQo+ID4gK3sKPiA+ICsgICAgIHJldHVybiBwdGRl
c2NfcHRlX2N0b3IocGFnZV9wdGRlc2MocGFnZSkpOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMg
aW5saW5lIHZvaWQgcHRkZXNjX3B0ZV9kdG9yKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykKPiA+ICt7
Cj4gPiArICAgICBzdHJ1Y3QgZm9saW8gKmZvbGlvID0gcHRkZXNjX2ZvbGlvKHB0ZGVzYyk7Cj4g
PiArCj4gPiArICAgICBwdGxvY2tfZnJlZShwdGRlc2MpOwo+ID4gKyAgICAgX19mb2xpb19jbGVh
cl90YWJsZShmb2xpbyk7Cj4gPiArICAgICBscnV2ZWNfc3RhdF9zdWJfZm9saW8oZm9saW8sIE5S
X1BBR0VUQUJMRSk7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBwZ3RhYmxl
X3B0ZV9wYWdlX2R0b3Ioc3RydWN0IHBhZ2UgKnBhZ2UpCj4gPiAgewo+ID4gLSAgICAgcHRsb2Nr
X2ZyZWUocGFnZV9wdGRlc2MocGFnZSkpOwo+ID4gLSAgICAgX19DbGVhclBhZ2VUYWJsZShwYWdl
KTsKPiA+IC0gICAgIGRlY19scnV2ZWNfcGFnZV9zdGF0ZShwYWdlLCBOUl9QQUdFVEFCTEUpOwo+
ID4gKyAgICAgcHRkZXNjX3B0ZV9kdG9yKHBhZ2VfcHRkZXNjKHBhZ2UpKTsKPiA+ICB9Cj4gPgo+
ID4gICNkZWZpbmUgcHRlX29mZnNldF9tYXBfbG9jayhtbSwgcG1kLCBhZGRyZXNzLCBwdGxwKSAg
XAo+ID4gQEAgLTI5NDIsMjAgKzI5NTYsMzQgQEAgc3RhdGljIGlubGluZSBzcGlubG9ja190ICpw
bWRfbG9jayhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcG1kX3QgKnBtZCkKPiA+ICAgICAgIHJldHVy
biBwdGw7Cj4gPiAgfQo+ID4KPiA+IC1zdGF0aWMgaW5saW5lIGJvb2wgcGd0YWJsZV9wbWRfcGFn
ZV9jdG9yKHN0cnVjdCBwYWdlICpwYWdlKQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBwdGRlc2Nf
cG1kX2N0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQo+ID4gIHsKPiA+IC0gICAgIGlmICghcG1k
X3B0bG9ja19pbml0KHBhZ2VfcHRkZXNjKHBhZ2UpKSkKPiA+ICsgICAgIHN0cnVjdCBmb2xpbyAq
Zm9saW8gPSBwdGRlc2NfZm9saW8ocHRkZXNjKTsKPiA+ICsKPiA+ICsgICAgIGlmICghcG1kX3B0
bG9ja19pbml0KHB0ZGVzYykpCj4gPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+IC0g
ICAgIF9fU2V0UGFnZVRhYmxlKHBhZ2UpOwo+ID4gLSAgICAgaW5jX2xydXZlY19wYWdlX3N0YXRl
KHBhZ2UsIE5SX1BBR0VUQUJMRSk7Cj4gPiArICAgICBfX2ZvbGlvX3NldF90YWJsZShmb2xpbyk7
Cj4gPiArICAgICBscnV2ZWNfc3RhdF9hZGRfZm9saW8oZm9saW8sIE5SX1BBR0VUQUJMRSk7Cj4g
PiAgICAgICByZXR1cm4gdHJ1ZTsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBw
Z3RhYmxlX3BtZF9wYWdlX2N0b3Ioc3RydWN0IHBhZ2UgKnBhZ2UpCj4gPiArewo+ID4gKyAgICAg
cmV0dXJuIHB0ZGVzY19wbWRfY3RvcihwYWdlX3B0ZGVzYyhwYWdlKSk7Cj4gPiArfQo+ID4gKwo+
ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwdGRlc2NfcG1kX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRk
ZXNjKQo+ID4gK3sKPiA+ICsgICAgIHN0cnVjdCBmb2xpbyAqZm9saW8gPSBwdGRlc2NfZm9saW8o
cHRkZXNjKTsKPiA+ICsKPiA+ICsgICAgIHBtZF9wdGxvY2tfZnJlZShwdGRlc2MpOwo+ID4gKyAg
ICAgX19mb2xpb19jbGVhcl90YWJsZShmb2xpbyk7Cj4gPiArICAgICBscnV2ZWNfc3RhdF9zdWJf
Zm9saW8oZm9saW8sIE5SX1BBR0VUQUJMRSk7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyBpbmxp
bmUgdm9pZCBwZ3RhYmxlX3BtZF9wYWdlX2R0b3Ioc3RydWN0IHBhZ2UgKnBhZ2UpCj4gPiAgewo+
ID4gLSAgICAgcG1kX3B0bG9ja19mcmVlKHBhZ2VfcHRkZXNjKHBhZ2UpKTsKPiA+IC0gICAgIF9f
Q2xlYXJQYWdlVGFibGUocGFnZSk7Cj4gPiAtICAgICBkZWNfbHJ1dmVjX3BhZ2Vfc3RhdGUocGFn
ZSwgTlJfUEFHRVRBQkxFKTsKPiA+ICsgICAgIHB0ZGVzY19wbWRfZHRvcihwYWdlX3B0ZGVzYyhw
YWdlKSk7Cj4gPiAgfQo+ID4KPiA+ICAvKgo+ID4gLS0KPiA+IDIuMzkuMgo+ID4KPiA+Cj4KPiAt
LQo+IFNpbmNlcmVseSB5b3VycywKPiBNaWtlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=
