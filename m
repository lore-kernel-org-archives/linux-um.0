Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7BCC77B73
	for <linux-um@archiver.kernel.org>; Thu, 20 Apr 2023 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5EGeuztByfFo3QviL1J1l25wTMGXvkhE0nrTmjsCe1w=; b=kRtF6N5q9iFzLk
	rVmCZCUNcH7PGOLpKKk/VE165iE4Ba5TtbGZEdeqj2xuF+KsoC5XSlhm00/4wRCNtLL9BOJuIRNtj
	i6yxG5Q9LR4p71hVzNxWOXaa8QHCcHLQnXIwnb+axXO2bkV2d/Qg13CIN/2gFUWh+iPqOcRuaV2rd
	Dxn01Grf0QvWbVOyzIykEXGt9oIXO+Dq7+EmRJl9BAQ5arHni7O3SQW6YVn3N+JvJQqgqD0ZDyHSX
	pnuetA2UZoc5jxj2x9OdZ5BfSvDbIhXTwDnSYPDiF8YtjnuF/DusfwQlFoYwLXbQH1SVQB7zHYu6o
	t4t/dUoekSDznh+FoPpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppdm1-009Gim-0X;
	Thu, 20 Apr 2023 23:33:09 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppdlw-009Ggv-1o;
	Thu, 20 Apr 2023 23:33:06 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54f6f0dae19so2183137b3.0;
        Thu, 20 Apr 2023 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033582; x=1684625582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2ixoAK9D3BuA0Ys9lwnMZMdyz2nW/UTyxM+6NXzqI=;
        b=AX4YGgPJjZWyR0kqu580/PVasSF+uNRiA7gr7gHqMdE/2vLkFpdjQpKmKbwxnvzy1W
         4jX/DWRv14Hh6L+AuqxNt9TrfsVNFOA+DMslH6msB9ssOPuKNdU5LH4UlZNRkrQgi/yF
         2C7UqT75y8+OehNqUJfsf2nClBSiv3rZRBTIf/8qXrl8xEYNdOg0mllWNN17Cw7o+BHc
         Dv7TVavT6/AGmzCH4d7Tksroa3F14WaPTNTcwjLqhrbimQGYJu8Di4n0FcYkgCSZZuxf
         BRI5CuXSQtBQDqv2Sdnh5lzey/n44xr+tGNe/P6HPq7sE+h81UtCj457v+cM+mPjpeEU
         pLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033582; x=1684625582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN2ixoAK9D3BuA0Ys9lwnMZMdyz2nW/UTyxM+6NXzqI=;
        b=NSsh+NxRZITgH4qxl/whNl54HhuaUr4DTtJrrzG2+yq9nxVC8VeTq39amorQz8CF1A
         p3Nu+iwiGypA5NyHoR+jYKoRfzZPRkOtzju3juHxjfwaaq7UlNwGViDjt5Jb0kyigQb6
         yGARGxCZlg9C01w5j/g+Tjp25fN/H37+7mdHYUSS1ab4ARzVJprCDYR4h1QV2I6AxzUK
         Qow0iXLWyoK0KNKJERvIlCJ5nPdJXF4LDCo/SFuTC+PsmNAYLmInbKfSTYArCztK5TmK
         1DN8gDcuvQ8AK9EDot4LCc8m1rijGh6v1Tz9o0Ctyrq2AsH385yYciyyFtbBbeO4EH4D
         byoA==
X-Gm-Message-State: AAQBX9dVgOMK2hyKhpDDX6zyYC/eqjnN8gzRNTshYv6rhieZb69uhADt
	xGkKaIerCBbbvaFIl/0e14bQ7d38hMb+Ezh4rQ0=
X-Google-Smtp-Source: AKy350bopqnJQtT+418DUBi5UUf4Yx/MaaBIpccKeoXBRimnuUzPebu61FMjyfXCRvipIUnUp3uBwA4Azmrc32p/hx0=
X-Received: by 2002:a0d:f205:0:b0:541:8810:8d7b with SMTP id
 b5-20020a0df205000000b0054188108d7bmr466003ywf.15.1682033581993; Thu, 20 Apr
 2023 16:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com> <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
 <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com> <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
