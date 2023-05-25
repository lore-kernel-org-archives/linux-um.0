Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD2FC77B7E
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E3yFVNlOftjanEmYwhJkYOdvltKMbeC2Ram8w6hOv/w=; b=G+z19XeRvzldgX
	frnTyDd0T+ZW/YHUTiM5NZO7WrktwiAoUR2xedeFrSk69qbpRo0ZAbLERxjz444LtXofqrLiaaI7z
	GAUprJJXL52zNAXnGce5TRnC+zzeTiPAraWTjdzcyChOIjXKLfJwNGd0ThTKtlf8Q+C0UVvgdjeh6
	pQvc72i5ODirqo+tSMbYCpOkCvXwbC/ug9OaeW2KC1aqokQOhtLc6FDi+ePzadZT7uFUNAucX+nQN
	GpPHsuYCgXNFIRdqp/g/9GcSzRjMk2fpv4+ELsdcFYQRLxc8kvRBcORdZb/jKvlnzHe+Gt2+uSSLe
	W7amTwFDWKo7IUxSV/dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Hxt-00084s-1g;
	Thu, 25 May 2023 20:53:41 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Hxp-00082Y-0F;
	Thu, 25 May 2023 20:53:38 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565a3cdba71so2881417b3.0;
        Thu, 25 May 2023 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048015; x=1687640015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e72vGCwhPoa8gN25X6qmdDXVUsdWWJFQx8MjqDcoGDA=;
        b=PRDb4uH8g3Vv6gZWsZ1gkHY+ANMWnqtSqEQNi+t68NKJyRAPGtGIjXS+o6ABKHZ7yv
         q51K7Vr8Q1brsvSZQkdt4WeLJo6vXr04Grr6RxGrB/PY5E3pp1cBQWvGni0wb9TWYIbM
         5FWOkPlw4M42rE2TxcMBGldDhB3WLqb55j0CqgwQEW0TmVHxxCeHx2Zs7VLCqGumlN8c
         PmQWTAjBOIMu7fHadjtAjQF7IDQQLa3x/OUyFY2aJiBpGADt0K07OCNxrHer3KqiVV69
         GxawL7cJdKwcX3ZUAGYa8EVBTKoLWza/yXtntrwGkP8KyxHL6U40gF5XovIoxt2V2Fr9
         5Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048015; x=1687640015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e72vGCwhPoa8gN25X6qmdDXVUsdWWJFQx8MjqDcoGDA=;
        b=b8l/qOpblFpeU+kfDhMVN7Xx4Qp1a4U3tAbhuFxdMx8VOb6zJb4C27iwhKwzVpD/m8
         EO/RS1H8F/t2z3zsV37ZeH/YRFSFaAh6S0pk09bKI1JqAY+aHklTrftJz3utaNTXYPxb
         PPRGCDgyDU7JFb5qmacVR7UhKg84pNkswN32kOOPi27VZZ0f+x8jZsbiawP7X0aXIrfS
         y79M/Dn0ag2/mOo6vi8cuyLdPZS4b9j3y1pE3EyyiUwkD+4DHUEaYtx/9vgIrjDhHyZz
         9QuK9R7JpLnBPWemnP3DZxcRqmAnIqTdXmKwfElzaCMtsXTKj58ktrXhk6fWmQCVMe1m
         po2g==
X-Gm-Message-State: AC+VfDxB5XPb7YOwupFmsXYhqgdldBKD1NxdlIOuee7tm7n1J6u1EeNK
	6HUciYUTfJD5otJiZERqEO3r+KjrOiUyDTSs++k=
X-Google-Smtp-Source: ACHHUZ6an6zID91jt8f3LQ4QGAvFJ9u++x53xf0fSCLXe0WivFCmGXJlgIcqvJgo7KICituWVYFJf3qgdSw5/O75Zdg=
X-Received: by 2002:a81:4810:0:b0:55a:84c9:e952 with SMTP id
 v16-20020a814810000000b0055a84c9e952mr1013445ywa.17.1685048014974; Thu, 25
 May 2023 13:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com> <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com> <20230525202537.GA4967@kernel.org>
