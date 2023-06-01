Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFD0C7EE37
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lZlToBXOMB4IHhFEotNKyVCbT4QXbInQIR21Ot2DDS4=; b=UJSBX6tuijikQt
	lLiP1qhHhOwWv/LGHFSwyMlZdvuyZnpHtEdxfMwjmRsWJYzyu6/HeQFrbSvesru5k3KofCPYdObmb
	pb1ub/xl1TW5Z3qtfyvR5Tz7+TpHlctevcdRNVwVdH+HW1hEVlK+i43EhYR9XkNL5SotbFuMoIjKI
	bxMhgG5LqEE2grY9VzxKhDEC08p2WD5okh80q72irRnDfjP8xVL0N51+3gFy+NwOlZidr7dlasj6d
	quS7hcsSCrF4sYbyBzYWgLOq/TjcwaZmla/7qX65JKr2SqqLQYUVhkjYuq29yyBZFlJiFZHXYoDc2
	S0munJJV2IG+K2PQcQGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4p90-004tkV-0e;
	Thu, 01 Jun 2023 20:43:38 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4p8w-004thu-1P;
	Thu, 01 Jun 2023 20:43:35 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cd2fc9acso13404507b3.0;
        Thu, 01 Jun 2023 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685652211; x=1688244211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1D8lVOaAVBWbT9t2RmOD+26281abLHxtrNSt32Ap24=;
        b=qLgbJbj5g8WGk9vr+h5GU3VAGYoZuUQfYy+Jk03a6BWdaBQStekzq99EEhSRb/apVE
         r1wG5klq4xTuvlp4fzfvGwGvXsPOH5Z+EGzZ3xDm5VuokYBfnX2Z7EeXpvrNqoMOmFfA
         JBLO6CGLz8pEI44d71tWawLxUIyiVrcZLnzOInnX4NDx0adjPFt4WqdjoFpvwTeJeP42
         YdR8VtfFc5+TjUwWFHzsShyWmg/NGqDFZTc1nDT9EKaeGOrhYp9pTMhkn6c++xEXcw0Z
         7/JenW6z+3FLVb69Ur5a6g5NHDXYEBFsl6KltuWvHl5pgiI7Ar5zj9KICtB4zwOfTiPP
         PMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652211; x=1688244211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1D8lVOaAVBWbT9t2RmOD+26281abLHxtrNSt32Ap24=;
        b=XKGzHbVFW8pTVzSA8JlUKTelcNBRZSRe1zc6Wn9gv0vV/xMRWhLV9m1Bb2d10gfVW+
         oHGBDv3OGaEeU/ZnFdhgCQMIZtJ1MPJPjgFyrckTjsswABhtDBQc36RMbAUIdtvNzIA3
         s1Yux4U8YjfVR623zXcG24l/2B01MISW+ieLC8+N28SMkmafOm6zJN63KJX+SEkF5Ftu
         hHEqiPG5E+Ao5io8ktsgYt/ca3atkfOQTU1HzVl8aU+uqAR37S/d/5UwuoUJWUIVcRLZ
         5IQicqtK7HA9QSpSOanG+5c1GSHi29n3wt88qgQC+CFObQr+IMb/wCOP2+RlDY7DvpFs
         sXhA==
X-Gm-Message-State: AC+VfDxGRPY8OCuTt/SO7OKuWHHmM9F7PD2wWrEKU7GcJC4Qm/MRJoU3
	CuuZ8V9mBRmL9uTVSqtb7tnrq6A32ByPLUoxOAk=
X-Google-Smtp-Source: ACHHUZ5DfuhGus+PqmBDfDw3I8CUwiopOPmtEZnOXp6mFa4otjE0OnORW5aklQp2qVjtyKAx2ImFFxSDC1ok71Q6xew=
X-Received: by 2002:a0d:e84b:0:b0:565:f045:18c3 with SMTP id
 r72-20020a0de84b000000b00565f04518c3mr10614817ywe.20.1685652211220; Thu, 01
 Jun 2023 13:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-4-vishal.moola@gmail.com> <20230601151900.6f184e8c@thinkpad-T15>