In-Reply-To: <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 20 Apr 2023 16:32:50 -0700
Message-ID: <CAOzc2pwDtn836Tf0Egh+Z258hxSTVtvwuyU2qiJa1iLa6vZFjQ@mail.gmail.com>
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
To: David Hildenbrand <david@redhat.com>
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
X-CRM114-CacheID: sfid-20230420_163304_615592_8B090289 
X-CRM114-Status: GOOD (  35.80  )
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgMTI6NTTigK9BTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiAxOC4wNC4yMyAyMzozMywgVmlzaGFsIE1vb2xh
IHdyb3RlOgo+ID4gT24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgODo0NeKAr0FNIERhdmlkIEhpbGRl
bmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToKPiA+Pgo+ID4+IE9uIDE3LjA0LjIzIDIy
OjUwLCBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4gPj4+IHMzOTAgdXNlcyBwYWdlLT5p
bmRleCB0byBrZWVwIHRyYWNrIG9mIHBhZ2UgdGFibGVzIGZvciB0aGUgZ3Vlc3QgYWRkcmVzcwo+
ID4+PiBzcGFjZS4gSW4gYW4gYXR0ZW1wdCB0byBjb25zb2xpZGF0ZSB0aGUgdXNhZ2Ugb2YgcGFn
ZSBmaWVsZHMgaW4gczM5MCwKPiA+Pj4gcmVwbGFjZSBfcHRfcGFkXzIgd2l0aCBfcHRfczM5MF9n
YWRkciB0byByZXBsYWNlIHBhZ2UtPmluZGV4IGluIGdtYXAuCj4gPj4+Cj4gPj4+IFRoaXMgd2ls
bCBoZWxwIHdpdGggdGhlIHNwbGl0dGluZyBvZiBzdHJ1Y3QgcHRkZXNjIGZyb20gc3RydWN0IHBh
Z2UsIGFzCj4gPj4+IHdlbGwgYXMgYWxsb3cgczM5MCB0byB1c2UgX3B0X2ZyYWdfcmVmY291bnQg
Zm9yIGZyYWdtZW50ZWQgcGFnZSB0YWJsZQo+ID4+PiB0cmFja2luZy4KPiA+Pj4KPiA+Pj4gU2lu
Y2UgcGFnZS0+X3B0X3MzOTBfZ2FkZHIgYWxpYXNlcyB3aXRoIG1hcHBpbmcsIGVuc3VyZSBpdHMg
c2V0IHRvIE5VTEwKPiA+Pj4gYmVmb3JlIGZyZWVpbmcgdGhlIHBhZ2VzIGFzIHdlbGwuCj4gPj4+
Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xh
QGdtYWlsLmNvbT4KPiA+Pj4gLS0tCj4gPj4KPiA+PiBbLi4uXQo+ID4+Cj4gPj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmggYi9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmgK
PiA+Pj4gaW5kZXggM2ZjOWU2ODBmMTc0Li4yNjE2ZDY0YzBlOGMgMTAwNjQ0Cj4gPj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaAo+ID4+PiArKysgYi9pbmNsdWRlL2xpbnV4L21tX3R5
cGVzLmgKPiA+Pj4gQEAgLTE0NCw3ICsxNDQsNyBAQCBzdHJ1Y3QgcGFnZSB7Cj4gPj4+ICAgICAg
ICAgICAgICAgIHN0cnVjdCB7ICAgICAgICAvKiBQYWdlIHRhYmxlIHBhZ2VzICovCj4gPj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRfcGFkXzE7ICAgICAgICAvKiBj
b21wb3VuZF9oZWFkICovCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgcGd0YWJsZV90IHBt
ZF9odWdlX3B0ZTsgLyogcHJvdGVjdGVkIGJ5IHBhZ2UtPnB0bCAqLwo+ID4+PiAtICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRfcGFkXzI7ICAgICAgICAvKiBtYXBwaW5nICov
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIF9wdF9zMzkwX2dhZGRy
OyAgIC8qIG1hcHBpbmcgKi8KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICB1bmlvbiB7Cj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICpwdF9t
bTsgLyogeDg2IHBnZHMgb25seSAqLwo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYXRvbWljX3QgcHRfZnJhZ19yZWZjb3VudDsgLyogcG93ZXJwYyAqLwo+ID4+Cj4gPj4gVGhl
IGNvbmZ1c2luZyBwYXJ0IGlzLCB0aGF0IHRoZXNlIGdtYXAgcGFnZSB0YWJsZXMgYXJlIG5vdCBv
cmRpbmFyeQo+ID4+IHByb2Nlc3MgcGFnZSB0YWJsZXMgdGhhdCB3ZSB3b3VsZCBvcmRpbmFyaWx5
IHBsYWNlIGludG8gdGhpcyBzZWN0aW9uCj4gPj4gaGVyZS4gVGhhdCdzIHdoeSB0aGV5IGFyZSBh
bHNvIG5vdCBhbGxvY2F0ZWQvZnJlZWQgdXNpbmcgdGhlIHR5cGljYWwKPiA+PiBwYWdlIHRhYmxl
IGNvbnN0cnVjdG9yL2Rlc3RydWN0b3IgLi4uCj4gPgo+ID4gSSBpbml0aWFsbHkgdGhvdWdodCB0
aGUgc2FtZSwgc28gSSB3YXMgcXVpdGUgY29uZnVzZWQgd2hlbiBJIHNhdwo+ID4gX19nbWFwX3Nl
Z21lbnRfZ2FkZHIgd2FzIHVzaW5nIHBtZF9wZ3RhYmxlX3BhZ2UoKS4KPiA+Cj4gPiBBbHRob3Vn
aCB0aGV5IGFyZSBub3Qgb3JkaW5hcnkgcHJvY2VzcyBwYWdlIHRhYmxlcywgc2luY2Ugd2UKPiA+
IGV2ZW50dWFsbHkgd2FudCB0byBtb3ZlIHRoZW0gb3V0IG9mIHN0cnVjdCBwYWdlLCBJIHRoaW5r
IHNoaWZ0aW5nIHRoZW0KPiA+IHRvIGJlIGluIHB0ZGVzY3MsIGJlaW5nIGEgbWVtb3J5IGRlc2Ny
aXB0b3IgZm9yIHBhZ2UgdGFibGVzLCBtYWtlcwo+ID4gdGhlIG1vc3Qgc2Vuc2UuCj4KPiBTZWVp
bmcgdXRpbGl0aWVzIGxpa2UgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYygpIHRoYXQgZG9uJ3QgcmVh
bGx5IGFwcGx5Cj4gdG8gc3VjaCBwYWdlIHRhYmxlcywgSSB3b25kZXIgaWYgd2Ugc2hvdWxkIG11
Y2ggcmF0aGVyIHRyZWF0IHN1Y2gKPiBzaGFkb3cvYXV4aWxpYXJ5Ly4uLiBwYWdlIHRhYmxlcyAo
anVzdCBsaWtlIG90aGVyIGFyY2hpdGVjdHVyZXMgbGlrZQo+IHg4NiwgYXJtLCAuLi4gZW1wbG95
IGFzIHdlbGwpIGFzIGEgZGlzdGluY3QgdHlwZS4KPgo+IEFuZCBoYXZlIHB0ZGVzYyBiZSB0aGUg
Y29tbW9uIHR5cGUgZm9yIGFsbCBwcm9jZXNzIHBhZ2UgdGFibGVzLgoKQWx0aG91Z2ggSSBkbyBs
aWtlIHRoZSBpZGVhIG9mIGhhdmluZyBhIGRpc3RpbmN0IHR5cGUgZm9yIHRoZW0sIEknbSBub3Qg
c3VyZQpJIHNlZSB0aGUgbWVyaXRzIG9mIGhhdmluZyBhbm90aGVyIHR5cGUgc3BlY2lmaWNhbGx5
IGZvciB0aG9zZSB0eXBlcyBvZgpwYWdlIHRhYmxlcy4KCkFzIGl0IGN1cnJlbnRseSBpcywgdGxi
X3JlbW92ZV90YWJsZSgpIGlzIG9ubHkgZGlzdGluY3QgZnJvbSB0bGJfcmVtb3ZlX3BhZ2UoKQp3
aGVuIGFuIGFyY2hpdGVjdHVyZSBkZWZpbmVzIGl0cyBvd24gcmVtb3ZhbCBmdW5jdGlvbi4gSSdt
IG5vdCB0b28gZmFtaWxpYXIKd2l0aCBtb3N0IG9mIHRoZWlyIGRpZmZlcmVuY2VzLCBidXQgd2Ug
Y2FuIHByb2JhYmx5IGNvbnRpbnVlIHRvIGxldCB0aGVtIGRvCnRoYXQuIEFzIG9mIG5vdywgSSdt
IG5vdCB0b28gc3VyZSB3aGF0IGEgZGlzdGluY3QgdHlwZSB3b3VsZCBsb29rIGxpa2UgdGhhdApj
b3VsZCBtZWV0IGFsbCB0aGVpciBuZWVkcyBob2xpc3RpY2FsbHkuCgo+ID4KPiA+IEFub3RoZXIg
b3B0aW9uIGlzIHRvIGxlYXZlIHBtZF9wZ3RhYmxlX3BhZ2UoKSBhcyBpcyBqdXN0IGZvciB0aGlz
IGNhc2UuCj4gPiBPciB3ZSBjYW4gcmV2ZXJ0IGNvbW1pdCA3ZTI1ZGU3N2JjNWVhIHdoaWNoIHVz
ZXMgdGhlIGZ1bmN0aW9uIGhlcmUKPiA+IHRoZW4gZmlndXJlIG91dCB3aGVyZSB0aGVzZSBnbWFw
IHBhZ2VzIHRhYmxlIHBhZ2VzIHdpbGwgZ28gbGF0ZXIuCj4KPiBJJ20gYWx3YXlzIGNvbmZ1c2Vk
IHdoZW4gcmVhZGluZyBnbWFwIGNvZGUsIHNvIGxldCBtZSBoYXZlIGFub3RoZXIgbG9vayA6KQo+
Cj4gVGhlIGNvbmZ1c2luZyBwYXJ0IGlzIHRoYXQgczM5MHggc2hhcmVzIHRoZSBsb3dlc3QgbGV2
ZWwgcGFnZSB0YWJsZXMKPiAoUFRFIHRhYmxlcykgYmV0d2VlbiB0aGUgcHJvY2VzcyBhbmQgZ21h
cCAoImd1ZXN0IG1hcHBpbmciLCBzaW1pbGFyIHRvCj4gRVBUIG9uIHg4Ni02NCkuIEl0IG1hcHMg
dGhlc2UgcHJvY2VzcyBQVEUgdGFibGVzIChjb3ZlcmluZyAxIE1pQikgaW50bwo+IGdtYXAtc3Bl
Y2lmaWMgUE1EIHRhYmxlcy4KCkVzcGVjaWFsbHkgaW4gY2FzZXMgbGlrZSB0aGlzLiBJZiB0aGUg
YXJjaGl0ZWN0dXJlIHdhbnRzIHRvIHNoYXJlIHBhZ2UgdGFibGVzCnRoZW4gZXZlcnl0aGluZyBi
ZWluZyBpbiBmb3JtIHB0ZGVzYyB3b3VsZCBtYWtlIHRoYXQgZWFzaWVzdCwgYW5kCmNvbnRpbnVl
IHRvIGxldCB0aGVtIGRlZmluZSB0aGVpciBvd24gbmljaGUgZnVuY3Rpb25zIGZvciB0aGVpciBu
ZWVkcy4KCj4gcG1kX3BndGFibGVfcGFnZSgpIHNob3VsZCBpbmRlZWQgYWx3YXlzIGdpdmUgdXMg
YSBnbWFwLXNwZWNpZmljCj4gUE1ELXRhYmxlLiBJbiBmYWN0LCBzb21ldGhpbmcgYWxsb2NhdGVk
IHZpYSBnbWFwX2FsbG9jX3RhYmxlKCkuCj4KPiBEZWNvdXBsaW5nIGJvdGggY29uY2VwdHMgc291
bmRzIGxpa2UgYSBnb29kIGlkZWEuCgpZZWFoLCBJJ20gbm90IGEgZmFuIG9mIGhvdyB0aGlzIGdt
YXAgY2FsbGVyIGlzIHRoZSBvbmx5IGV4dGVybmFsIGNhbGxlcgp1c2luZyB0aGlzIHRvIGdldCBh
IHBhZ2UgZm9yIHRoZWlyIG93biBwdXJwb3Nlcy4gSSdsbCB1cGRhdGUgdGhhdCBpbiB2Mi4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
