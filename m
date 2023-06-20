Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC17C001B3
	for <linux-um@archiver.kernel.org>; Tue, 20 Jun 2023 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ClZdcIQseZD/4l9Anx3aJ8YeafHFnFyEo4E18dVc4xY=; b=xtZ9XOJaUDBhg6
	5o/PK28u1rmn96fruOqkmqqZZY+yKq+ERBFCc0Z1zPSJxEtpOvuNRomdlqD8xlMvLcqjumx9KOyYX
	MmjsK9xdnky2Wc8le+02y/8ihZWuMBQm1A3zBUvpRfnDPh4TUf46mma2cPtHeIksMWyCvxBzonjjc
	ZzLZdRA7S2Z5bsXGcmsNjrOlmra/jHzDhcjUnc08pNRyOJrWkUA9W1DredYW60K4lOxssi+oSch0U
	pGQV7Pg9PwJasN1zQM/tC41r7ueUPMiO5kM0ogf4GWgGh4R7SMSFA76mdhMef+WdJ/QEK+W0QHrkJ
	/YqFbCVfPw1HjxrGMbuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBkUg-00CYRB-1T;
	Tue, 20 Jun 2023 23:10:38 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBkUc-00CYPb-1x;
	Tue, 20 Jun 2023 23:10:36 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5701eaf0d04so54950517b3.2;
        Tue, 20 Jun 2023 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687302633; x=1689894633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nozU+u202dwuRZdJGKz18i7nEQxa/ZPqnuIXPcARxTk=;
        b=Srt/QiH6vSlV6ltPf9H8KdAeCpbz7L591o99Craxfn8w/jM66I5hACYYF7kGTNoYRf
         37MNDI/F8R1g44q3mAPdvv0ch2USGp6Xr2QpXeRs4zwys088B20V4rigZMbQAUtCAcnv
         ujlqxNx2s65vbfsZd3k+2DjIHKhHJIWAfpgn7QYgmI+NGmP+FiWPPp675PKwGH44ORfj
         zOUT1l13zV/ZQbeHYvFRsincMrSLLgcM09n9imSEGZWNpBzKYFGwq1+DONOYFih8u36L
         jrVhBZXiCnjwgLIXcNbQ+C7KfkKQcJy9rAKazTyykVFlz02AVb/RzeIKJrXQdve86D2m
         bp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687302633; x=1689894633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nozU+u202dwuRZdJGKz18i7nEQxa/ZPqnuIXPcARxTk=;
        b=VsXADeBKxLI/vZsTrYsvm1ovAUikdxtIsowN92eb4SGEacYMwXbjtvH4sOWlYsYceE
         7P1XR0LQv/HZzQ+B2JvLfozichiqsnirLAIwWerEwc6TspLUVPqXwTlnS3w1A3+1XPBh
         rP/v0U6LKEJoAUFd4YvZObxqfUmZ0xMx1hztBwG+XiLPIHnLmYkofUGSOKLhHqoMea5d
         Zt6yIEBezKKjemTRP3RKgixbDW3T82T3K45mXdWjGOelK/S+QmdSJsbA2Ht43QYtIPUb
         at3f55qcr75XKyAAIIcj2kRMmmgghaNkX9TyNqcRmutrVp3eNjztRZPL1JXN/0qsI00z
         wt8w==
X-Gm-Message-State: AC+VfDx2mCnplg2v6MfQVdSGTh/PZOs5OENSBIOdZyPxonUMYKoTAPKw
	N8vNY1TJFmtnd3O2NdMhguFl35cT1M64MUQ7nM8=
X-Google-Smtp-Source: ACHHUZ7+vWx7il1X3ew5mkzUq07+yx6XfH7tiB7mbTeTUr9bW7PRwJQYCTYOe/jG083Yaru2U6b3dhZd45Wu7Dtq2+o=
X-Received: by 2002:a0d:dfcb:0:b0:570:89bf:6f10 with SMTP id
 i194-20020a0ddfcb000000b0057089bf6f10mr9653803ywe.25.1687302632746; Tue, 20
 Jun 2023 16:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <ZIxXw9ERkYv+ipdd@nvidia.com>
 <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com> <ZJIwpO68kc3zMB/c@nvidia.com>
