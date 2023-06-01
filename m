Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71442C7EE23
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w8daIyoTuhzb0iAllQToCUs06YbXPUdlLg0RIT+ReOU=; b=o+uMmEv1fFkkqy
	eZymQ/BzLM4R3optXuFwS3VHUU8drkbFbOIFoUaSuYxCsq2WHU9X8/vJeFa0PvJ2icHGghWFdlYZy
	LyvqiwmHUSVvhfJZJODyvb9SJrV2YOxb2ySHH3gbDyydMlOHCxYN4CZNiuAlFevO8UpDbZa8xKqVU
	9lk8wUa8rUZCt7s38RRo27ngITP2WQQwbRZKq4Vt7qC6g0uD7XkmXwbP0pXFxKxGjTFhjpB+DsBp0
	RMBe72yq9MPJ+YTh+SJhs2J/ajYM33IbvM8novsOQVKASYbZYq5FIkQb/CqLpX960RIypy4QLMaYD
	YW0dK+4lVCHZ11iTtFuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cx9-002P3t-0K;
	Thu, 01 Jun 2023 07:42:35 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cx4-002P0z-1k;
	Thu, 01 Jun 2023 07:42:32 +0000
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f7f864525fso5124511cf.1;
        Thu, 01 Jun 2023 00:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605348; x=1688197348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC4AZRVcHnRKNLMlbDCAYeJz9LlsudAe96MnAggdWqk=;
        b=FRCGazrJkJASeuxX7bcMpKWh7oOtChBcqYmemV0Wyq8b7T0fdc0sruwBwOq7UnGcgj
         qRusIny8RRi4WsSG9VBM+gHraedlwJBHXhwtpE1gAwRlUV13hMMEbqkyDnGlodc4Aa1t
         UQUAYHZ4bPPIh48sCJhm/D821o8r/aEbF/JNVktVrbepk6EksQmAPGwwWTWqbN4ArRYJ
         /sNo8HWTcPvmRWh0tIw96RXl9CwyQgkd+95aayxupyJpvroSzsL1hn+fqqcaEwDZn+oj
         4C7U1q7Ch9FCnrMnczT7QSxNI24ecWoQjloKellXe5BzFxEwKucF/ObrWgZGbfcH4Jy5
         /2GQ==
X-Gm-Message-State: AC+VfDyzCgXLhs8aaBrJwDvTUJ+jyo10UXqiNSj8zZXhM2pIAo2T5K0E
	Io8/omfb+dw6ui/eU8eDgxUzio3SfQX2KA==
X-Google-Smtp-Source: ACHHUZ5CTWytik1++fKtvAg2X0WU1NHSpO+i5TFIWTPgR9ITtneK41G3HuES9GNlSHJFEu+J3dYTOQ==
X-Received: by 2002:ac8:5b06:0:b0:3f6:bffe:3c02 with SMTP id m6-20020ac85b06000000b003f6bffe3c02mr9488302qtw.45.1685605347962;
        Thu, 01 Jun 2023 00:42:27 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id d10-20020ac8534a000000b003e69d6792f6sm7276686qto.45.2023.06.01.00.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:42:25 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-75afeacb5e4so56395385a.3;
        Thu, 01 Jun 2023 00:42:25 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:75b:23a1:3603 with SMTP id
 ea16-20020a05620a489000b0075b23a13603mr8693674qkb.20.1685605345152; Thu, 01
 Jun 2023 00:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Jun 2023 09:42:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Message-ID: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_004230_578980_B0A370E9 
X-CRM114-Status: GOOD (  18.82  )
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

SGkgQWRyaWFuLAoKT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA5OjI44oCvQU0gSm9obiBQYXVsIEFk
cmlhbiBHbGF1Yml0ego8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4gd3JvdGU6Cj4gT24g
VGh1LCAyMDIzLTA2LTAxIGF0IDA5OjIwICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
Cj4gPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAxMTozM+KAr1BNIFZpc2hhbCBNb29sYSAoT3Jh
Y2xlKQo+ID4gPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiBQYXJ0IG9mIHRo
ZSBjb252ZXJzaW9ucyB0byByZXBsYWNlIHBndGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvcnMg
d2l0aAo+ID4gPiBwdGRlc2MgZXF1aXZhbGVudHMuIEFsc28gY2xlYW5zIHVwIHNvbWUgc3BhY2lu
ZyBpc3N1ZXMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xl
KSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+Cj4gPiBMR1RNLCBzbwo+ID4gUmV2aWV3ZWQt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+Cj4KPiBJIGFz
c3VtZSB0aGlzIHNlcmllcyBpcyBzdXBwb3NlZCB0byBnbyB0aHJvdWdoIHNvbWUgbW0gdHJlZT8K
CkkgdGhpbmsgc28sIHNvIHlvdXIgQWNrZWQtYnkgd291bGQgYmUgYXBwcmVjaWF0ZWQuLi4KCkdy
e29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVy
dCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdl
ZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5p
Y2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcg
dG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
