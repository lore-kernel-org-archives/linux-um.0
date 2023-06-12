Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8B1C88CB8
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXadFeiqQXoLyKFzHsVDlJz3uwMPorKr/FqHejakouE=; b=PUVjgMVTcCpqnu
	vZXtB3v3gqvwaY46tyzn+m1bTQXEv+GoAZc7h8CTJSw0kRHYUq5x8J0A68J0S3s8palEuowVXpgD9
	p+tCTK5lxcYy2WfHg4eKdYcSYWMWK+NVI8f4ykzHE85iYllYgB8OqcdS0+JnzT/92zlG5yPzYZ/RS
	F2E06czvykp2T+pOSYT2faySJLXp7SZ9EGFNv+p8dglwDZgnQUl+AX7jinYrxxboJv15KKkoAlZ4m
	RMSziPldPi+FhHTGf6AArmmzmRzU00U0yOnXxKzOJgrAXRaHQQIqqSuLAYygqrIqtmtjypWFTtu0J
	hFYk+amjpnG9A2cZx77g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8old-005QQt-2Z;
	Mon, 12 Jun 2023 21:08:01 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojc-005N2P-05;
	Mon, 12 Jun 2023 21:05:57 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d4f50427cso6519987b3.3;
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603955; x=1689195955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ky1uDH3HAwvFTnah34UfzHSGIz5XtPXejf2e4vlCZQ=;
        b=mPREwt4CZ7eyjP0awRF+7J59gjRJfQYSldhgYFU3GX8JHbZALGX3vT3PNPPDkSpada
         kYBrPZ3fT3IHCrmgBacTa14fpMsdfLY/wfMsw3mbb6xXz9ObJPsrzVS2jkFBCphqvrnl
         W2C3CK1LTKvQS4G7ilQBgC608IiFiwIK0aJZOApjzUoXUMUFaYyvbn2berfE8dovgnlw
         G/g86Ig9l0whUW2/5Qd6SZuVXZ3fDYfyaml8bSeL/n/Mla1l5cRkRmXZyiI9FghcycAP
         +JJqIE8dynwBhJPRmXp4HhikHugb2xp+HYDNKHli1SWflPjzo5LK7t0+7e7QbCiwECv3
         X+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603955; x=1689195955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ky1uDH3HAwvFTnah34UfzHSGIz5XtPXejf2e4vlCZQ=;
        b=fRNGwBxqx0TbLvkdC1McB9QAkRcyukVC4nL5v0AP/EIJ5PRl01Ruh3Oq6whjz52Xol
         qQST1yaCRCvR/ZNDSbzRm0e1KiTswvYVpIZ3SvkClia/8bY16qxO0SCJNnc+KM3lv/kO
         w68fe6MJR9tlX02FHDQ+KpF53TPXZY1Ypk7ULaBp1LLvP0s6LgxMfSvPMfTAg9/60Bk8
         qRImLVFRIz5eIJYWI9vMbHks27+EBEbn8jF0UmFpaFaGrIrbJAHCWYClyqBdvwV5vYF6
         IsVHY+4s4l/sx9yuy0aZSbUooi5eXQkbyD/rxfa9OeKQGnpjGa+pAzy/yf8PmTX2FlrF
         SWiw==
X-Gm-Message-State: AC+VfDwXU5V3anewhrae9fq44ARuUG1FULsVDrtZIHcHAqyHnoNFhVMl
	6W0AGTNPLUhCL0iVseXPgUk=
