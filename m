Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2031EB64D7
	for <linux-um@archiver.kernel.org>; Tue, 20 Jun 2023 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+t3p7Wu9wBPUPnU4dzfWiUkn0zbY5H8VLMUkwJhBnws=; b=HBZOeRl4CGkJT8
	bKJFe7g1Hb/q05YzJEQFyBlsRn47dpAxpEOsZ1Ly8S1kO0PLFaN3Z5A/fqfnTDHH47Otn0GzakKj1
	ikrKPYoXjxhBUbrcHZG+jMG1KozPyB5SmHF8Ff9H08oPa2cZEcmq0k8OVem3JbYPr9TRl/EW/08eD
	gPRevUGrsbYHZgsbFqutyXLUUaxFlFboqaaCJBeCIkdyXmLW7sqLP1Y7HWCsRvt9OP/vTcLUs04ao
	VvtGYviLTD6SRX9qXSeHDvUMN3N9UfNfkeR4nBFrXFWaDkLuaHyNqgfDij1eDsX8yDKeQeNViTvSb
	/Wti17BzbioCVKDS3etA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBhY5-00CF2G-2r;
	Tue, 20 Jun 2023 20:01:57 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBhY1-00CEzt-1p;
	Tue, 20 Jun 2023 20:01:54 +0000
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b5853a140cso1903734a34.2;
        Tue, 20 Jun 2023 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291309; x=1689883309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4F3qXm8x1AVi+0TrKGx40m/sFxYrt6Lj9IeE/BrpeU=;
        b=g8Wha6YZBIQ4F35wQ8P6Y0c98+3LfOEjAen8YviDIN/VpMlvLwu/TwEQtEhwi2wLbk
         4/b97qENpIhbKycIE1G3aUVCeb+vz/rCN/gI0l10ch7iG8C6c3ywB5bQ5tQe6ryGYXul
         5XkEWnvnLWIaJ1vsJQRh6tPgKWpuL7AyPHBFZQZGhCATWoDKR1D2YRUNFvvEx6dCnM6X
         zMyQcs2OOhmWkXYBbd2Z3eHBKxjZIMZIeFLBGw0YYdvfY15fMS5Ra2rC/awJj+k/fir6
         OMXeho7/p64d1/Gcc6dtEtZlx65PVhnR78rxvmM8tH1fn8015FZgY0Ml6WWkfDm6BXzA
         dR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291309; x=1689883309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4F3qXm8x1AVi+0TrKGx40m/sFxYrt6Lj9IeE/BrpeU=;
        b=kjJ3Z1pDsfcTXMnNMZoQYJaZLVstn7+scEpx+AUTe9xAHTcZpSVuDE1d06Rfq3LLLB
         u0FiUOO+b/qADnqQ6MMxS1fiIdk+QLcLognitD3466JIzz+9tQ+5LjKOh87pAOqlT5yZ
         wNfYZouZkWoQvNDCZjPr0hm0O2ht9qgAWbujz0UWBzzahq1o9nuktnna3Pf1bE5N61K2
         z2OZr8PC8LZ/k4Q4N+BB85Ms5Bs2iHThhv3qkL6LnFApL+volDZJVu9ipdg5fLAIb8x2
         YpRLiR4eSVhdhFplLnRzNNTGUfITVXkjd6wmHidtcliPTzxzji1r8cNo5NBunKfwGi8b
         rwvQ==
X-Gm-Message-State: AC+VfDx5C1dhX3CGw0gKEpjyA0jYtWo1iUYaDs3vTeA2POnb6pA92ZTk
	iVqBkVAqTzyCddQGDmspu0V3B3Yn+Rqwft//fa4=
X-Google-Smtp-Source: ACHHUZ4Hj3uSYs4sk8lvmBdlBVPXrs6qDttIob0+AqgPuiIWdgPfm9A1hihEUgTK87y6a2gHhIBkt791vtKGzbzprm8=
X-Received: by 2002:a05:6358:f0e:b0:12b:ed05:18bb with SMTP id
 b14-20020a0563580f0e00b0012bed0518bbmr8612256rwj.27.1687291309110; Tue, 20
 Jun 2023 13:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <ZIxXw9ERkYv+ipdd@nvidia.com>
In-Reply-To: <ZIxXw9ERkYv+ipdd@nvidia.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 20 Jun 2023 13:01:39 -0700
Message-ID: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_130153_609098_A15CC0EC 
X-CRM114-Status: GOOD (  21.57  )
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

