Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8087EB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 19:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AFNakRilGVOVuNz+cPQNAe2dP0jmUaC/PzpAQNTKUl0=; b=XqD6a+HmikZI7Z
	d6FVBEtZC8lGbY+k8ZvlzEPiIrCqVNnuuszSp5irkmrDpgbD04XHRf78v+IHijpV+Xqw4KndgtetW
	b43gEkTEKgom5aZeR1qDkVuah+LWPNx2cXxu1AenHDiIvvcYatNkcigitF0C5qsD/im6X2vzCpHyz
	DMbQja7pavAesPG+id27QfG38o6mRzvbVCWbnKBHvQNxZMNjHQ4YjlUIgZ5wx+DRWdyMdLYNYOHTN
	0+AEKACxnXpRiOOvVpbQU02Y/rgIs9PBa+cnDt56klDUNNC5UzyJaoxttQkaOJap3KusKTtb7y6vQ
	C6LBOp0lntNcbpoTPifw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEEnx-00E06l-06;
	Tue, 27 Jun 2023 19:56:49 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEEnq-00E044-0j;
	Tue, 27 Jun 2023 19:56:46 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57059626276so55060127b3.3;
        Tue, 27 Jun 2023 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687895796; x=1690487796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdquro6/1dmVZnYjtrQgFcMxkU4TUJVZmkWoLqAkDfs=;
        b=f28I8lHAi89ozlaNg/BctKdKMs3ZV6m8KXjBDM6pClsFtWadf95y0x4g3i//E8BwZz
         W+z8+saIIFbmoUgBUaIpSnUEoRcLDnuqLYQnOFRS+j34fc48uptWzZzEtuGsHAJp24eW
         schrHDJX1LmM4MqcKy9Kl1+LnP3eq11QJcl+8rxobGaBQBGKgLHNc4OHDPWjyNPyHr8O
         3NCVuR4QFNH+Qpn6H6NXaags2ruLb1/5mkhPFAz5CmyBZqkztlzk4kjRiIcxN74282q0
         ok16c0PiSUSoXbXu9Py6nAmtPZ8zTkEwR31ZaDkNSc5taFwAdZNAWg6IT3kt5o5vZVZ6
         A8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895796; x=1690487796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdquro6/1dmVZnYjtrQgFcMxkU4TUJVZmkWoLqAkDfs=;
        b=NkB1Bh/Z3cpM8etwMvcPMT1sHCA1YxDs9qPJ6kT9grvZTL4QwXRur37V8KjmB0NKKa
         LH1YtI6JdHdK2BrfDJ+K1U2OWR3zpGiUZrX5qqU16vySgcgytl/zKQA0XoGF1ZM09p7P
         sI7x25GIb5fVs6dGzOgzLUqkCBkMkls0bb06kBRYSdXJyyqX/gRevqRSyUVlpIqNgkpf
         fOEnctOwVNF2AF4sRlzbVS+bhSv7f/HEL1I9I2yEs0VwY2wjlQqeUb/o23b8vvSBIHZn
         ePvZGymSXP9rRpAdX2tThrQNSrTsDLF3WC3d4LVfn0mODEaH1EFlgaXGa4SLt+pfDbbF
         HmNA==
X-Gm-Message-State: AC+VfDxmnU8RkoddzzSBtOYQu3LhlDcpGDU92LWL5ECcdJS79cTtu5fk
	tkaFm1UDm/ytkId7y0g9dyfY/vkbyjLhX/A43Sc=
X-Google-Smtp-Source: ACHHUZ5reIcGnTN97W0IND8v2qM1C2Qu4uLolES6NdKMr/CmT1WqgUFXujo/fo7+ykti4Dwr2zsHLXj/ugW36Uy1oLg=
X-Received: by 2002:a0d:de45:0:b0:576:e678:21d6 with SMTP id
 h66-20020a0dde45000000b00576e67821d6mr4351768ywe.12.1687895796450; Tue, 27
 Jun 2023 12:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com> <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net> <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