X-Google-Smtp-Source: ACHHUZ6hpYtRh2B57fGd8bPmVf+MLwfrVY1EUXTrrFmJrCanxRRmSJ+wngffzdYGMbXJAYdrr0DA1A==
X-Received: by 2002:a81:9e13:0:b0:56d:4b17:7e9c with SMTP id m19-20020a819e13000000b0056d4b177e9cmr1826324ywj.32.1686603955490;
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 34/34] mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers
Date: Mon, 12 Jun 2023 14:04:23 -0700
Message-Id: <20230612210423.18611-35-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140556_109362_A1238117 
X-CRM114-Status: GOOD (  11.76  )
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
aXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+Ci0tLQogRG9jdW1l
bnRhdGlvbi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0ICAgIHwgMTIgKysrKystLS0tLS0K
IC4uLi96aF9DTi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0ICAgICAgICB8IDE0ICsrKysr
Ky0tLS0tLS0KIGluY2x1ZGUvbGludXgvbW0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDIwIC0tLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgMzMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9tbS9zcGxpdF9w
YWdlX3RhYmxlX2xvY2sucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xv
Y2sucnN0CmluZGV4IDUwZWUwZGZjOTViZS4uNGJmZmVjNzI4MzQwIDEwMDY0NAotLS0gYS9Eb2N1
bWVudGF0aW9uL21tL3NwbGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKKysrIGIvRG9jdW1lbnRhdGlv
bi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0CkBAIC01Myw3ICs1Myw3IEBAIFN1cHBvcnQg
b2Ygc3BsaXQgcGFnZSB0YWJsZSBsb2NrIGJ5IGFuIGFyY2hpdGVjdHVyZQogPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAKIFRoZXJlJ3Mgbm8gbmVl
ZCBpbiBzcGVjaWFsIGVuYWJsaW5nIG9mIFBURSBzcGxpdCBwYWdlIHRhYmxlIGxvY2s6IGV2ZXJ5
dGhpbmcKLXJlcXVpcmVkIGlzIGRvbmUgYnkgcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgYW5kIHBn
dGFibGVfcHRlX3BhZ2VfZHRvcigpLCB3aGljaAorcmVxdWlyZWQgaXMgZG9uZSBieSBwYWdldGFi
bGVfcHRlX2N0b3IoKSBhbmQgcGFnZXRhYmxlX3B0ZV9kdG9yKCksIHdoaWNoCiBtdXN0IGJlIGNh
bGxlZCBvbiBQVEUgdGFibGUgYWxsb2NhdGlvbiAvIGZyZWVpbmcuCiAKIE1ha2Ugc3VyZSB0aGUg
YXJjaGl0ZWN0dXJlIGRvZXNuJ3QgdXNlIHNsYWIgYWxsb2NhdG9yIGZvciBwYWdlIHRhYmxlCkBA
IC02Myw4ICs2Myw4IEBAIFRoaXMgZmllbGQgc2hhcmVzIHN0b3JhZ2Ugd2l0aCBwYWdlLT5wdGwu
CiBQTUQgc3BsaXQgbG9jayBvbmx5IG1ha2VzIHNlbnNlIGlmIHlvdSBoYXZlIG1vcmUgdGhhbiB0
d28gcGFnZSB0YWJsZQogbGV2ZWxzLgogCi1QTUQgc3BsaXQgbG9jayBlbmFibGluZyByZXF1aXJl
cyBwZ3RhYmxlX3BtZF9wYWdlX2N0b3IoKSBjYWxsIG9uIFBNRCB0YWJsZQotYWxsb2NhdGlvbiBh
bmQgcGd0YWJsZV9wbWRfcGFnZV9kdG9yKCkgb24gZnJlZWluZy4KK1BNRCBzcGxpdCBsb2NrIGVu
YWJsaW5nIHJlcXVpcmVzIHBhZ2V0YWJsZV9wbWRfY3RvcigpIGNhbGwgb24gUE1EIHRhYmxlCith
bGxvY2F0aW9uIGFuZCBwYWdldGFibGVfcG1kX2R0b3IoKSBvbiBmcmVlaW5nLgogCiBBbGxvY2F0
aW9uIHVzdWFsbHkgaGFwcGVucyBpbiBwbWRfYWxsb2Nfb25lKCksIGZyZWVpbmcgaW4gcG1kX2Zy
ZWUoKSBhbmQKIHBtZF9mcmVlX3RsYigpLCBidXQgbWFrZSBzdXJlIHlvdSBjb3ZlciBhbGwgUE1E
IHRhYmxlIGFsbG9jYXRpb24gLyBmcmVlaW5nCkBAIC03Miw3ICs3Miw3IEBAIHBhdGhzOiBpLmUg
WDg2X1BBRSBwcmVhbGxvY2F0ZSBmZXcgUE1EcyBvbiBwZ2RfYWxsb2MoKS4KIAogV2l0aCBldmVy
eXRoaW5nIGluIHBsYWNlIHlvdSBjYW4gc2V0IENPTkZJR19BUkNIX0VOQUJMRV9TUExJVF9QTURf
UFRMT0NLLgogCi1OT1RFOiBwZ3RhYmxlX3B0ZV9wYWdlX2N0b3IoKSBhbmQgcGd0YWJsZV9wbWRf
cGFnZV9jdG9yKCkgY2FuIGZhaWwgLS0gaXQgbXVzdAorTk9URTogcGFnZXRhYmxlX3B0ZV9jdG9y
KCkgYW5kIHBhZ2V0YWJsZV9wbWRfY3RvcigpIGNhbiBmYWlsIC0tIGl0IG11c3QKIGJlIGhhbmRs
ZWQgcHJvcGVybHkuCiAKIHBhZ2UtPnB0bApAQCAtOTIsNyArOTIsNyBAQCB0cmljazoKICAgIHNw
bGl0IGxvY2sgd2l0aCBlbmFibGVkIERFQlVHX1NQSU5MT0NLIG9yIERFQlVHX0xPQ0tfQUxMT0Ms
IGJ1dCBjb3N0cwogICAgb25lIG1vcmUgY2FjaGUgbGluZSBmb3IgaW5kaXJlY3QgYWNjZXNzOwog
Ci1UaGUgc3BpbmxvY2tfdCBhbGxvY2F0ZWQgaW4gcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgZm9y
IFBURSB0YWJsZSBhbmQgaW4KLXBndGFibGVfcG1kX3BhZ2VfY3RvcigpIGZvciBQTUQgdGFibGUu
CitUaGUgc3BpbmxvY2tfdCBhbGxvY2F0ZWQgaW4gcGFnZXRhYmxlX3B0ZV9jdG9yKCkgZm9yIFBU
RSB0YWJsZSBhbmQgaW4KK3BhZ2V0YWJsZV9wbWRfY3RvcigpIGZvciBQTUQgdGFibGUuCiAKIFBs
ZWFzZSwgbmV2ZXIgYWNjZXNzIHBhZ2UtPnB0bCBkaXJlY3RseSAtLSB1c2UgYXBwcm9wcmlhdGUg
aGVscGVyLgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0v
c3BsaXRfcGFnZV90YWJsZV9sb2NrLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL21tL3NwbGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKaW5kZXggNGZiN2FhNjY2MDM3Li5hMmMy
ODg2NzBhMjQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL21t
L3NwbGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vbW0vc3BsaXRfcGFnZV90YWJsZV9sb2NrLnJzdApAQCAtNTYsMTYgKzU2LDE2IEBA
IEh1Z2V0bGLnibnlrprnmoTovoXliqnlh73mlbA6CiDmnrbmnoTlr7nliIbpobXooajplIHnmoTm
lK/mjIEKID09PT09PT09PT09PT09PT09PT09CiAKLeayoeacieW/heimgeeJueWIq+WQr+eUqFBU
ReWIhumhteihqOmUge+8muaJgOaciemcgOimgeeahOS4nOilv+mDveeUsXBndGFibGVfcHRlX3Bh
Z2VfY3RvcigpCi3lkoxwZ3RhYmxlX3B0ZV9wYWdlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/hemh
u+WcqFBUReihqOWIhumFjS/ph4rmlL7ml7booqvosIPnlKjjgIIKK+ayoeacieW/heimgeeJueWI
q+WQr+eUqFBUReWIhumhteihqOmUge+8muaJgOaciemcgOimgeeahOS4nOilv+mDveeUsXBhZ2V0
YWJsZV9wdGVfY3RvcigpCivlkoxwYWdldGFibGVfcHRlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/
hemhu+WcqFBUReihqOWIhumFjS/ph4rmlL7ml7booqvosIPnlKjjgIIKIAog56Gu5L+d5p625p6E
5LiN5L2/55Soc2xhYuWIhumFjeWZqOadpeWIhumFjemhteihqO+8mnNsYWLkvb/nlKhwYWdlLT5z
bGFiX2NhY2hl5p2l5YiG6YWN5YW26aG1CiDpnaLjgILov5nkuKrljLrln5/kuI5wYWdlLT5wdGzl
hbHkuqvlrZjlgqjjgIIKIAogUE1E5YiG6aG16ZSB5Y+q5pyJ5Zyo5L2g5pyJ5Lik5Liq5Lul5LiK
55qE6aG16KGo57qn5Yir5pe25omN5pyJ5oSP5LmJ44CCCiAKLeWQr+eUqFBNROWIhumhtemUgemc
gOimgeWcqFBNROihqOWIhumFjeaXtuiwg+eUqHBndGFibGVfcG1kX3BhZ2VfY3Rvcigp77yM5Zyo
6YeK5pS+5pe26LCDCi3nlKhwZ3RhYmxlX3BtZF9wYWdlX2R0b3IoKeOAggor5ZCv55SoUE1E5YiG
6aG16ZSB6ZyA6KaB5ZyoUE1E6KGo5YiG6YWN5pe26LCD55SocGFnZXRhYmxlX3BtZF9jdG9yKCnv
vIzlnKjph4rmlL7ml7bosIMKK+eUqHBhZ2V0YWJsZV9wbWRfZHRvcigp44CCCiAKIOWIhumFjemA
muW4uOWPkeeUn+WcqHBtZF9hbGxvY19vbmUoKeS4re+8jOmHiuaUvuWPkeeUn+WcqHBtZF9mcmVl
KCnlkoxwbWRfZnJlZV90bGIoKQog5Lit77yM5L2G6KaB56Gu5L+d6KaG55uW5omA5pyJ55qEUE1E
6KGo5YiG6YWNL+mHiuaUvui3r+W+hO+8muWNs1g4Nl9QQUXlnKhwZ2RfYWxsb2MoKeS4remihOWF
iApAQCAtNzMsNyArNzMsNyBAQCBQTUTliIbpobXplIHlj6rmnInlnKjkvaDmnInkuKTkuKrku6Xk
uIrnmoTpobXooajnuqfliKvml7bmiY3mnInmhI/kuYnjgIIKIAog5LiA5YiH5bCx57uq5ZCO77yM
5L2g5Y+v5Lul6K6+572uQ09ORklHX0FSQ0hfRU5BQkxFX1NQTElUX1BNRF9QVExPQ0vjgIIKIAot
5rOo5oSP77yacGd0YWJsZV9wdGVfcGFnZV9jdG9yKCnlkoxwZ3RhYmxlX3BtZF9wYWdlX2N0b3Io
KeWPr+iDveWksei0pS0t5b+FCivms6jmhI/vvJpwYWdldGFibGVfcHRlX2N0b3IoKeWSjHBhZ2V0
YWJsZV9wbWRfY3Rvcigp5Y+v6IO95aSx6LSlLS3lv4UKIOmhu+ato+ehruWkhOeQhuOAggogCiBw
YWdlLT5wdGwKQEAgLTkwLDcgKzkwLDcgQEAgcGFnZS0+cHRs55So5LqO6K6/6Zeu5YiG5Ymy6aG1
6KGo6ZSB77yM5YW25LitJ3BhZ2Un5piv5YyF5ZCr6K+l6KGo55qE6aG16Z2ic3RydWMKICAgIOea
hOaMh+mSiOW5tuWKqOaAgeWIhumFjeWug+OAgui/meWFgeiuuOWcqOWQr+eUqERFQlVHX1NQSU5M
T0NL5oiWREVCVUdfTE9DS19BTExPQ+eahAogICAg5oOF5Ya15LiL5L2/55So5YiG6aG16ZSB77yM
5L2G55Sx5LqO6Ze05o6l6K6/6Zeu6ICM5aSa6Iqx5LqG5LiA5Liq57yT5a2Y6KGM44CCCiAKLVBU
ReihqOeahHNwaW5sb2NrX3TliIbphY3lnKhwZ3RhYmxlX3B0ZV9wYWdlX2N0b3IoKeS4re+8jFBN
ROihqOeahHNwaW5sb2NrX3QKLeWIhumFjeWcqHBndGFibGVfcG1kX3BhZ2VfY3Rvcigp5Lit44CC
CitQVEXooajnmoRzcGlubG9ja1905YiG6YWN5ZyocGFnZXRhYmxlX3B0ZV9jdG9yKCnkuK3vvIxQ
TUTooajnmoRzcGlubG9ja190CivliIbphY3lnKhwYWdldGFibGVfcG1kX2N0b3IoKeS4reOAggog
CiDor7fkuI3opoHnm7TmjqXorr/pl65wYWdlLT5wdGwgLSAt5L2/55So6YCC5b2T55qE6L6F5Yqp
5Ye95pWw44CCCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4
L21tLmgKaW5kZXggZGMyMTFjNDM2MTBiLi42ZDgzNDgzY2YxODYgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21tLmgKQEAgLTI4OTcsMTEgKzI4OTcs
NiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcGFnZXRhYmxlX3B0ZV9jdG9yKHN0cnVjdCBwdGRlc2Mg
KnB0ZGVzYykKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIHBndGFibGVf
cHRlX3BhZ2VfY3RvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlyZXR1cm4gcGFnZXRhYmxlX3B0
ZV9jdG9yKHBhZ2VfcHRkZXNjKHBhZ2UpKTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIHBhZ2V0
YWJsZV9wdGVfZHRvcihzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpCiB7CiAJc3RydWN0IGZvbGlvICpm
b2xpbyA9IHB0ZGVzY19mb2xpbyhwdGRlc2MpOwpAQCAtMjkxMSwxMSArMjkwNiw2IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBwYWdldGFibGVfcHRlX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQog
CWxydXZlY19zdGF0X3N1Yl9mb2xpbyhmb2xpbywgTlJfUEFHRVRBQkxFKTsKIH0KIAotc3RhdGlj
IGlubGluZSB2b2lkIHBndGFibGVfcHRlX3BhZ2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsK
LQlwYWdldGFibGVfcHRlX2R0b3IocGFnZV9wdGRlc2MocGFnZSkpOwotfQotCiAjZGVmaW5lIHB0
ZV9vZmZzZXRfbWFwX2xvY2sobW0sIHBtZCwgYWRkcmVzcywgcHRscCkJXAogKHsJCQkJCQkJXAog
CXNwaW5sb2NrX3QgKl9fcHRsID0gcHRlX2xvY2twdHIobW0sIHBtZCk7CVwKQEAgLTMwMDYsMTEg
KzI5OTYsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcGFnZXRhYmxlX3BtZF9jdG9yKHN0cnVjdCBw
dGRlc2MgKnB0ZGVzYykKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIHBn
dGFibGVfcG1kX3BhZ2VfY3RvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlyZXR1cm4gcGFnZXRh
YmxlX3BtZF9jdG9yKHBhZ2VfcHRkZXNjKHBhZ2UpKTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lk
IHBhZ2V0YWJsZV9wbWRfZHRvcihzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpCiB7CiAJc3RydWN0IGZv
bGlvICpmb2xpbyA9IHB0ZGVzY19mb2xpbyhwdGRlc2MpOwpAQCAtMzAyMCwxMSArMzAwNSw2IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBwYWdldGFibGVfcG1kX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRk
ZXNjKQogCWxydXZlY19zdGF0X3N1Yl9mb2xpbyhmb2xpbywgTlJfUEFHRVRBQkxFKTsKIH0KIAot
c3RhdGljIGlubGluZSB2b2lkIHBndGFibGVfcG1kX3BhZ2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFn
ZSkKLXsKLQlwYWdldGFibGVfcG1kX2R0b3IocGFnZV9wdGRlc2MocGFnZSkpOwotfQotCiAvKgog
ICogTm8gc2NhbGFiaWxpdHkgcmVhc29uIHRvIHNwbGl0IFBVRCBsb2NrcyB5ZXQsIGJ1dCBmb2xs
b3cgdGhlIHNhbWUgcGF0dGVybgogICogYXMgdGhlIFBNRCBsb2NrcyB0byBtYWtlIGl0IGVhc2ll
ciBpZiB3ZSBkZWNpZGUgdG8uICBUaGUgVk0gc2hvdWxkIG5vdCBiZQotLSAKMi40MC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFp
bGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
