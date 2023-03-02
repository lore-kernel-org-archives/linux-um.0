Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADB0C6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPocJTlKjQtWVmkfMkKFm/4iG/QZeYAN0vU6FsA3XoY=; b=QPPqAMDG/KFZAA
	h8zpfMhfEtwsUc8MDY7C2g/+evGyxWki/aIcbM1LZjQD5ckgrEiwwI7f1wqs8vfhM1R7FbKMI2SRv
	N1Zj+L51NrrIXKk6qZOeWgbRMXmuWyiVLVY2EUFu6xLIw1g0WQfvX1l6JGqTLFCsFUZSY3Euzo8At
	udyGe4cUXuhCpPGTHzTgqP/0HR2MNhP48RfW4LKk5CW+sRaH/Fwutaz7698r8ZKDw/5NN4oE/T48C
	qv07ezsymNm87+FkdyW19NuppsQAdHcVZUOvcgMurpoeyeDtDE2t2JsfQ8txxqCu3V2acXe+xuH3O
	+DFbgVHpa06Gg3jpK8+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXpOA-003F1n-3O; Thu, 02 Mar 2023 20:18:54 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXpO6-003F1N-UP
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 20:18:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 092A2B815BE
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 20:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA478C433A0
	for <linux-um@lists.infradead.org>; Thu,  2 Mar 2023 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677788327;
	bh=/Yn3UcMdQ1GXWH06I63xFkYGrZyXxsIhd8sDdU/N+rU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3pI84K0PNBtKG1nQ9HGZ6kbE153E/SPIRWB3OJArdOlrjEGtVCXZ3xXkoOEj86On
	 TxM99XZA4Mj88eHESIOKaet/GYTAVuYwP6NLi6JEayM2rWcTJsp3Kefqm9UGQDg681
	 4p2iTjbJ1sc+bKGIknarjbzBDsubDF67/wgUez3qtElsuJFSxHyiQ1MdJ4vmsIbgXT
	 ufMQpB3K2m2YZLE1n4IodBAM0uYyxQcKgdpWKKuy7uo1/n7xiYxc4HaKYo7tyN+YJP
	 7WcTrrCyQYFTNy/Fie+Yl2vjzW1mtAnwhoJV+mmymjLkmlK+akoh1+AnsRKclhdZcS
	 6UnxrOQTGDjGQ==
Received: by mail-vs1-f45.google.com with SMTP id a3so497611vsi.0
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 12:18:47 -0800 (PST)
X-Gm-Message-State: AO0yUKU/ejeW7KuppF/4tAC5O+KnxUWf6CFbER6fmzUTGWp6Jh2tWUkK
	5aKHb4QU7U6Vt7G3B0hD+BoaTGIULXhJzOORBQ==
X-Google-Smtp-Source: AK7set8CdZkV4nzAcxJAbmUjGudJ4PuiuPCHsE83ibLSseGKCb8fkRaEA/lrtnQAVCyfd8eCj0HxtuGm3QHjodqLBCw=
X-Received: by 2002:a05:6102:184:b0:414:4ef2:b607 with SMTP id
 r4-20020a056102018400b004144ef2b607mr7202543vsq.6.1677788326407; Thu, 02 Mar
 2023 12:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