In-Reply-To: <20230525202537.GA4967@kernel.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 25 May 2023 13:53:24 -0700
Message-ID: <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
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
X-CRM114-CacheID: sfid-20230525_135337_133169_652103B9 
X-CRM114-Status: GOOD (  17.56  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMToyNuKAr1BNIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMTowNDoyOEFNIC0w
NzAwLCBWaXNoYWwgTW9vbGEgd3JvdGU6Cj4gPiBPbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAyOjEw
4oCvQU0gTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gPiArCj4g
PiA+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHB0ZGVzYyAqcHRkZXNjX2FsbG9jKGdmcF90IGdm
cCwgdW5zaWduZWQgaW50IG9yZGVyKQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyAgICAgc3RydWN0IHBh
Z2UgKnBhZ2UgPSBhbGxvY19wYWdlcyhnZnAgfCBfX0dGUF9DT01QLCBvcmRlcik7Cj4gPiA+ID4g
Kwo+ID4gPiA+ICsgICAgIHJldHVybiBwYWdlX3B0ZGVzYyhwYWdlKTsKPiA+ID4gPiArfQo+ID4g
PiA+ICsKPiA+ID4gPiArc3RhdGljIGlubGluZSB2b2lkIHB0ZGVzY19mcmVlKHN0cnVjdCBwdGRl
c2MgKnB0KQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBwdGRl
c2NfcGFnZShwdCk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgIF9fZnJlZV9wYWdlcyhwYWdlLCBj
b21wb3VuZF9vcmRlcihwYWdlKSk7Cj4gPiA+ID4gK30KPiA+ID4KPiA+ID4gVGhlIHB0ZGVzY197
YWxsb2MsZnJlZX0gQVBJIGRvZXMgbm90IHNvdW5kIHJpZ2h0IHRvIG1lLiBUaGUgbmFtZQo+ID4g
PiBwdGRlc2NfYWxsb2MoKSBpbXBsaWVzIHRoZSBhbGxvY2F0aW9uIG9mIHRoZSBwdGRlc2MgaXRz
ZWxmLCByYXRoZXIgdGhhbgo+ID4gPiBhbGxvY2F0aW9uIG9mIHBhZ2UgdGFibGUgcGFnZS4gVGhl
IHNhbWUgZ29lcyBmb3IgZnJlZS4KPiA+Cj4gPiBJJ20gbm90IHN1cmUgSSBzZWUgdGhlIGRpZmZl
cmVuY2UuIENvdWxkIHlvdSBlbGFib3JhdGU/Cj4KPiBJIHJlYWQgcHRkZXNjX2FsbG9jKCkgYXMg
ImFsbG9jYXRlIGEgcHRkZXNjIiByYXRoZXIgdGhhbiBhcyAiYWxsb2NhdGUgYQo+IHBhZ2UgZm9y
IHBhZ2UgdGFibGUgYW5kIHJldHVybiBwdGRlc2MgcG9pbnRpbmcgdG8gdGhhdCBwYWdlIi4gU2Vl
bXMgdmVyeQo+IGNvbmZ1c2luZyB0byBtZSBhbHJlYWR5IGFuZCBpdCB3aWxsIGJlIGV2ZW4gbW9y
ZSBjb25mdXNpb24gd2hlbiB3ZSdsbCBzdGFydAo+IGFsbG9jYXRpbmcgYWN0dWFsIHB0ZGVzY3Mu
CgpIbW0sIEkgc2VlIHdoYXQgeW91J3JlIHNheWluZy4gSSdtIGVudmlzaW9uaW5nIHRoaXMgZnVu
Y3Rpb24gZXZvbHZpbmcgaW50bwpvbmUgdGhhdCBhbGxvY2F0ZXMgYSBwdGRlc2MgbGF0ZXIuIEkg
ZG9uJ3Qgc2VlIHdoeSB3ZSB3b3VsZCBuZWVkIHRvIGhhdmUgYm90aCBhCnBhZ2UgdGFibGUgcGFn
ZSBBTkQgcHRkZXNjIGF0IGFueSBwb2ludCwgYnV0IHRoYXQgbWF5IGJlIGEgbGFjayBvZiBrbm93
bGVkZ2UKZnJvbSBteSBwYXJ0LgoKSSB3YXMgdGhpbmtpbmcgbGF0ZXIsIGlmIG5lY2Vzc2FyeSwg
d2UgY291bGQgbWFrZSBhbm90aGVyIGZ1bmN0aW9uCihvbmx5IHRvIGJlIHVzZWQgaW50ZXJuYWxs
eSkgdG8gYWxsb2NhdGUgcGFnZSB0YWJsZSBwYWdlcy4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K
