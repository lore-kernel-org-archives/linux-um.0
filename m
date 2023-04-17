Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6431C77B7A
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rn2h8aCOmfzECt1j+qIZN3GhIsZMliQK24sirOOQtP4=; b=lztj6PQhoRM2l1
	OEi9X8T+uPnjmWiJPgRMbdRpsGJoaiI0j0o5owop9c0lgghMvapPezFAXcknvm/8d5bJpAIdkZynp
	SoankT0avqKhLoxmCCnwChw9cZCAawtl7m+92vab+1gg3EjW7NxxVxjLda3aUvD+7Wy4i0SVQoRAA
	0pYgT6LS/TabPFdXnPjFfhkymzh7iAdU98KAo5A/s48VUJsKWpJg1nWUGG2igWHB59pgeSN8n6bIc
	f0TJQuN+EuODhO78wdKXLRENMJEjBmF7EULlvhLJ0WaryJr8TBTkNQN5lzdvRhPlQgPAel3f2X9GW
	deYsncwt3HvovNjgLz6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poVr1-00HaAV-1b;
	Mon, 17 Apr 2023 20:53:39 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqw-00Ha8p-1I;
	Mon, 17 Apr 2023 20:53:35 +0000
Received: by mail-pj1-x102d.google.com with SMTP id v9so32541978pjk.0;
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764811; x=1684356811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI4mQ87WoWgY+PGEzL+RyVT2V9KzYHmGTUoQkkpMa78=;
        b=OlBOZiQXTEQ2yJNCXWXVeEV70jBd/5g1C1TEFSYKGJH4RB2t5MeymRQTJkCAMhqY8X
         xT0QIMwkP3fej3rBN/YVKJNeHnVxdz5dc1MiD+bCMEF9s0dHv6uN4wyDmNsH2Y2Ym+iY
         2ZNsAP/RgJk51+uVp81qcQOj+bGNImtPBjaen/JrqoOw/PBUibNGoaM/ZCPpfG5uzvkW
         XBTMu6ICJd2ADipenkzYOjnqUxYIKWTiKPtzD1nHG87S/riR67Qes5ac47aDjBNBedgZ
         nWtoSmVXLxbkA7A5m2dqK2dJ5Frc5F3qBCVwCqlbD2BXSOmg77x4kXyTkenC4W3QlTw8
         reIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764811; x=1684356811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI4mQ87WoWgY+PGEzL+RyVT2V9KzYHmGTUoQkkpMa78=;
        b=F8xJXuiOTOiN8Y99RdRlqiecvSL+SbiNKAzd6Nb9vhMbLYFi7amRDV7BPtwMDQPuva
         5LLKQGFePGYAq2pubWE3f46TcG1xXNrS6PbaYN7vbpeaMAauCHKpjDkPyYKjygHpC4wv
         IpW3PhwpaqcVVUEMrBTZwxYuj7cBgFtwwPzqg1rKceLJ3YemhRMPTQvE85h4eb1fjD1m
         pfCt7xJElZKwv7k7lVsSPdle7aSLu7H7CNRS13eODs3ASm1JoWe9nwljfED7Y342zS9R
         CaaCWsflis7Ypb+ZD6ff1SwOOMncoXZfvvdNApOKya64HA/9ZZbjMGBtdQalKlTjDXFO
         CuiA==
X-Gm-Message-State: AAQBX9e2bSwwY8/A3bqu5sBxxrJL3jRleUSs11/bTLzyp3mhJQlbWd2e
	LlvgSbla32PfypUWXNdtmfc=