In-Reply-To: <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 2 Mar 2023 14:18:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
Message-ID: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Frank Rowand <frowand.list@gmail.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_121851_316110_A03370C5 
X-CRM114-Status: GOOD (  45.48  )
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCAxOjQ04oCvUE0gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IFF1b3RpbmcgUm9iIEhlcnJpbmcgKDIwMjMtMDMtMDIgMDk6MTM6
NTkpCj4gPiBPbiBXZWQsIE1hciAxLCAyMDIzIGF0IDc6MzjigK9QTSBTdGVwaGVuIEJveWQgPHNi
b3lkQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRz
IHVuaXQgdGVzdHMgZm9yIHRoZSBjbGsgZml4ZWQgcmF0ZSBiYXNpYyB0eXBlIGFuZAo+ID4gPiB0
aGUgY2xrIHJlZ2lzdHJhdGlvbiBmdW5jdGlvbnMgdGhhdCB1c2Ugc3RydWN0IGNsa19wYXJlbnRf
ZGF0YS4gVG8gZ2V0Cj4gPiA+IHRoZXJlLCB3ZSBhZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBhIERU
QiBpbnRvIHRoZSBVTUwga2VybmVsIHRoYXQncwo+ID4gPiBydW5uaW5nIHRoZSB1bml0IHRlc3Rz
IGFsb25nIHdpdGggcHJvYmluZyBwbGF0Zm9ybSBkcml2ZXJzIHRvIGJpbmQgdG8KPiA+ID4gZGV2
aWNlIG5vZGVzIHNwZWNpZmllZCBpbiBEVC4KPiA+ID4KPiA+ID4gV2l0aCB0aGlzIHNlcmllcywg
d2UncmUgYWJsZSB0byBleGVyY2lzZSBzb21lIG9mIHRoZSBjb2RlIGluIHRoZSBjb21tb24KPiA+
ID4gY2xrIGZyYW1ld29yayB0aGF0IHVzZXMgZGV2aWNldHJlZSBsb29rdXBzIHRvIGZpbmQgcGFy
ZW50cyBhbmQgdGhlIGZpeGVkCj4gPiA+IHJhdGUgY2xrIGNvZGUgdGhhdCBzY2FucyBkZXZpY2V0
cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNsa3MuIFBsZWFzZQo+ID4gPiByZXZpZXcuCj4gPiA+
Cj4gPiA+IEkgQ2NlZCBldmVyeW9uZSB0byBhbGwgdGhlIHBhdGNoZXMgc28gdGhleSBnZXQgdGhl
IGZ1bGwgY29udGV4dC4gSSdtCj4gPiA+IGhvcGluZyBJIGNhbiB0YWtlIHRoZSB3aG9sZSBwaWxl
IHRocm91Z2ggdGhlIGNsayB0cmVlIGFzIHRoZXkgYWxtb3N0IGFsbAo+ID4gPiBkZXBlbmQgb24g
ZWFjaCBvdGhlci4gSW4gdGhlIGZ1dHVyZSBJIGltYWdpbmUgaXQgd2lsbCBiZSBlYXN5IHRvIGFk
ZAo+ID4gPiBtb3JlIHRlc3Qgbm9kZXMgdG8gdGhlIGNsay5kdHNpIGZpbGUgYW5kIG5vdCBuZWVk
IHRvIGdvIGFjcm9zcyB2YXJpb3VzCj4gPiA+IG1haW50YWluZXIgdHJlZXMgbGlrZSB0aGlzIHNl
cmllcyBkb2VzLgo+ID4gPgo+ID4gPiBTdGVwaGVuIEJveWQgKDgpOgo+ID4gPiAgIGR0LWJpbmRp
bmdzOiBBZGQgbGludXgsa3VuaXQgYmluZGluZwo+ID4gPiAgIG9mOiBFbmFibGUgRFRCIGxvYWRp
bmcgb24gVU1MIGZvciBLVW5pdCB0ZXN0cwo+ID4gPiAgIGt1bml0OiBBZGQgdGVzdCBtYW5hZ2Vk
IHBsYXRmb3JtX2RldmljZS9kcml2ZXIgQVBJcwo+ID4gPiAgIGNsazogQWRkIHRlc3QgbWFuYWdl
ZCBjbGsgcHJvdmlkZXIvY29uc3VtZXIgQVBJcwo+ID4gPiAgIGR0LWJpbmRpbmdzOiBrdW5pdDog
QWRkIGZpeGVkIHJhdGUgY2xrIGNvbnN1bWVyIHRlc3QKPiA+ID4gICBjbGs6IEFkZCBLVW5pdCB0
ZXN0cyBmb3IgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZQo+ID4gPiAgIGR0LWJpbmRpbmdzOiBj
bGs6IEFkZCBLVW5pdCBjbGtfcGFyZW50X2RhdGEgdGVzdAo+ID4gPiAgIGNsazogQWRkIEtVbml0
IHRlc3RzIGZvciBjbGtzIHJlZ2lzdGVyZWQgd2l0aCBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhCj4g
Pgo+ID4gR29vZCB0byBzZWUgYmluZGluZ3MgZm9yIHRoaXMuIEkndmUgYmVlbiBtZWFuaW5nIHRv
IGRvIHNvbWV0aGluZyBhYm91dAo+ID4gdGhlIERUIHVuaXR0ZXN0IG9uZXMgYmVpbmcgdW5kb2N1
bWVudGVkLCBidXQgSSBoYWRuJ3QgcmVhbGx5IGRlY2lkZWQKPiA+IHdoZXRoZXIgaXQgd2FzIHdv
cnRoIHdyaXRpbmcgc2NoZW1hcyBmb3IgdGhlbS4gVGhlIGNvbXBhdGlibGVzIGF0Cj4gPiBsZWFz
dCBzaG93IHVwIHdpdGggJ21ha2UgZHRfY29tcGF0aWJsZV9jaGVjaycuIFBlcmhhcHMgd2Ugd2Fu
dCB0byBqdXN0Cj4gPiBkZWZpbmUgc29tZSB2ZW5kb3IgKG5vdCAnbGludXgnKSB0aGF0J3MgYW4g
ZXhjZXB0aW9uIHJhdGhlciB0aGFuCj4gPiByZXF1aXJpbmcgc2NoZW1hcyAoYWN0dWFsbHksIHRo
YXQgYWxyZWFkeSB3b3JrcyBmb3IgJ2ZvbycpLgo+Cj4gU3VyZS4gTWF5YmUgImt1bml0IiBzaG91
bGQgYmUgdGhlIHZlbmRvciBwcmVmaXg/IE9yICJkdGJ1bml0Ij8KCldlJ2Qgd2FudCB0byB1c2Ug
dGhlIHNhbWUgdGhpbmcgb24gdGhlIERUIHVuaXR0ZXN0cyBvciBhbnl0aGluZyBlbHNlCnBvdGVu
dGlhbGx5LiBIb3cgYWJvdXQganVzdCAndGVzdCc/Cgo+ID4gSXQncwo+ID4gbGlrZWx5IHRoYXQg
d2Ugd2FudCB0ZXN0IERUcyB0aGF0IGZhaWwgbm9ybWFsIGNoZWNrcyBhbmQgc2NoZW1hcyBnZXQK
PiA+IGluIHRoZSB3YXkgb2YgdGhhdCBhcyB3ZSBkb24ndCBoYXZlIGEgd2F5IHRvIHR1cm4gb2Zm
IGNoZWNrcy4KPgo+IEhhdmluZyB0aGUgc2NoZW1hcyBpcyBuaWNlIHRvIG1ha2Ugc3VyZSB0ZXN0
cyB0aGF0IGFyZSBleHBlY3Rpbmcgc29tZQo+IGJpbmRpbmcgYXJlIGFjdHVhbGx5IGdldHRpbmcg
dGhhdC4gQnV0IHN1cHBvcnRpbmcgYnJva2VuIGJpbmRpbmdzIGlzCj4gYWxzbyBpbXBvcnRhbnQg
dG8gdGVzdCBhbnkgZXJyb3IgcGF0aHMgaW4gZnVuY3Rpb25zIHRoYXQgcGFyc2UKPiBwcm9wZXJ0
aWVzLiBNYXliZSB3ZSBrZWVwIHRoZSBzY2hlbWEgYW5kIGhhdmUgaXQgZW5mb3JjZSB0aGF0IGlu
Y29ycmVjdAo+IHByb3BlcnRpZXMgYXJlIGJlaW5nIHNldD8KCkkgd2Fzbid0IHN1Z2dlc3Rpbmcg
dGhyb3dpbmcgdGhlbSBvdXQuIE1vcmUgd2h5IEkgaGFkbid0IHdyaXR0ZW4gYW55IEkgZ3Vlc3Mu
Cgo+IERvIHdlIHJlYWxseSBuZWVkIHRvIHRlc3QgaW5jb3JyZWN0IGJpbmRpbmdzPyBEb2Vzbid0
IHRoZQo+IGR0X2JpbmRpbmdzX2NoZWNrIGNhdGNoIHRoZXNlIHByb2JsZW1zIHNvIHdlIGRvbid0
IGhhdmUgdG8gd3JpdGUgRFRCCj4gdmVyaWZpZXJzIGluIHRoZSBrZXJuZWw/CgpGYWlyIGVub3Vn
aC4gVXNpbmcgbXkgZnJlcXVlbnRseSBzdGF0ZWQgcG9zaXRpb24gYWdhaW5zdCBtZS4gOikKCkkg
ZG8gaGF2ZSBhIHNlY3JldCBwbGFuIHRvIGltcGxlbWVudCAoZGVidWcpIHR5cGUgY2hlY2tzIGlu
dG8gdGhlCm9mX3Byb3BlcnR5XyogQVBJcyBieSBleHRyYWN0aW5nIHRoZSB0eXBlIGluZm9ybWF0
aW9uIGZyb20gc2NoZW1hcwppbnRvIEMuCgoKPiA+IFdlIGFscmVhZHkgaGF2ZSBHUElPIHRlc3Rz
IGluIHRoZSBEVCB1bml0dGVzdHMsIHNvIHdoeSBpcyBjbG9ja3MKPiA+IGRpZmZlcmVudD8gT3Ig
c2hvdWxkIHRoZSBHUElPIHRlc3RzIGJlIG1vdmVkIG91dCAoeWVzLCBwbGVhc2UhKT8KPgo+IEFo
IEkgZGlkbid0IG5vdGljZSB0aGUgR1BJTyB0ZXN0cyBpbiB0aGVyZS4gVGhlcmUgYXJlIGkyYyB0
ZXN0cyB0b28sCj4gcmlnaHQ/IEFsbCBJIGNhbiBzYXkgaXMgY2xrcyBhcmUgdXNpbmcga3VuaXQs
IHRoYXQncyB0aGUgZGlmZmVyZW5jZSA7LSkKClllYWgsIHRoZXkgc2hvdWxkIHBlcmhhcHMgYWxs
IG1vdmUgdG8gdGhlIHN1YnN5c3RlbXMuCgo+ID4gV2hhdCBoYXBwZW5zIHdoZW4vaWYgdGhlIERU
IHVuaXR0ZXN0IGlzIGNvbnZlcnRlZCB0byBrdW5pdD8gSSB0aGluawo+ID4gdGhhdCB3b3VsZCBs
b29rIGNvbmZ1c2luZyBmcm9tIHRoZSBuYW1pbmcuIE15IGluaXRpYWwgdGhvdWdodCBpcwo+ID4g
J2t1bml0JyBzaG91bGQgYmUgZHJvcHBlZCBmcm9tIHRoZSBuYW1pbmcgb2YgYSBsb3Qgb2YgdGhp
cy4gTm90ZSB0aGF0Cj4gPiB0aGUgb3JpZ2luYWwga3VuaXQgc3VibWlzc2lvbiBjb252ZXJ0ZWQg
dGhlIERUIHVuaXR0ZXN0cy4gSSB3b3VsZAo+ID4gc3RpbGwgbGlrZSB0byBzZWUgdGhhdCBoYXBw
ZW4uIEZyYW5rIGRpc2FncmVlZCBvdmVyIHdoYXQncyBhIHVuaXQgdGVzdAo+ID4gb3Igbm90LCB0
aGVuIGFncmVlZCwgdGhlbiBkaWRuJ3QuLi4gSSBkb24ndCByZWFsbHkgY2FyZS4gSWYgdGhlcmUn
cyBhCj4gPiBmcmFtZXdvcmsgdG8gdXNlLCB0aGVuIHdlIHNob3VsZCB1c2UgaXQgSU1PLgo+Cj4g
SG9uZXN0bHkgSSBkb24ndCB3YW50IHRvIGdldCBpbnZvbHZlZCBpbiBtaWdyYXRpbmcgdGhlIGV4
aXN0aW5nIERUCj4gdW5pdHRlc3QgY29kZSB0byBrdW5pdC4gSSdtIGF3YXJlIHRoYXQgaXQgd2Fz
IGF0dGVtcHRlZCB5ZWFycyBhZ28gd2hlbgo+IGt1bml0IHdhcyBpbnRyb2R1Y2VkLiBNYXliZSBp
ZiB0aGUgb3ZlcmxheSByb3V0ZSB3b3JrcyB3ZWxsIGVub3VnaCBJIGNhbgo+IGNvbXBsZXRlbHkg
c2lkZXN0ZXAgaW50cm9kdWNpbmcgYW55IGNvZGUgaW4gZHJpdmVycy9vZi8gYmVzaWRlcyBzb21l
Cj4ga3VuaXQgd3JhcHBlcnMgZm9yIHRoaXMuIEknbGwgY3Jvc3MgbXkgZmluZ2VycyEKClllYWgs
IEkgd2Fzbid0IGV4cGVjdGluZyB5b3UgdG8uIEkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB0aGlz
IG1lc2hlcwp3aXRoIGFueSBmdXR1cmUgY29udmVyc2lvbiB0byBrdW5pdC4KClRoZXJlJ3MgYWxz
byBzb21lIHBsYW5zIHRvIGFsd2F5cyBwb3B1bGF0ZSB0aGUgRFQgcm9vdCBub2RlIGlmIG5vdApw
cmVzZW50LiBUaGF0IG1heSBoZWxwIGhlcmUuIE9yIG5vdC4gVGhlcmUncyBiZWVuIGEgZmV3IHZl
cnNpb25zCnBvc3RlZCB3aXRoIEZyYW5rJ3MgaW4gdGhlIGxhc3Qgd2VlayBvciAyLgoKUm9iCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