T24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgNTozOOKAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMDI6MDM6NTNQTSAt
MDcwMCwgVmlzaGFsIE1vb2xhIChPcmFjbGUpIHdyb3RlOgo+ID4gQ3VycmVudGx5LCBwYWdlIHRh
YmxlIGluZm9ybWF0aW9uIGlzIHN0b3JlZCB3aXRoaW4gc3RydWN0IHBhZ2UuIEFzIHBhcnQKPiA+
IG9mIHNpbXBsaWZ5aW5nIHN0cnVjdCBwYWdlLCBjcmVhdGUgc3RydWN0IHB0ZGVzYyBmb3IgcGFn
ZSB0YWJsZQo+ID4gaW5mb3JtYXRpb24uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1v
b2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgaW5jbHVk
ZS9saW51eC9wZ3RhYmxlLmggfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9wZ3RhYmxl
LmgKPiA+IGluZGV4IGM1YTUxNDgxYmJiOS4uMzMwZGU5NmViZmQ2IDEwMDY0NAo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9wZ3RhYmxlLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5o
Cj4gPiBAQCAtOTc1LDYgKzk3NSw1NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHRlcF9tb2RpZnlf
cHJvdF9jb21taXQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4gPiAgI2VuZGlmIC8qIF9f
SEFWRV9BUkNIX1BURVBfTU9ESUZZX1BST1RfVFJBTlNBQ1RJT04gKi8KPiA+ICAjZW5kaWYgLyog
Q09ORklHX01NVSAqLwo+ID4KPiA+ICsKPiA+ICsvKioKPiA+ICsgKiBzdHJ1Y3QgcHRkZXNjIC0g
TWVtb3J5IGRlc2NyaXB0b3IgZm9yIHBhZ2UgdGFibGVzLgo+ID4gKyAqIEBfX3BhZ2VfZmxhZ3M6
IFNhbWUgYXMgcGFnZSBmbGFncy4gVW51c2VkIGZvciBwYWdlIHRhYmxlcy4KPiA+ICsgKiBAcHRf
bGlzdDogTGlzdCBvZiB1c2VkIHBhZ2UgdGFibGVzLiBVc2VkIGZvciBzMzkwIGFuZCB4ODYuCj4g
PiArICogQF9wdF9wYWRfMTogUGFkZGluZyB0aGF0IGFsaWFzZXMgd2l0aCBwYWdlJ3MgY29tcG91
bmQgaGVhZC4KPiA+ICsgKiBAcG1kX2h1Z2VfcHRlOiBQcm90ZWN0ZWQgYnkgcHRkZXNjLT5wdGws
IHVzZWQgZm9yIFRIUHMuCj4gPiArICogQF9wdF9zMzkwX2dhZGRyOiBBbGlhc2VzIHdpdGggcGFn
ZSdzIG1hcHBpbmcuIFVzZWQgZm9yIHMzOTAgZ21hcCBvbmx5Lgo+ID4gKyAqIEBwdF9tbTogVXNl
ZCBmb3IgeDg2IHBnZHMuCj4gPiArICogQHB0X2ZyYWdfcmVmY291bnQ6IEZvciBmcmFnbWVudGVk
IHBhZ2UgdGFibGUgdHJhY2tpbmcuIFBvd2VycGMgYW5kIHMzOTAgb25seS4KPiA+ICsgKiBAcHRs
OiBMb2NrIGZvciB0aGUgcGFnZSB0YWJsZS4KPiA+ICsgKgo+ID4gKyAqIFRoaXMgc3RydWN0IG92
ZXJsYXlzIHN0cnVjdCBwYWdlIGZvciBub3cuIERvIG5vdCBtb2RpZnkgd2l0aG91dCBhIGdvb2QK
PiA+ICsgKiB1bmRlcnN0YW5kaW5nIG9mIHRoZSBpc3N1ZXMuCj4gPiArICovCj4gPiArc3RydWN0
IHB0ZGVzYyB7Cj4gPiArICAgICB1bnNpZ25lZCBsb25nIF9fcGFnZV9mbGFnczsKPiA+ICsKPiA+
ICsgICAgIHVuaW9uIHsKPiA+ICsgICAgICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCBwdF9saXN0
Owo+ID4gKyAgICAgICAgICAgICBzdHJ1Y3Qgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGxvbmcgX3B0X3BhZF8xOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBndGFibGVf
dCBwbWRfaHVnZV9wdGU7Cj4gPiArICAgICAgICAgICAgIH07Cj4gPiArICAgICB9Owo+ID4gKyAg
ICAgdW5zaWduZWQgbG9uZyBfcHRfczM5MF9nYWRkcjsKPiA+ICsKPiA+ICsgICAgIHVuaW9uIHsK
PiA+ICsgICAgICAgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqcHRfbW07Cj4gPiArICAgICAgICAg
ICAgIGF0b21pY190IHB0X2ZyYWdfcmVmY291bnQ7Cj4gPiArICAgICB9Owo+ID4gKwo+ID4gKyNp
ZiBBTExPQ19TUExJVF9QVExPQ0tTCj4gPiArICAgICBzcGlubG9ja190ICpwdGw7Cj4gPiArI2Vs
c2UKPiA+ICsgICAgIHNwaW5sb2NrX3QgcHRsOwo+ID4gKyNlbmRpZgo+ID4gK307Cj4KPiBJIHRo
aW5rIHlvdSBzaG91bGQgaW5jbHVkZSB0aGUgbWVtY2cgaGVyZSB0b28/IEl0IG5lZWRzIHRvIGJl
IHZhbGlkCj4gZm9yIGEgcHRkZXNjLCBldmVuIGlmIHdlIGRvbid0IGN1cnJlbnRseSBkZXJlZiBp
dCB0aHJvdWdoIHRoZSBwdGRlc2MKPiB0eXBlLgoKWWVzLCB0aGFua3MgZm9yIGNhdGNoaW5nIHRo
YXQhIEknbGwgYWRkIGl0IHRvIHY1LgoKPiBBbHNvLCBkbyB5b3Ugc2VlIGEgd2F5IHRvIHNvbWVk
YXkgcHV0IGEgJ3N0cnVjdCByY3VfaGVhZCcgaW50byBoZXJlPwoKRXZlbnR1YWxseSwgd2hlbiB0
aGV5J3JlIGJlaW5nIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBpbmRlcGVuZGVudCBvZgpzdHJ1Y3Qg
cGFnZS4gQWx0aG91Z2ggYXQgdGhhdCBwb2ludCBJJ20gbm90IHN1cmUgaWYgd2UnbGwgbmVlZCBv
bmUuCgo+IFRoYW5rcywKPiBKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=
