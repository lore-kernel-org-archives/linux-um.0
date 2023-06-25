Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01396EB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bxXXgSE0QQieXSH8JB7H4hK3pkekYW5Cg9KDKCF+pH8=; b=D3ertkZ2Hij2+w
	mxJdynoSinOZ87W6theuQjUkPNXWXptYwxY8CHqAk7dq1fxAnTxskPKkROjQNBVJw2ejMrnwmDkl5
	UfuUnawTataaeLwrM/mp9yO3LFGTAjMuGwFwRD62Z8/np/JmAY8NuKVuqfWKkHKoUkLvYm/B27k99
	wzMiMubjVx8UkV2czOMDXNwqGbH53ZCfp2qqXD3sHQgN1FmRYKzHPcTvV0/TcOTgw4Eez9Qe4QK06
	EzaqgBPl2HSWZsZow6uIxM1wt+5scH5n6HBTvLfbK3utcIA/JZInhqlvPXgbRIjPvGTzPAgP5Z/ib
	AI+5BQWylF0rcsue3A+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDLT9-007VWy-0n;
	Sun, 25 Jun 2023 08:51:39 +0000
Received: from mail-yw1-f179.google.com ([209.85.128.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDLT5-007VUZ-0P;
	Sun, 25 Jun 2023 08:51:36 +0000
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5700b15c12fso23298817b3.1;
        Sun, 25 Jun 2023 01:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687683092; x=1690275092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Aydrd9oAz9wF8VtbGA6a+XUUai3n6kkWsRZbAgo9o=;
        b=F2xTkhV1LIHNjt8dA3q+jIrTcvB/EwIHQwqb61bTgUMaBxJaXG/xMB6ivEYFS19mw6
         l5TvBXYiJu6E2uol16dvOmyqeRtP9zeRBlb0UkmZedlhlq3wyrhRSIYoPEeqnUlGNTFj
         8QULpc8aqwhOwN9fHMXT0/FwowwNe1KhoGw2YBbo7jKvV+4/sLmf6e/uJr6YU1NV9P4z
         Gu0w4y/eTI4v/SK9LT0759vHLpfN1QkCogddqAvlSD2f8b5M6p0FQmUmlpGmZftKGcGx
         ycNdSx6+TgTicxmUW6t3jKuM7dr4SRqwCCh7PxzUI3PbmOO0TKu14sZjvD8MRrPcQBX6
         zAag==
X-Gm-Message-State: AC+VfDwqxY6ZwFKF8kLkigF/4/yEh9w/A4V+GgUPaMAh5lctziTDhWjG
	UbJbEEdNY0G5c117qhQV7vtc5bc7u5X1ug==
X-Google-Smtp-Source: ACHHUZ6Ys7UgKzU9+mUw2CYpxk7QkegJrsm4zxKLfx2MR3vJ32Dcz7KoAkURp6iPJkCVOYVvIz/z6A==
X-Received: by 2002:a81:75d6:0:b0:56d:2e22:8b31 with SMTP id q205-20020a8175d6000000b0056d2e228b31mr30081695ywc.41.1687683092405;
        Sun, 25 Jun 2023 01:51:32 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id i18-20020a0ddf12000000b0057328423a05sm729581ywe.80.2023.06.25.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:51:31 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c1061f0c282so1488280276.1;
        Sun, 25 Jun 2023 01:51:30 -0700 (PDT)
X-Received: by 2002:a25:cc02:0:b0:c13:f86d:3324 with SMTP id
 l2-20020a25cc02000000b00c13f86d3324mr3724376ybf.14.1687683090555; Sun, 25 Jun
 2023 01:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230622205745.79707-1-vishal.moola@gmail.com> <20230622205745.79707-25-vishal.moola@gmail.com>
In-Reply-To: <20230622205745.79707-25-vishal.moola@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 Jun 2023 10:51:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2ZM1oJ7=Br6nezLpxjDQo_07N3T-adOupDm0Jntp=Qg@mail.gmail.com>
Message-ID: <CAMuHMdU2ZM1oJ7=Br6nezLpxjDQo_07N3T-adOupDm0Jntp=Qg@mail.gmail.com>
Subject: Re: [PATCH v5 24/33] m68k: Convert various functions to use ptdescs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_015135_169912_C294670C 
X-CRM114-Status: GOOD (  17.48  )
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

SGkgVmlzaGFsLAoKT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMTA6NTjigK9QTSBWaXNoYWwgTW9v
bGEgKE9yYWNsZSkKPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+IEFzIHBhcnQgb2Yg
dGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9y
cyB3aXRoCj4gcHRkZXNjIGVxdWl2YWxlbnRzLCBjb252ZXJ0IHZhcmlvdXMgcGFnZSB0YWJsZSBm
dW5jdGlvbnMgdG8gdXNlIHB0ZGVzY3MuCj4KPiBTb21lIG9mIHRoZSBmdW5jdGlvbnMgdXNlIHRo
ZSAqZ2V0KnBhZ2UqKCkgaGVscGVyIGZ1bmN0aW9ucy4gQ29udmVydAo+IHRoZXNlIHRvIHVzZSBw
YWdldGFibGVfYWxsb2MoKSBhbmQgcHRkZXNjX2FkZHJlc3MoKSBpbnN0ZWFkIHRvIGhlbHAKPiBz
dGFuZGFyZGl6ZSBwYWdlIHRhYmxlcyBmdXJ0aGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogVmlzaGFs
IE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgoKVGhhbmtzIGZvciB5b3Vy
IHBhdGNoIQoKPiAtLS0gYS9hcmNoL202OGsvaW5jbHVkZS9hc20vbWNmX3BnYWxsb2MuaAo+ICsr
KyBiL2FyY2gvbTY4ay9pbmNsdWRlL2FzbS9tY2ZfcGdhbGxvYy5oCgo+ICBzdGF0aWMgaW5saW5l
IHBnZF90ICpwZ2RfYWxsb2Moc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gIHsKPiAgICAgICAgIHBn
ZF90ICpuZXdfcGdkOwo+ICsgICAgICAgc3RydWN0IHB0ZGVzYyAqcHRkZXNjID0gcGFnZXRhYmxl
X2FsbG9jKChHRlBfRE1BIHwgR0ZQX05PV0FSTikgJgoKMC1kYXkgYWxyZWFkeSB0b2xkIHlvdSBm
b3IgdjMgdGhhdCBHRlBfTk9XQVJOIGRvZXMgbm90IGV4aXN0LgpQbGVhc2UgdHJ5IGNyb3NzLWNv
bXBpbGluZyB5b3VyIGNoYW5nZXM6Cmh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5lbC5vcmcvcHVi
L3Rvb2xzL2Nyb3NzdG9vbC8KCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfl9fR0ZQX0hJR0hN
RU0sIDApOwo+Cj4gLSAgICAgICBuZXdfcGdkID0gKHBnZF90ICopX19nZXRfZnJlZV9wYWdlKEdG
UF9ETUEgfCBfX0dGUF9OT1dBUk4pOwo+IC0gICAgICAgaWYgKCFuZXdfcGdkKQo+ICsgICAgICAg
aWYgKCFwdGRlc2MpCj4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICsgICAgICAgbmV3
X3BnZCA9IHB0ZGVzY19hZGRyZXNzKHB0ZGVzYyk7Cj4gKwo+ICAgICAgICAgbWVtY3B5KG5ld19w
Z2QsIHN3YXBwZXJfcGdfZGlyLCBQVFJTX1BFUl9QR0QgKiBzaXplb2YocGdkX3QpKTsKPiAgICAg
ICAgIG1lbXNldChuZXdfcGdkLCAwLCBQQUdFX09GRlNFVCA+PiBQR0RJUl9TSElGVCk7Cj4gICAg
ICAgICByZXR1cm4gbmV3X3BnZDsKCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAg
ICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9m
IExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBj
b252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tl
ci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3Jh
bW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=
