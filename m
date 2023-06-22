Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0397EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Pw9njrTf4cRLZhSWTKEoQ7kGWArZBIe/4AT7lyobEg=; b=GzyVnmRUXzTp3u
	p1TWTLbXNxSwNkMzDIQkuXTVmS5rHcZ4fhRFOKZ7tJdNuKgs7eLMofkzVBNQKyjSgXXipQb9O1jdu
	CDKz9JGSyOxXMbW4gUWTfTd2xEHCmcBbsZfKGX/m01cXpRU47ryrEWNGNPjn+yx2GrGqeupXTkJ4G
	Cf/lNWqppNEXnnf7eFMLZLqNVPiA2NWeKt8d+wLiUAwG/xzlYvRLlLd07DfD3+sOv0t7Tmb/4Bynv
	b6bfFtW2D2kOJMftWkdaIlLjELF505zTCBPE/rM8MIKXbkG6YbAD/YORNd1/vsm0F6L9OUWYu4fFL
	QeGl81xDyGejgki0+elw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRSR-001mQ9-1E;
	Thu, 22 Jun 2023 21:03:11 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROU-001ich-0r;
	Thu, 22 Jun 2023 20:59:11 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bff27026cb0so2083838276.1;
        Thu, 22 Jun 2023 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467545; x=1690059545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UurGuuLzED1CKQ5+YtAa+uldlNlkULcrhOlEPtYgkts=;
        b=oQo8Ww3rkcQ6O4ERZYbbm7gIN+KUZJBSX76Jt+A0yqxzuaw5csFJ7AbMPXoNar1y+V
         tZQraeqybmf35Qo5xoKl1awKHEBN/Nxr+iHHL+iOhynJPYAD9oID72CJXajJ9Jf7DkVt
         j26rlavSXJqsTv4JH9m0aLFnC9iK42GCsz7JUCHqTbiCOXGPKTX89JvhbmgJctDtXiKK
         TITKlfKlRxN76qLZH8F23nvkVHDCJrlE7Pe9NREUl+WlgOK0PObb86E20s865la+XsRl
         r0ny/7zkkdzJjzv/4f5M4RYeUYdlHDKmxWEXxa021UXcBJ73jIQME8NWHlpzSqT6M39a
         D91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467545; x=1690059545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UurGuuLzED1CKQ5+YtAa+uldlNlkULcrhOlEPtYgkts=;
        b=XokR0x/jxtaK+2Ry6os+evUvn+pwvbv0Wg7JMrG/9HffaV5bz6fi7i0VZ5shtnFahi
         8O1PIo9/gHiqEmCAmxjikShby7bDtLf+8fwVadSvL88JMoZRYxr3Osm2bjKDoVko3w1G
         IAzGHApv1D0MwZ0pJeQ5rB1MDvXSEzcWOo3wNln3JYoKjN5ICPmVfvNZ4190Leqx7doj
         uiT3oTXDe1B3DZoqyg7x6Zo1wFEwg6aPFdYV1Hqh+NYY7XrjbXrG8Hh8NtIwAkdHYD59
         ZATZC6YMDpW8EWIZgfnGmbgTPpWQ4gqfbU4QswhVu5pDVBoTNR5f//v5pJRtkwRlBvp3
         kbNw==
X-Gm-Message-State: AC+VfDyfRDI84TAWYsHaeFV6jEQp8y6zOiKZwTOuvn7AC2sowUUXQRXc
	PrSrCm9lXwlfA668VoHL+Fs=
X-Google-Smtp-Source: ACHHUZ5/16pTE8w+KmQXtTEHVbvOJ9pX8CyeEgbjUI2ZBq46DEtB7j98e4dbCDGlFjYL7Uz7mrOclw==
X-Received: by 2002:a25:d707:0:b0:bca:9c66:e53b with SMTP id o7-20020a25d707000000b00bca9c66e53bmr16719019ybg.14.1687467545228;
        Thu, 22 Jun 2023 13:59:05 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:59:04 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 33/33] mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers
Date: Thu, 22 Jun 2023 13:57:45 -0700
Message-Id: <20230622205745.79707-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135906_377030_BCDE8AE4 
X-CRM114-Status: GOOD (  11.55  )
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