In-Reply-To: <20230601151900.6f184e8c@thinkpad-T15>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 1 Jun 2023 13:43:20 -0700
Message-ID: <CAOzc2pyjLh_GV1PL7CPkkPGcASHULhir_rJgB+UhwzPgQZD8Bw@mail.gmail.com>
Subject: Re: [PATCH v3 03/34] s390: Use pt_frag_refcount for pagetables
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hugh Dickins <hughd@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_134334_474863_9D57B30E 
X-CRM114-Status: GOOD (  23.16  )
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

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCA2OjE54oCvQU0gR2VyYWxkIFNjaGFlZmVyCjxnZXJhbGQu
c2NoYWVmZXJAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4KPiAgT24gV2VkLCAzMSBNYXkgMjAyMyAx
NDozMDowMSAtMDcwMAo+ICJWaXNoYWwgTW9vbGEgKE9yYWNsZSkiIDx2aXNoYWwubW9vbGFAZ21h
aWwuY29tPiB3cm90ZToKPgo+ID4gczM5MCBjdXJyZW50bHkgdXNlcyBfcmVmY291bnQgdG8gaWRl
bnRpZnkgZnJhZ21lbnRlZCBwYWdlIHRhYmxlcy4KPiA+IFRoZSBwYWdlIHRhYmxlIHN0cnVjdCBh
bHJlYWR5IGhhcyBhIG1lbWJlciBwdF9mcmFnX3JlZmNvdW50IHVzZWQgYnkKPiA+IHBvd2VycGMs
IHNvIGhhdmUgczM5MCB1c2UgdGhhdCBpbnN0ZWFkIG9mIHRoZSBfcmVmY291bnQgZmllbGQgYXMg
d2VsbC4KPiA+IFRoaXMgaW1wcm92ZXMgdGhlIHNhZmV0eSBmb3IgX3JlZmNvdW50IGFuZCB0aGUg
cGFnZSB0YWJsZSB0cmFja2luZy4KPiA+Cj4gPiBUaGlzIGFsc28gYWxsb3dzIHVzIHRvIHNpbXBs
aWZ5IHRoZSB0cmFja2luZyBzaW5jZSB3ZSBjYW4gb25jZSBhZ2FpbiB1c2UKPiA+IHRoZSBsb3dl
ciBieXRlIG9mIHB0X2ZyYWdfcmVmY291bnQgaW5zdGVhZCBvZiB0aGUgdXBwZXIgYnl0ZSBvZiBf
cmVmY291bnQuCj4KPiBUaGlzIHdvdWxkIGNvbmZsaWN0IHdpdGggczM5MCBpbXBhY3Qgb2YgcHRl
X2ZyZWVfZGVmZXIoKSB3b3JrIGZyb20gSHVnaCBEaWNraW5zCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8zNWU5ODNmNS03ZWQzLWIzMTAtZDk0OS05YWU4YjEzMGNkYWJAZ29vZ2xlLmNv
bS8KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzZkZDYzYjM5LWU3MWYtMmU4Yi03ZTAt
ODNlMDJmM2JjYjM5QGdvb2dsZS5jb20vCj4KPiBUaGVyZSBoZSB1c2VzIHB0X2ZyYWdfcmVmY291
bnQsIG9yIHJhdGhlciBwdF9tbSBpbiB0aGUgc2FtZSB1bmlvbiwgdG8gc2F2ZQo+IHRoZSBtbV9z
dHJ1Y3QgZm9yIGRlZmVycmVkIHB0ZV9mcmVlKCkuCj4KPiBJIHN0aWxsIG5lZWQgdG8gbG9vayBj
bG9zZXIgaW50byBib3RoIG9mIHlvdXIgcGF0Y2ggc2VyaWVzLCBidXQgc28gZmFyIGl0Cj4gc2Vl
bXMgdGhhdCB5b3UgaGF2ZSBubyBoYXJkIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQgdG8gc3dpdGNo
IGZyb20gX3JlZmNvdW50Cj4gdG8gcHRfZnJhZ19yZWZjb3VudCBoZXJlLCBmb3IgczM5MC4KPgo+
IElmIHRoaXMgaXMgY29ycmVjdCwgYW5kIHlvdSBkbyBub3QgZS5nLiBuZWVkIHRoaXMgdG8gbWFr
ZSBzb21lIG90aGVyIHVzZQo+IG9mIF9yZWZjb3VudCwgSSB3b3VsZCBzdWdnZXN0IHRvIGRyb3Ag
dGhpcyBwYXRjaC4KClRoZSBnb2FsIG9mIHRoaXMgcHJlcGFyYXRpb24gcGF0Y2ggaXMgdG8gY29u
c29saWRhdGUgczM5MCdzIHVzYWdlIG9mCnN0cnVjdCBwYWdlIGZpZWxkcyBzbyB0aGF0IHN0cnVj
dCBwdGRlc2MgY2FuIGJlIHNtYWxsZXIuIEl0cyBub3QgcGFydGljdWxhcmx5Cm1hbmRhdG9yeTsg
bGVhdmluZyBfcmVmY291bnQgaW4gcHRkZXNjIG9ubHkgaW5jcmVhc2VzIHRoZSBzdHJ1Y3QgYnkK
OCBieXRlcyBhbmQgY2FuIGFsd2F5cyBiZSBjaGFuZ2VkIGxhdGVyLgoKSG93ZXZlciBpdCBpcyBh
IGxpdHRsZSBhbm5veWluZyBzaW5jZSBzMzkwIGlzIHRoZSBvbmx5IGFyY2hpdGVjdHVyZQp0aGF0
IGVncmVnaW91c2x5IHVzZXMgc3BhY2UgdGhyb3VnaG91dCBzdHJ1Y3QgcGFnZSBmb3IgdGhlaXIg
cGFnZQp0YWJsZXMsIHJhdGhlciB0aGFuIGp1c3QgdGhlIHBhZ2UgdGFibGUgc3RydWN0LiBGb3Ig
ZXhhbXBsZSwgczM5MApnbWFwIHVzZXMgcGFnZS0+aW5kZXggd2hpY2ggYWxzbyBhbGlhc2VzIHdp
dGggcHRfbW0gYW5kCnB0X2ZyYWdfcmVmY291bnQuIEknbSBub3Qgc3VyZSBpZi9ob3cgZ21hcCBw
YWdlIHRhYmxlcyBpbnRlcmFjdAp3aXRoIHMzOTAgcHJvY2VzcyBwYWdlIHRhYmxlcyBhdCBhbGws
IGJ1dCBpZiBpdCBkb2VzIHRoYXQgY291bGQKcG90ZW50aWFsbHkgY2F1c2UgcHJvYmxlbXMgd2l0
aCBIdWdoJ3MgcGF0Y2ggYXMgd2VsbCA6KAoKSSBjYW4gYWRkIF9yZWZjb3VudCB0byBwdGRlc2Mg
aWYgd2Ugd291bGQgbGlrZSwgYnV0IEkgc3RpbGwKcHJlZmVyIGlmIHMzOTAgY291bGQgYmUgc2lt
cGxpZmllZCBpbnN0ZWFkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