In-Reply-To: <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 27 Jun 2023 12:56:25 -0700
Message-ID: <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_125642_263294_71C44A98 
X-CRM114-Status: GOOD (  21.76  )
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMTI6MTTigK9QTSBHdWVudGVyIFJvZWNrIDxsaW51eEBy
b2Vjay11cy5uZXQ+IHdyb3RlOgo+Cj4gT24gNi8yNy8yMyAxMjoxMCwgR3VlbnRlciBSb2VjayB3
cm90ZToKPiA+IE9uIDYvMjcvMjMgMTA6NDIsIFZpc2hhbCBNb29sYSB3cm90ZToKPiA+PiBPbiBN
b24sIEp1biAyNiwgMjAyMyBhdCAxMDo0N+KAr1BNIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNr
LXVzLm5ldD4gd3JvdGU6Cj4gPj4+Cj4gPj4+IE9uIFRodSwgSnVuIDIyLCAyMDIzIGF0IDAxOjU3
OjM4UE0gLTA3MDAsIFZpc2hhbCBNb29sYSAoT3JhY2xlKSB3cm90ZToKPiA+Pj4+IFBhcnQgb2Yg
dGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9y
cyB3aXRoCj4gPj4+PiBwdGRlc2MgZXF1aXZhbGVudHMuCj4gPj4+Pgo+ID4+Pj4gU2lnbmVkLW9m
Zi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+ID4+
Pj4gQWNrZWQtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJwcHRAa2VybmVsLm9yZz4KPiA+Pj4K
PiA+Pj4gVGhpcyBwYXRjaCBjYXVzZXMgYWxsIG5pb3MyIGJ1aWxkcyB0byBmYWlsLgo+ID4+Cj4g
Pj4gSXQgbG9va3MgbGlrZSB5b3UgdHJpZWQgdG8gYXBwbHkgdGhpcyBwYXRjaCBvbiBpdHMgb3du
LiBUaGlzIHBhdGNoIGRlcGVuZHMKPiA+PiBvbiBwYXRjaGVzIDAxLTEyIG9mIHRoaXMgcGF0Y2hz
ZXQgdG8gY29tcGlsZSBwcm9wZXJseS4gSSd2ZSBjcm9zcy1jb21waWxlZAo+ID4+IHRoaXMgYXJj
aGl0ZWN0dXJlIGFuZCBpdCB3b3JrZWQsIGJ1dCBsZXQgbWUga25vdyBpZiBzb21ldGhpbmcgZmFp
bHMKPiA+PiB3aGVuIGl0cyBhcHBsaWVkIG9uIHRvcCBvZiB0aG9zZSBwYXRjaGVzIChvciB0aGUg
cmVzdCBvZiB0aGUgcGF0Y2hzZXQpLgo+ID4KPiA+Cj4gPiBObywgSSBkaWQgbm90IHRyeSB0byBh
cHBseSB0aGlzIHBhdGNoIG9uIGl0cyBvd24uIEkgdHJpZWQgdG8gYnVpbGQgeWVzdGVyZGF5J3MK
PiA+IHBlbmRpbmctZml4ZXMgYnJhbmNoIG9mIGxpbnV4LW5leHQuCj4gPgo+Cj4gQSBxdWljayBj
aGVjayBzaG93cyB0aGF0IHRoZSBidWlsZCBmYWlscyB3aXRoIG5leHQtMjAyMzA2MjcuIFNlZSBs
b2cgYmVsb3cuCgpBaCBpdCBsb29rcyBsaWtlIHRoaXMgb25lIHNsaXBwZWQgaW50byAtbmV4dCBv
biBpdHMgb3duIHNvbWVob3c/IFN0ZXBoZW4sIHBsZWFzZQpkcm9wIHRoaXMgcGF0Y2ggZnJvbSAt
bmV4dDsgaXQgc2hvdWxkbid0IGJlIGluIHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhlCnBhdGNoc2V0
IHdoaWNoCkkgaW50ZW5kIHRvIGhhdmUgQW5kcmV3IHRha2UgdGhyb3VnaCB0aGUgbW0gdHJlZS4K
Cj4gR3VlbnRlcgo+Cj4gLS0tCj4KPiAkIGdpdCBkZXNjcmliZQo+IG5leHQtMjAyMzA2MjcKPiAk
IGdpdCBkZXNjcmliZSAtLW1hdGNoICd2KicKPiB2Ni40LTEyNjAxLWc1M2NkZjg2NWY5MGIKPgo+
IEJ1aWxkIHJlZmVyZW5jZTogdjYuNC0xMjYwMS1nNTNjZGY4NjVmOTBiCj4gQ29tcGlsZXIgdmVy
c2lvbjogbmlvczItbGludXgtZ2NjIChHQ0MpIDExLjQuMAo+IEFzc2VtYmxlciB2ZXJzaW9uOiBH
TlUgYXNzZW1ibGVyIChHTlUgQmludXRpbHMpIDIuNDAKPgo+IEJ1aWxkaW5nIG5pb3MyOmFsbG5v
Y29uZmlnIC4uLiBmYWlsZWQKPiAtLS0tLS0tLS0tLS0tLQo+IEVycm9yIGxvZzoKPiA8c3RkaW4+
OjE1MTk6Mjogd2FybmluZzogI3dhcm5pbmcgc3lzY2FsbCBjbG9uZTMgbm90IGltcGxlbWVudGVk
IFstV2NwcF0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gbW0vbWVtb3J5LmM6ODY6Cj4gbW0vbWVt
b3J5LmM6IEluIGZ1bmN0aW9uICdmcmVlX3B0ZV9yYW5nZSc6Cj4gYXJjaC9uaW9zMi9pbmNsdWRl
L2FzbS9wZ2FsbG9jLmg6MzM6MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiAncGFnZXRhYmxlX3B0ZV9kdG9yJzsgZGlkIHlvdSBtZWFuICdwZ3RhYmxlX3B0ZV9wYWdl
X2R0b3InPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgICAgMzMg
fCAgICAgICAgICAgICAgICAgcGFnZXRhYmxlX3B0ZV9kdG9yKHBhZ2VfcHRkZXNjKHB0ZSkpOyAg
ICAgICAgICAgICAgICAgICBcCj4gICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fgo+IGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmg6NjY2OjE3OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8gJ19fcHRlX2ZyZWVfdGxiJwo+ICAgIDY2NiB8ICAgICAgICAgICAgICAg
ICBfX3B0ZV9mcmVlX3RsYih0bGIsIHB0ZXAsIGFkZHJlc3MpOyAgICAgICAgICAgICBcCj4gICAg
ICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+Cj4gbW0vbWVtb3J5LmM6MTk0Ojk6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAncHRlX2ZyZWVfdGxiJwo+ICAgIDE5NCB8ICAg
ICAgICAgcHRlX2ZyZWVfdGxiKHRsYiwgdG9rZW4sIGFkZHIpOwo+ICAgICAgICB8ICAgICAgICAg
Xn5+fn5+fn5+fn5+Cj4gYXJjaC9uaW9zMi9pbmNsdWRlL2FzbS9wZ2FsbG9jLmg6MzM6MzY6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAncGFnZV9wdGRlc2MnIFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICAzMyB8ICAgICAgICAgICAg
ICAgICBwYWdldGFibGVfcHRlX2R0b3IocGFnZV9wdGRlc2MocHRlKSk7ICAgICAgICAgICAgICAg
ICAgIFwKPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+Cj4gaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaDo2NjY6MTc6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyAnX19wdGVfZnJlZV90bGInCj4gICAgNjY2IHwgICAgICAgICAgICAgICAg
IF9fcHRlX2ZyZWVfdGxiKHRsYiwgcHRlcCwgYWRkcmVzcyk7ICAgICAgICAgICAgIFwKPiAgICAg
ICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KPiBtbS9tZW1vcnkuYzoxOTQ6OTog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdwdGVfZnJlZV90bGInCj4gICAgMTk0IHwgICAg
ICAgICBwdGVfZnJlZV90bGIodGxiLCB0b2tlbiwgYWRkcik7Cj4gICAgICAgIHwgICAgICAgICBe
fn5+fn5+fn5+fn4KPiBhcmNoL25pb3MyL2luY2x1ZGUvYXNtL3BnYWxsb2MuaDozNDoxNzogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICd0bGJfcmVtb3ZlX3BhZ2VfcHRk
ZXNjJzsgZGlkIHlvdSBtZWFuICd0bGJfcmVtb3ZlX3BhZ2Vfc2l6ZSc/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICAzNCB8ICAgICAgICAgICAgICAgICB0bGJf
cmVtb3ZlX3BhZ2VfcHRkZXNjKCh0bGIpLCAocGFnZV9wdGRlc2MocHRlKSkpOyAgICAgIFwKPiAg
ICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+IGluY2x1ZGUv
YXNtLWdlbmVyaWMvdGxiLmg6NjY2OjE3OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ19f
cHRlX2ZyZWVfdGxiJwo+ICAgIDY2NiB8ICAgICAgICAgICAgICAgICBfX3B0ZV9mcmVlX3RsYih0
bGIsIHB0ZXAsIGFkZHJlc3MpOyAgICAgICAgICAgICBcCj4gICAgICAgIHwgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+Cj4gbW0vbWVtb3J5LmM6MTk0Ojk6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyAncHRlX2ZyZWVfdGxiJwo+ICAgIDE5NCB8ICAgICAgICAgcHRlX2ZyZWVfdGxi
KHRsYiwgdG9rZW4sIGFkZHIpOwo+ICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+Cj4gY2Mx
OiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4gbWFrZVszXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0MzogbW0vbWVtb3J5Lm9dIEVycm9yIDEKPiBtYWtlWzNd
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgo+IG1ha2VbMl06ICoqKiBbc2Ny
aXB0cy9NYWtlZmlsZS5idWlsZDo0Nzc6IG1tXSBFcnJvciAyCj4gbWFrZVsyXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KPiBtYWtlWzFdOiAqKiogW01ha2VmaWxlOjIwMjI6
IC5dIEVycm9yIDIKPiBtYWtlOiAqKiogW01ha2VmaWxlOjIyNjogX19zdWItbWFrZV0gRXJyb3Ig
MgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