VGhlc2UgZnVuY3Rpb25zIGFyZSBubyBsb25nZXIgbmVjZXNzYXJ5LiBSZW1vdmUgdGhlbSBhbmQg
Y2xlYW51cApEb2N1bWVudGF0aW9uIHJlZmVyZW5jaW5nIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBW
aXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+CkFja2VkLWJ5OiBN
aWtlIFJhcG9wb3J0IChJQk0pIDxycHB0QGtlcm5lbC5vcmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9t
bS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0ICAgIHwgMTIgKysrKystLS0tLS0KIC4uLi96aF9D
Ti9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0ICAgICAgICB8IDE0ICsrKysrKy0tLS0tLS0K
IGluY2x1ZGUvbGludXgvbW0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIwIC0tLS0t
LS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMzMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9tbS9zcGxpdF9wYWdlX3RhYmxl
X2xvY2sucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0Cmlu
ZGV4IGE4MzRmYWQ5ZGUxMi4uZTRmNjk3MmViNmMwIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9u
L21tL3NwbGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9zcGxp
dF9wYWdlX3RhYmxlX2xvY2sucnN0CkBAIC01OCw3ICs1OCw3IEBAIFN1cHBvcnQgb2Ygc3BsaXQg
cGFnZSB0YWJsZSBsb2NrIGJ5IGFuIGFyY2hpdGVjdHVyZQogPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAKIFRoZXJlJ3Mgbm8gbmVlZCBpbiBzcGVj
aWFsIGVuYWJsaW5nIG9mIFBURSBzcGxpdCBwYWdlIHRhYmxlIGxvY2s6IGV2ZXJ5dGhpbmcKLXJl
cXVpcmVkIGlzIGRvbmUgYnkgcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgYW5kIHBndGFibGVfcHRl
X3BhZ2VfZHRvcigpLCB3aGljaAorcmVxdWlyZWQgaXMgZG9uZSBieSBwYWdldGFibGVfcHRlX2N0
b3IoKSBhbmQgcGFnZXRhYmxlX3B0ZV9kdG9yKCksIHdoaWNoCiBtdXN0IGJlIGNhbGxlZCBvbiBQ
VEUgdGFibGUgYWxsb2NhdGlvbiAvIGZyZWVpbmcuCiAKIE1ha2Ugc3VyZSB0aGUgYXJjaGl0ZWN0
dXJlIGRvZXNuJ3QgdXNlIHNsYWIgYWxsb2NhdG9yIGZvciBwYWdlIHRhYmxlCkBAIC02OCw4ICs2
OCw4IEBAIFRoaXMgZmllbGQgc2hhcmVzIHN0b3JhZ2Ugd2l0aCBwYWdlLT5wdGwuCiBQTUQgc3Bs
aXQgbG9jayBvbmx5IG1ha2VzIHNlbnNlIGlmIHlvdSBoYXZlIG1vcmUgdGhhbiB0d28gcGFnZSB0
YWJsZQogbGV2ZWxzLgogCi1QTUQgc3BsaXQgbG9jayBlbmFibGluZyByZXF1aXJlcyBwZ3RhYmxl
X3BtZF9wYWdlX2N0b3IoKSBjYWxsIG9uIFBNRCB0YWJsZQotYWxsb2NhdGlvbiBhbmQgcGd0YWJs
ZV9wbWRfcGFnZV9kdG9yKCkgb24gZnJlZWluZy4KK1BNRCBzcGxpdCBsb2NrIGVuYWJsaW5nIHJl
cXVpcmVzIHBhZ2V0YWJsZV9wbWRfY3RvcigpIGNhbGwgb24gUE1EIHRhYmxlCithbGxvY2F0aW9u
IGFuZCBwYWdldGFibGVfcG1kX2R0b3IoKSBvbiBmcmVlaW5nLgogCiBBbGxvY2F0aW9uIHVzdWFs
bHkgaGFwcGVucyBpbiBwbWRfYWxsb2Nfb25lKCksIGZyZWVpbmcgaW4gcG1kX2ZyZWUoKSBhbmQK
IHBtZF9mcmVlX3RsYigpLCBidXQgbWFrZSBzdXJlIHlvdSBjb3ZlciBhbGwgUE1EIHRhYmxlIGFs
bG9jYXRpb24gLyBmcmVlaW5nCkBAIC03Nyw3ICs3Nyw3IEBAIHBhdGhzOiBpLmUgWDg2X1BBRSBw
cmVhbGxvY2F0ZSBmZXcgUE1EcyBvbiBwZ2RfYWxsb2MoKS4KIAogV2l0aCBldmVyeXRoaW5nIGlu
IHBsYWNlIHlvdSBjYW4gc2V0IENPTkZJR19BUkNIX0VOQUJMRV9TUExJVF9QTURfUFRMT0NLLgog
Ci1OT1RFOiBwZ3RhYmxlX3B0ZV9wYWdlX2N0b3IoKSBhbmQgcGd0YWJsZV9wbWRfcGFnZV9jdG9y
KCkgY2FuIGZhaWwgLS0gaXQgbXVzdAorTk9URTogcGFnZXRhYmxlX3B0ZV9jdG9yKCkgYW5kIHBh
Z2V0YWJsZV9wbWRfY3RvcigpIGNhbiBmYWlsIC0tIGl0IG11c3QKIGJlIGhhbmRsZWQgcHJvcGVy
bHkuCiAKIHBhZ2UtPnB0bApAQCAtOTcsNyArOTcsNyBAQCB0cmljazoKICAgIHNwbGl0IGxvY2sg
d2l0aCBlbmFibGVkIERFQlVHX1NQSU5MT0NLIG9yIERFQlVHX0xPQ0tfQUxMT0MsIGJ1dCBjb3N0
cwogICAgb25lIG1vcmUgY2FjaGUgbGluZSBmb3IgaW5kaXJlY3QgYWNjZXNzOwogCi1UaGUgc3Bp
bmxvY2tfdCBhbGxvY2F0ZWQgaW4gcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgZm9yIFBURSB0YWJs
ZSBhbmQgaW4KLXBndGFibGVfcG1kX3BhZ2VfY3RvcigpIGZvciBQTUQgdGFibGUuCitUaGUgc3Bp
bmxvY2tfdCBhbGxvY2F0ZWQgaW4gcGFnZXRhYmxlX3B0ZV9jdG9yKCkgZm9yIFBURSB0YWJsZSBh
bmQgaW4KK3BhZ2V0YWJsZV9wbWRfY3RvcigpIGZvciBQTUQgdGFibGUuCiAKIFBsZWFzZSwgbmV2
ZXIgYWNjZXNzIHBhZ2UtPnB0bCBkaXJlY3RseSAtLSB1c2UgYXBwcm9wcmlhdGUgaGVscGVyLgpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0vc3BsaXRfcGFn
ZV90YWJsZV9sb2NrLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL21tL3Nw
bGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKaW5kZXggNGZiN2FhNjY2MDM3Li5hMmMyODg2NzBhMjQg
MTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL21tL3NwbGl0X3Bh
Z2VfdGFibGVfbG9jay5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04v
bW0vc3BsaXRfcGFnZV90YWJsZV9sb2NrLnJzdApAQCAtNTYsMTYgKzU2LDE2IEBAIEh1Z2V0bGLn
ibnlrprnmoTovoXliqnlh73mlbA6CiDmnrbmnoTlr7nliIbpobXooajplIHnmoTmlK/mjIEKID09
PT09PT09PT09PT09PT09PT09CiAKLeayoeacieW/heimgeeJueWIq+WQr+eUqFBUReWIhumhteih
qOmUge+8muaJgOaciemcgOimgeeahOS4nOilv+mDveeUsXBndGFibGVfcHRlX3BhZ2VfY3Rvcigp
Ci3lkoxwZ3RhYmxlX3B0ZV9wYWdlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/hemhu+WcqFBUReih
qOWIhumFjS/ph4rmlL7ml7booqvosIPnlKjjgIIKK+ayoeacieW/heimgeeJueWIq+WQr+eUqFBU
ReWIhumhteihqOmUge+8muaJgOaciemcgOimgeeahOS4nOilv+mDveeUsXBhZ2V0YWJsZV9wdGVf
Y3RvcigpCivlkoxwYWdldGFibGVfcHRlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/hemhu+WcqFBU
ReihqOWIhumFjS/ph4rmlL7ml7booqvosIPnlKjjgIIKIAog56Gu5L+d5p625p6E5LiN5L2/55So
c2xhYuWIhumFjeWZqOadpeWIhumFjemhteihqO+8mnNsYWLkvb/nlKhwYWdlLT5zbGFiX2NhY2hl
5p2l5YiG6YWN5YW26aG1CiDpnaLjgILov5nkuKrljLrln5/kuI5wYWdlLT5wdGzlhbHkuqvlrZjl
gqjjgIIKIAogUE1E5YiG6aG16ZSB5Y+q5pyJ5Zyo5L2g5pyJ5Lik5Liq5Lul5LiK55qE6aG16KGo
57qn5Yir5pe25omN5pyJ5oSP5LmJ44CCCiAKLeWQr+eUqFBNROWIhumhtemUgemcgOimgeWcqFBN
ROihqOWIhumFjeaXtuiwg+eUqHBndGFibGVfcG1kX3BhZ2VfY3Rvcigp77yM5Zyo6YeK5pS+5pe2
6LCDCi3nlKhwZ3RhYmxlX3BtZF9wYWdlX2R0b3IoKeOAggor5ZCv55SoUE1E5YiG6aG16ZSB6ZyA
6KaB5ZyoUE1E6KGo5YiG6YWN5pe26LCD55SocGFnZXRhYmxlX3BtZF9jdG9yKCnvvIzlnKjph4rm
lL7ml7bosIMKK+eUqHBhZ2V0YWJsZV9wbWRfZHRvcigp44CCCiAKIOWIhumFjemAmuW4uOWPkeeU
n+WcqHBtZF9hbGxvY19vbmUoKeS4re+8jOmHiuaUvuWPkeeUn+WcqHBtZF9mcmVlKCnlkoxwbWRf
ZnJlZV90bGIoKQog5Lit77yM5L2G6KaB56Gu5L+d6KaG55uW5omA5pyJ55qEUE1E6KGo5YiG6YWN
L+mHiuaUvui3r+W+hO+8muWNs1g4Nl9QQUXlnKhwZ2RfYWxsb2MoKeS4remihOWFiApAQCAtNzMs
NyArNzMsNyBAQCBQTUTliIbpobXplIHlj6rmnInlnKjkvaDmnInkuKTkuKrku6XkuIrnmoTpobXo
oajnuqfliKvml7bmiY3mnInmhI/kuYnjgIIKIAog5LiA5YiH5bCx57uq5ZCO77yM5L2g5Y+v5Lul
6K6+572uQ09ORklHX0FSQ0hfRU5BQkxFX1NQTElUX1BNRF9QVExPQ0vjgIIKIAot5rOo5oSP77ya
cGd0YWJsZV9wdGVfcGFnZV9jdG9yKCnlkoxwZ3RhYmxlX3BtZF9wYWdlX2N0b3IoKeWPr+iDveWk
sei0pS0t5b+FCivms6jmhI/vvJpwYWdldGFibGVfcHRlX2N0b3IoKeWSjHBhZ2V0YWJsZV9wbWRf
Y3Rvcigp5Y+v6IO95aSx6LSlLS3lv4UKIOmhu+ato+ehruWkhOeQhuOAggogCiBwYWdlLT5wdGwK
QEAgLTkwLDcgKzkwLDcgQEAgcGFnZS0+cHRs55So5LqO6K6/6Zeu5YiG5Ymy6aG16KGo6ZSB77yM
5YW25LitJ3BhZ2Un5piv5YyF5ZCr6K+l6KGo55qE6aG16Z2ic3RydWMKICAgIOeahOaMh+mSiOW5
tuWKqOaAgeWIhumFjeWug+OAgui/meWFgeiuuOWcqOWQr+eUqERFQlVHX1NQSU5MT0NL5oiWREVC
VUdfTE9DS19BTExPQ+eahAogICAg5oOF5Ya15LiL5L2/55So5YiG6aG16ZSB77yM5L2G55Sx5LqO
6Ze05o6l6K6/6Zeu6ICM5aSa6Iqx5LqG5LiA5Liq57yT5a2Y6KGM44CCCiAKLVBUReihqOeahHNw
aW5sb2NrX3TliIbphY3lnKhwZ3RhYmxlX3B0ZV9wYWdlX2N0b3IoKeS4re+8jFBNROihqOeahHNw
aW5sb2NrX3QKLeWIhumFjeWcqHBndGFibGVfcG1kX3BhZ2VfY3Rvcigp5Lit44CCCitQVEXooajn
moRzcGlubG9ja1905YiG6YWN5ZyocGFnZXRhYmxlX3B0ZV9jdG9yKCnkuK3vvIxQTUTooajnmoRz
cGlubG9ja190CivliIbphY3lnKhwYWdldGFibGVfcG1kX2N0b3IoKeS4reOAggogCiDor7fkuI3o
poHnm7TmjqXorr/pl65wYWdlLT5wdGwgLSAt5L2/55So6YCC5b2T55qE6L6F5Yqp5Ye95pWw44CC
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgKaW5k
ZXggMGU0ZDVmNmQxMGU1Li5kYzBmMTlmMzU0MjQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
bW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21tLmgKQEAgLTI4NzMsMTEgKzI4NzMsNiBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgcGFnZXRhYmxlX3B0ZV9jdG9yKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykK
IAlyZXR1cm4gdHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIHBndGFibGVfcHRlX3BhZ2Vf
Y3RvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlyZXR1cm4gcGFnZXRhYmxlX3B0ZV9jdG9yKHBh
Z2VfcHRkZXNjKHBhZ2UpKTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIHBhZ2V0YWJsZV9wdGVf
ZHRvcihzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpCiB7CiAJc3RydWN0IGZvbGlvICpmb2xpbyA9IHB0
ZGVzY19mb2xpbyhwdGRlc2MpOwpAQCAtMjg4NywxMSArMjg4Miw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBwYWdldGFibGVfcHRlX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQogCWxydXZlY19z
dGF0X3N1Yl9mb2xpbyhmb2xpbywgTlJfUEFHRVRBQkxFKTsKIH0KIAotc3RhdGljIGlubGluZSB2
b2lkIHBndGFibGVfcHRlX3BhZ2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlwYWdldGFi
bGVfcHRlX2R0b3IocGFnZV9wdGRlc2MocGFnZSkpOwotfQotCiBwdGVfdCAqX19wdGVfb2Zmc2V0
X21hcChwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIHBtZF90ICpwbWR2YWxwKTsKIHN0
YXRpYyBpbmxpbmUgcHRlX3QgKnB0ZV9vZmZzZXRfbWFwKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxv
bmcgYWRkcikKIHsKQEAgLTI5OTMsMTEgKzI5ODMsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcGFn
ZXRhYmxlX3BtZF9jdG9yKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykKIAlyZXR1cm4gdHJ1ZTsKIH0K
IAotc3RhdGljIGlubGluZSBib29sIHBndGFibGVfcG1kX3BhZ2VfY3RvcihzdHJ1Y3QgcGFnZSAq
cGFnZSkKLXsKLQlyZXR1cm4gcGFnZXRhYmxlX3BtZF9jdG9yKHBhZ2VfcHRkZXNjKHBhZ2UpKTsK
LX0KLQogc3RhdGljIGlubGluZSB2b2lkIHBhZ2V0YWJsZV9wbWRfZHRvcihzdHJ1Y3QgcHRkZXNj
ICpwdGRlc2MpCiB7CiAJc3RydWN0IGZvbGlvICpmb2xpbyA9IHB0ZGVzY19mb2xpbyhwdGRlc2Mp
OwpAQCAtMzAwNywxMSArMjk5Miw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwYWdldGFibGVfcG1k
X2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQogCWxydXZlY19zdGF0X3N1Yl9mb2xpbyhmb2xp
bywgTlJfUEFHRVRBQkxFKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIHBndGFibGVfcG1kX3Bh
Z2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlwYWdldGFibGVfcG1kX2R0b3IocGFnZV9w
dGRlc2MocGFnZSkpOwotfQotCiAvKgogICogTm8gc2NhbGFiaWxpdHkgcmVhc29uIHRvIHNwbGl0
IFBVRCBsb2NrcyB5ZXQsIGJ1dCBmb2xsb3cgdGhlIHNhbWUgcGF0dGVybgogICogYXMgdGhlIFBN
RCBsb2NrcyB0byBtYWtlIGl0IGVhc2llciBpZiB3ZSBkZWNpZGUgdG8uICBUaGUgVk0gc2hvdWxk
IG5vdCBiZQotLSAKMi40MC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=