In-Reply-To: <ZJIwpO68kc3zMB/c@nvidia.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 20 Jun 2023 16:10:22 -0700
Message-ID: <CAOzc2pwNc-9bRbAV8=_yROU5uq96q6v-dEfcYuzJyDrRygNsbA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230620_161034_659347_DA8466EB 
X-CRM114-Status: GOOD (  25.64  )
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

T24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgNDowNeKAr1BNIEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgMDE6MDE6MzlQTSAt
MDcwMCwgVmlzaGFsIE1vb2xhIHdyb3RlOgo+ID4gT24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgNToz
OOKAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBNb24sIEp1biAxMiwgMjAyMyBhdCAwMjowMzo1M1BNIC0wNzAwLCBWaXNoYWwgTW9vbGEg
KE9yYWNsZSkgd3JvdGU6Cj4gPiA+ID4gQ3VycmVudGx5LCBwYWdlIHRhYmxlIGluZm9ybWF0aW9u
IGlzIHN0b3JlZCB3aXRoaW4gc3RydWN0IHBhZ2UuIEFzIHBhcnQKPiA+ID4gPiBvZiBzaW1wbGlm
eWluZyBzdHJ1Y3QgcGFnZSwgY3JlYXRlIHN0cnVjdCBwdGRlc2MgZm9yIHBhZ2UgdGFibGUKPiA+
ID4gPiBpbmZvcm1hdGlvbi4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBN
b29sYSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4g
PiAgaW5jbHVkZS9saW51eC9wZ3RhYmxlLmggfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygr
KQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIv
aW5jbHVkZS9saW51eC9wZ3RhYmxlLmgKPiA+ID4gPiBpbmRleCBjNWE1MTQ4MWJiYjkuLjMzMGRl
OTZlYmZkNiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BndGFibGUuaAo+ID4g
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4gPiA+ID4gQEAgLTk3NSw2ICs5NzUs
NTcgQEAgc3RhdGljIGlubGluZSB2b2lkIHB0ZXBfbW9kaWZ5X3Byb3RfY29tbWl0KHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hLAo+ID4gPiA+ICAjZW5kaWYgLyogX19IQVZFX0FSQ0hfUFRFUF9N
T0RJRllfUFJPVF9UUkFOU0FDVElPTiAqLwo+ID4gPiA+ICAjZW5kaWYgLyogQ09ORklHX01NVSAq
Lwo+ID4gPiA+Cj4gPiA+ID4gKwo+ID4gPiA+ICsvKioKPiA+ID4gPiArICogc3RydWN0IHB0ZGVz
YyAtIE1lbW9yeSBkZXNjcmlwdG9yIGZvciBwYWdlIHRhYmxlcy4KPiA+ID4gPiArICogQF9fcGFn
ZV9mbGFnczogU2FtZSBhcyBwYWdlIGZsYWdzLiBVbnVzZWQgZm9yIHBhZ2UgdGFibGVzLgo+ID4g
PiA+ICsgKiBAcHRfbGlzdDogTGlzdCBvZiB1c2VkIHBhZ2UgdGFibGVzLiBVc2VkIGZvciBzMzkw
IGFuZCB4ODYuCj4gPiA+ID4gKyAqIEBfcHRfcGFkXzE6IFBhZGRpbmcgdGhhdCBhbGlhc2VzIHdp
dGggcGFnZSdzIGNvbXBvdW5kIGhlYWQuCj4gPiA+ID4gKyAqIEBwbWRfaHVnZV9wdGU6IFByb3Rl
Y3RlZCBieSBwdGRlc2MtPnB0bCwgdXNlZCBmb3IgVEhQcy4KPiA+ID4gPiArICogQF9wdF9zMzkw
X2dhZGRyOiBBbGlhc2VzIHdpdGggcGFnZSdzIG1hcHBpbmcuIFVzZWQgZm9yIHMzOTAgZ21hcCBv
bmx5Lgo+ID4gPiA+ICsgKiBAcHRfbW06IFVzZWQgZm9yIHg4NiBwZ2RzLgo+ID4gPiA+ICsgKiBA
cHRfZnJhZ19yZWZjb3VudDogRm9yIGZyYWdtZW50ZWQgcGFnZSB0YWJsZSB0cmFja2luZy4gUG93
ZXJwYyBhbmQgczM5MCBvbmx5Lgo+ID4gPiA+ICsgKiBAcHRsOiBMb2NrIGZvciB0aGUgcGFnZSB0
YWJsZS4KPiA+ID4gPiArICoKPiA+ID4gPiArICogVGhpcyBzdHJ1Y3Qgb3ZlcmxheXMgc3RydWN0
IHBhZ2UgZm9yIG5vdy4gRG8gbm90IG1vZGlmeSB3aXRob3V0IGEgZ29vZAo+ID4gPiA+ICsgKiB1
bmRlcnN0YW5kaW5nIG9mIHRoZSBpc3N1ZXMuCj4gPiA+ID4gKyAqLwo+ID4gPiA+ICtzdHJ1Y3Qg
cHRkZXNjIHsKPiA+ID4gPiArICAgICB1bnNpZ25lZCBsb25nIF9fcGFnZV9mbGFnczsKPiA+ID4g
PiArCj4gPiA+ID4gKyAgICAgdW5pb24gewo+ID4gPiA+ICsgICAgICAgICAgICAgc3RydWN0IGxp
c3RfaGVhZCBwdF9saXN0Owo+ID4gPiA+ICsgICAgICAgICAgICAgc3RydWN0IHsKPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRfcGFkXzE7Cj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHBndGFibGVfdCBwbWRfaHVnZV9wdGU7Cj4gPiA+ID4gKyAgICAg
ICAgICAgICB9Owo+ID4gPiA+ICsgICAgIH07Cj4gPiA+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBf
cHRfczM5MF9nYWRkcjsKPiA+ID4gPiArCj4gPiA+ID4gKyAgICAgdW5pb24gewo+ID4gPiA+ICsg
ICAgICAgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqcHRfbW07Cj4gPiA+ID4gKyAgICAgICAgICAg
ICBhdG9taWNfdCBwdF9mcmFnX3JlZmNvdW50Owo+ID4gPiA+ICsgICAgIH07Cj4gPiA+ID4gKwo+
ID4gPiA+ICsjaWYgQUxMT0NfU1BMSVRfUFRMT0NLUwo+ID4gPiA+ICsgICAgIHNwaW5sb2NrX3Qg
KnB0bDsKPiA+ID4gPiArI2Vsc2UKPiA+ID4gPiArICAgICBzcGlubG9ja190IHB0bDsKPiA+ID4g
PiArI2VuZGlmCj4gPiA+ID4gK307Cj4gPiA+Cj4gPiA+IEkgdGhpbmsgeW91IHNob3VsZCBpbmNs
dWRlIHRoZSBtZW1jZyBoZXJlIHRvbz8gSXQgbmVlZHMgdG8gYmUgdmFsaWQKPiA+ID4gZm9yIGEg
cHRkZXNjLCBldmVuIGlmIHdlIGRvbid0IGN1cnJlbnRseSBkZXJlZiBpdCB0aHJvdWdoIHRoZSBw
dGRlc2MKPiA+ID4gdHlwZS4KPiA+Cj4gPiBZZXMsIHRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhhdCEg
SSdsbCBhZGQgaXQgdG8gdjUuCj4gPgo+ID4gPiBBbHNvLCBkbyB5b3Ugc2VlIGEgd2F5IHRvIHNv
bWVkYXkgcHV0IGEgJ3N0cnVjdCByY3VfaGVhZCcgaW50byBoZXJlPwo+ID4KPiA+IEV2ZW50dWFs
bHksIHdoZW4gdGhleSdyZSBiZWluZyBkeW5hbWljYWxseSBhbGxvY2F0ZWQgaW5kZXBlbmRlbnQg
b2YKPiA+IHN0cnVjdCBwYWdlLiBBbHRob3VnaCBhdCB0aGF0IHBvaW50IEknbSBub3Qgc3VyZSBp
ZiB3ZSdsbCBuZWVkIG9uZS4KPgo+IFNvb25lciB0aGFuIGR5bmFtaWMgc3RydWN0IHBhZ2U/Cj4K
PiBQcm9iYWJseSBpdCBjYW4gb3ZlcmxhcCBwdF9saXN0IGluIGFsb3Qgb2YgYXJjaGVzPwoKQWgg
eWVzLCB0aGVyZSB3aWxsIGJlIG9uZSBpZiB2NSBvdmVybGFwcGluZyB3aXRoIHB0X2xpc3QKKGl0
IGFscmVhZHkgZG9lcyBpbiBzdHJ1Y3QgcGFnZSBhbnl3YXlzKS4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K