X-Google-Smtp-Source: AKy350bto7gkYUEXZmV5HcAXbLEbfMM+TO53YOoTMdsdAnKO7c7cFoDN5d9Q3fv9Tr0h94wXesVw1Q==
X-Received: by 2002:a17:902:ec82:b0:1a1:b137:4975 with SMTP id x2-20020a170902ec8200b001a1b1374975mr256275plg.49.1681764811306;
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 33/33] mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers
Date: Mon, 17 Apr 2023 13:50:48 -0700
Message-Id: <20230417205048.15870-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_135334_463324_70E5FFE3 
X-CRM114-Status: GOOD (  11.46  )
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
Y2sucnN0CmluZGV4IDUwZWUwZGZjOTViZS4uYjNjNjEyMTgzMTM1IDEwMDY0NAotLS0gYS9Eb2N1
bWVudGF0aW9uL21tL3NwbGl0X3BhZ2VfdGFibGVfbG9jay5yc3QKKysrIGIvRG9jdW1lbnRhdGlv
bi9tbS9zcGxpdF9wYWdlX3RhYmxlX2xvY2sucnN0CkBAIC01Myw3ICs1Myw3IEBAIFN1cHBvcnQg
b2Ygc3BsaXQgcGFnZSB0YWJsZSBsb2NrIGJ5IGFuIGFyY2hpdGVjdHVyZQogPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAKIFRoZXJlJ3Mgbm8gbmVl
ZCBpbiBzcGVjaWFsIGVuYWJsaW5nIG9mIFBURSBzcGxpdCBwYWdlIHRhYmxlIGxvY2s6IGV2ZXJ5
dGhpbmcKLXJlcXVpcmVkIGlzIGRvbmUgYnkgcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgYW5kIHBn
dGFibGVfcHRlX3BhZ2VfZHRvcigpLCB3aGljaAorcmVxdWlyZWQgaXMgZG9uZSBieSBwdGRlc2Nf
cHRlX2N0b3IoKSBhbmQgcHRkZXNjX3B0ZV9kdG9yKCksIHdoaWNoCiBtdXN0IGJlIGNhbGxlZCBv
biBQVEUgdGFibGUgYWxsb2NhdGlvbiAvIGZyZWVpbmcuCiAKIE1ha2Ugc3VyZSB0aGUgYXJjaGl0
ZWN0dXJlIGRvZXNuJ3QgdXNlIHNsYWIgYWxsb2NhdG9yIGZvciBwYWdlIHRhYmxlCkBAIC02Myw4
ICs2Myw4IEBAIFRoaXMgZmllbGQgc2hhcmVzIHN0b3JhZ2Ugd2l0aCBwYWdlLT5wdGwuCiBQTUQg
c3BsaXQgbG9jayBvbmx5IG1ha2VzIHNlbnNlIGlmIHlvdSBoYXZlIG1vcmUgdGhhbiB0d28gcGFn
ZSB0YWJsZQogbGV2ZWxzLgogCi1QTUQgc3BsaXQgbG9jayBlbmFibGluZyByZXF1aXJlcyBwZ3Rh
YmxlX3BtZF9wYWdlX2N0b3IoKSBjYWxsIG9uIFBNRCB0YWJsZQotYWxsb2NhdGlvbiBhbmQgcGd0
YWJsZV9wbWRfcGFnZV9kdG9yKCkgb24gZnJlZWluZy4KK1BNRCBzcGxpdCBsb2NrIGVuYWJsaW5n
IHJlcXVpcmVzIHB0ZGVzY19wbWRfY3RvcigpIGNhbGwgb24gUE1EIHRhYmxlCithbGxvY2F0aW9u
IGFuZCBwdGRlc2NfcG1kX2R0b3IoKSBvbiBmcmVlaW5nLgogCiBBbGxvY2F0aW9uIHVzdWFsbHkg
aGFwcGVucyBpbiBwbWRfYWxsb2Nfb25lKCksIGZyZWVpbmcgaW4gcG1kX2ZyZWUoKSBhbmQKIHBt
ZF9mcmVlX3RsYigpLCBidXQgbWFrZSBzdXJlIHlvdSBjb3ZlciBhbGwgUE1EIHRhYmxlIGFsbG9j
YXRpb24gLyBmcmVlaW5nCkBAIC03Miw3ICs3Miw3IEBAIHBhdGhzOiBpLmUgWDg2X1BBRSBwcmVh
bGxvY2F0ZSBmZXcgUE1EcyBvbiBwZ2RfYWxsb2MoKS4KIAogV2l0aCBldmVyeXRoaW5nIGluIHBs
YWNlIHlvdSBjYW4gc2V0IENPTkZJR19BUkNIX0VOQUJMRV9TUExJVF9QTURfUFRMT0NLLgogCi1O
T1RFOiBwZ3RhYmxlX3B0ZV9wYWdlX2N0b3IoKSBhbmQgcGd0YWJsZV9wbWRfcGFnZV9jdG9yKCkg
Y2FuIGZhaWwgLS0gaXQgbXVzdAorTk9URTogcHRkZXNjX3B0ZV9jdG9yKCkgYW5kIHB0ZGVzY19w
bWRfY3RvcigpIGNhbiBmYWlsIC0tIGl0IG11c3QKIGJlIGhhbmRsZWQgcHJvcGVybHkuCiAKIHBh
Z2UtPnB0bApAQCAtOTIsNyArOTIsNyBAQCB0cmljazoKICAgIHNwbGl0IGxvY2sgd2l0aCBlbmFi
bGVkIERFQlVHX1NQSU5MT0NLIG9yIERFQlVHX0xPQ0tfQUxMT0MsIGJ1dCBjb3N0cwogICAgb25l
IG1vcmUgY2FjaGUgbGluZSBmb3IgaW5kaXJlY3QgYWNjZXNzOwogCi1UaGUgc3BpbmxvY2tfdCBh
bGxvY2F0ZWQgaW4gcGd0YWJsZV9wdGVfcGFnZV9jdG9yKCkgZm9yIFBURSB0YWJsZSBhbmQgaW4K
LXBndGFibGVfcG1kX3BhZ2VfY3RvcigpIGZvciBQTUQgdGFibGUuCitUaGUgc3BpbmxvY2tfdCBh
bGxvY2F0ZWQgaW4gcHRkZXNjX3B0ZV9jdG9yKCkgZm9yIFBURSB0YWJsZSBhbmQgaW4KK3B0ZGVz
Y19wbWRfY3RvcigpIGZvciBQTUQgdGFibGUuCiAKIFBsZWFzZSwgbmV2ZXIgYWNjZXNzIHBhZ2Ut
PnB0bCBkaXJlY3RseSAtLSB1c2UgYXBwcm9wcmlhdGUgaGVscGVyLgpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0vc3BsaXRfcGFnZV90YWJsZV9sb2NrLnJz
dCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL21tL3NwbGl0X3BhZ2VfdGFibGVf
bG9jay5yc3QKaW5kZXggNGZiN2FhNjY2MDM3Li5hMzMyM2ViOWRjNDAgMTAwNjQ0Ci0tLSBhL0Rv
Y3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL21tL3NwbGl0X3BhZ2VfdGFibGVfbG9jay5y
c3QKKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0vc3BsaXRfcGFnZV90
YWJsZV9sb2NrLnJzdApAQCAtNTYsMTYgKzU2LDE2IEBAIEh1Z2V0bGLnibnlrprnmoTovoXliqnl
h73mlbA6CiDmnrbmnoTlr7nliIbpobXooajplIHnmoTmlK/mjIEKID09PT09PT09PT09PT09PT09
PT09CiAKLeayoeacieW/heimgeeJueWIq+WQr+eUqFBUReWIhumhteihqOmUge+8muaJgOaciemc
gOimgeeahOS4nOilv+mDveeUsXBndGFibGVfcHRlX3BhZ2VfY3RvcigpCi3lkoxwZ3RhYmxlX3B0
ZV9wYWdlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/hemhu+WcqFBUReihqOWIhumFjS/ph4rmlL7m
l7booqvosIPnlKjjgIIKK+ayoeacieW/heimgeeJueWIq+WQr+eUqFBUReWIhumhteihqOmUge+8
muaJgOaciemcgOimgeeahOS4nOilv+mDveeUsXB0ZGVzY19wdGVfY3RvcigpCivlkoxwdGRlc2Nf
cHRlX2R0b3IoKeWujOaIkO+8jOWug+S7rOW/hemhu+WcqFBUReihqOWIhumFjS/ph4rmlL7ml7bo
oqvosIPnlKjjgIIKIAog56Gu5L+d5p625p6E5LiN5L2/55Soc2xhYuWIhumFjeWZqOadpeWIhumF
jemhteihqO+8mnNsYWLkvb/nlKhwYWdlLT5zbGFiX2NhY2hl5p2l5YiG6YWN5YW26aG1CiDpnaLj
gILov5nkuKrljLrln5/kuI5wYWdlLT5wdGzlhbHkuqvlrZjlgqjjgIIKIAogUE1E5YiG6aG16ZSB
5Y+q5pyJ5Zyo5L2g5pyJ5Lik5Liq5Lul5LiK55qE6aG16KGo57qn5Yir5pe25omN5pyJ5oSP5LmJ
44CCCiAKLeWQr+eUqFBNROWIhumhtemUgemcgOimgeWcqFBNROihqOWIhumFjeaXtuiwg+eUqHBn
dGFibGVfcG1kX3BhZ2VfY3Rvcigp77yM5Zyo6YeK5pS+5pe26LCDCi3nlKhwZ3RhYmxlX3BtZF9w
YWdlX2R0b3IoKeOAggor5ZCv55SoUE1E5YiG6aG16ZSB6ZyA6KaB5ZyoUE1E6KGo5YiG6YWN5pe2
6LCD55SocHRkZXNjX3BtZF9jdG9yKCnvvIzlnKjph4rmlL7ml7bosIMKK+eUqHB0ZGVzY19wbWRf
ZHRvcigp44CCCiAKIOWIhumFjemAmuW4uOWPkeeUn+WcqHBtZF9hbGxvY19vbmUoKeS4re+8jOmH
iuaUvuWPkeeUn+WcqHBtZF9mcmVlKCnlkoxwbWRfZnJlZV90bGIoKQog5Lit77yM5L2G6KaB56Gu
5L+d6KaG55uW5omA5pyJ55qEUE1E6KGo5YiG6YWNL+mHiuaUvui3r+W+hO+8muWNs1g4Nl9QQUXl
nKhwZ2RfYWxsb2MoKeS4remihOWFiApAQCAtNzMsNyArNzMsNyBAQCBQTUTliIbpobXplIHlj6rm
nInlnKjkvaDmnInkuKTkuKrku6XkuIrnmoTpobXooajnuqfliKvml7bmiY3mnInmhI/kuYnjgIIK
IAog5LiA5YiH5bCx57uq5ZCO77yM5L2g5Y+v5Lul6K6+572uQ09ORklHX0FSQ0hfRU5BQkxFX1NQ
TElUX1BNRF9QVExPQ0vjgIIKIAot5rOo5oSP77yacGd0YWJsZV9wdGVfcGFnZV9jdG9yKCnlkoxw
Z3RhYmxlX3BtZF9wYWdlX2N0b3IoKeWPr+iDveWksei0pS0t5b+FCivms6jmhI/vvJpwdGRlc2Nf
cHRlX2N0b3IoKeWSjHB0ZGVzY19wbWRfY3Rvcigp5Y+v6IO95aSx6LSlLS3lv4UKIOmhu+ato+eh
ruWkhOeQhuOAggogCiBwYWdlLT5wdGwKQEAgLTkwLDcgKzkwLDcgQEAgcGFnZS0+cHRs55So5LqO
6K6/6Zeu5YiG5Ymy6aG16KGo6ZSB77yM5YW25LitJ3BhZ2Un5piv5YyF5ZCr6K+l6KGo55qE6aG1
6Z2ic3RydWMKICAgIOeahOaMh+mSiOW5tuWKqOaAgeWIhumFjeWug+OAgui/meWFgeiuuOWcqOWQ
r+eUqERFQlVHX1NQSU5MT0NL5oiWREVCVUdfTE9DS19BTExPQ+eahAogICAg5oOF5Ya15LiL5L2/
55So5YiG6aG16ZSB77yM5L2G55Sx5LqO6Ze05o6l6K6/6Zeu6ICM5aSa6Iqx5LqG5LiA5Liq57yT
5a2Y6KGM44CCCiAKLVBUReihqOeahHNwaW5sb2NrX3TliIbphY3lnKhwZ3RhYmxlX3B0ZV9wYWdl
X2N0b3IoKeS4re+8jFBNROihqOeahHNwaW5sb2NrX3QKLeWIhumFjeWcqHBndGFibGVfcG1kX3Bh
Z2VfY3Rvcigp5Lit44CCCitQVEXooajnmoRzcGlubG9ja1905YiG6YWN5ZyocHRkZXNjX3B0ZV9j
dG9yKCnkuK3vvIxQTUTooajnmoRzcGlubG9ja190CivliIbphY3lnKhwdGRlc2NfcG1kX2N0b3Io
KeS4reOAggogCiDor7fkuI3opoHnm7TmjqXorr/pl65wYWdlLT5wdGwgLSAt5L2/55So6YCC5b2T
55qE6L6F5Yqp5Ye95pWw44CCCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNs
dWRlL2xpbnV4L21tLmgKaW5kZXggY2IxMzZkMmZkZjc0Li5lMDg2MzhkYzU4Y2YgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21tLmgKQEAgLTI4NTgs
MTEgKzI4NTgsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcHRkZXNjX3B0ZV9jdG9yKHN0cnVjdCBw
dGRlc2MgKnB0ZGVzYykKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIHBn
dGFibGVfcHRlX3BhZ2VfY3RvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlyZXR1cm4gcHRkZXNj
X3B0ZV9jdG9yKHBhZ2VfcHRkZXNjKHBhZ2UpKTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIHB0
ZGVzY19wdGVfZHRvcihzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpCiB7CiAJc3RydWN0IGZvbGlvICpm
b2xpbyA9IHB0ZGVzY19mb2xpbyhwdGRlc2MpOwpAQCAtMjg3MiwxMSArMjg2Nyw2IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBwdGRlc2NfcHRlX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQogCWxy
dXZlY19zdGF0X3N1Yl9mb2xpbyhmb2xpbywgTlJfUEFHRVRBQkxFKTsKIH0KIAotc3RhdGljIGlu
bGluZSB2b2lkIHBndGFibGVfcHRlX3BhZ2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlw
dGRlc2NfcHRlX2R0b3IocGFnZV9wdGRlc2MocGFnZSkpOwotfQotCiAjZGVmaW5lIHB0ZV9vZmZz
ZXRfbWFwX2xvY2sobW0sIHBtZCwgYWRkcmVzcywgcHRscCkJXAogKHsJCQkJCQkJXAogCXNwaW5s
b2NrX3QgKl9fcHRsID0gcHRlX2xvY2twdHIobW0sIHBtZCk7CVwKQEAgLTI5NjcsMTEgKzI5NTcs
NiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcHRkZXNjX3BtZF9jdG9yKHN0cnVjdCBwdGRlc2MgKnB0
ZGVzYykKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIHBndGFibGVfcG1k
X3BhZ2VfY3RvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlyZXR1cm4gcHRkZXNjX3BtZF9jdG9y
KHBhZ2VfcHRkZXNjKHBhZ2UpKTsKLX0KLQogc3RhdGljIGlubGluZSB2b2lkIHB0ZGVzY19wbWRf
ZHRvcihzdHJ1Y3QgcHRkZXNjICpwdGRlc2MpCiB7CiAJc3RydWN0IGZvbGlvICpmb2xpbyA9IHB0
ZGVzY19mb2xpbyhwdGRlc2MpOwpAQCAtMjk4MSwxMSArMjk2Niw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBwdGRlc2NfcG1kX2R0b3Ioc3RydWN0IHB0ZGVzYyAqcHRkZXNjKQogCWxydXZlY19zdGF0
X3N1Yl9mb2xpbyhmb2xpbywgTlJfUEFHRVRBQkxFKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lk
IHBndGFibGVfcG1kX3BhZ2VfZHRvcihzdHJ1Y3QgcGFnZSAqcGFnZSkKLXsKLQlwdGRlc2NfcG1k
X2R0b3IocGFnZV9wdGRlc2MocGFnZSkpOwotfQotCiAvKgogICogTm8gc2NhbGFiaWxpdHkgcmVh
c29uIHRvIHNwbGl0IFBVRCBsb2NrcyB5ZXQsIGJ1dCBmb2xsb3cgdGhlIHNhbWUgcGF0dGVybgog
ICogYXMgdGhlIFBNRCBsb2NrcyB0byBtYWtlIGl0IGVhc2llciBpZiB3ZSBkZWNpZGUgdG8uICBU
aGUgVk0gc2hvdWxkIG5vdCBiZQotLSAKMi4zOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=
