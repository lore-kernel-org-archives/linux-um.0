Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA450C77B61
	for <linux-um@archiver.kernel.org>; Tue, 25 Apr 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GFSgzDo+074bKhz8Ni5bJXEW9MH4mAsGwlyu/uwkFuY=; b=pK6MS5CX6USYv+
	tj22Giw02k3o71DdcFHBz2b0qS07Wz4dq7THieEk5xaKeIz2a0wNo9xvplox2aTXeWBtM9v8S0tDN
	bWapb+JAuX3mx+VAgBAJtR3PNswbdvygmicWsF1VQDjGNBxhUrQ9WJQW+WInzTbNnZ2H8W7SG3zjn
	pgM3rUqJFPgwCVWoUXQdGhsKsSGQxLZjq4WBpphNEkSswM7vZuSghHB/ENk/0dwqjx1twn7reGedA
	p0LHyafM3X3b+LtMxv2vHtbVzjspngxVVHQxHiQcJT04qfp8j34qP/fc5ZZw0ES0gpGU97Imh0D+Q
	1JviqDVFcYIZQ4zE8jjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prLFE-001cuB-2E;
	Tue, 25 Apr 2023 16:10:20 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prLFC-001csE-1l
	for linux-um@lists.infradead.org;
	Tue, 25 Apr 2023 16:10:19 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f4b911570so906393566b.0
        for <linux-um@lists.infradead.org>; Tue, 25 Apr 2023 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682439009; x=1685031009;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8hIAgaNDAGSUXSrxaNMjDe9B2KCBZls9xBCeypeM9M=;
        b=aZbi9OD3dt6WU/Q+aWA8yE7T9kQukP5aS9u1JanEeaAjrwNXpXTtVUzHcAEljBAnqq
         4x5L51onY83CKxfd3Jgc0I1P2vRpI37y1/v0X5pvZrbOs2oXI6dp+1yFsTDo9Z+TvCQi
         EUD26YUOTJqRT/8FmSP5kdKvNsxVr7d8nEpj+wMxY6mzRvBNnM+00nqclNAqLOVaGn/a
         7siFCyH9nc4vWeLSRfgcx/9+ikBsMmX89Ch7Ek9kjz95AmrrLwg4Q5pX7LgoN7RKIbtK
         uANzA9iAdFM2vDxop9516FR1MtuoPs5Mfd2jGURMonbLs/r7HamylgUfsL0b3qRhpcFI
         hToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439009; x=1685031009;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8hIAgaNDAGSUXSrxaNMjDe9B2KCBZls9xBCeypeM9M=;
        b=ErTo6gAObajSDX5rlNrz93aQpR6/SwDcNII2m+j2gL6It3yEmgyfV8Ypm76djt+Os0
         s1YX1Z2uJCYv9htMLulwbzuByzN3tuYPqObuk4SmpO1jp78L3JCLduxGErMPPsQADxr8
         NYV2Zg18PrS5InmuknhSW0mWgSQTQgJndQYh2a9LDVQ481wERI96lLyX4DuNSS4uCwWQ
         977Qql8Skexoq5qKuebQ0O86gWc5GQrnUlOLYaLfxwwtds0ZK4LMcBo1cmMOXw2hkXhb
         u2mBlpdaD/N044uwNGWuymDekKYKQl5+21kKhcGY/g/cRWKy4NkvEl/IN3F9Y7/hLmt9
         ksVA==
X-Gm-Message-State: AAQBX9cwEt+NdUUCl1SP2hij6augjANYsqoMLYNpwNCq1C62EO36XNNh
	sQ1N6mfX8gGG4knaaW1nGiE=
X-Google-Smtp-Source: AKy350ZgwigaDQVAjx+wMoicaUk/It8b1S/AvrGLabJVjznKDYUZo0gy/B1P1dT1nL78hjJD1CzuMg==
X-Received: by 2002:a17:907:6290:b0:94f:395b:df1b with SMTP id nd16-20020a170907629000b0094f395bdf1bmr15664190ejc.21.1682439009211;
        Tue, 25 Apr 2023 09:10:09 -0700 (PDT)
Received: from localhost (178-221-25-206.dynamic.isp.telekom.rs. [178.221.25.206])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906494500b0094eaa31aa63sm6961064ejt.77.2023.04.25.09.10.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 09:10:08 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 25 Apr 2023 18:10:07 +0200
Message-Id: <CS5YUPTFMXBI.14X5P3QS6CGYZ@laptop-fedora>
From: =?utf-8?q?Marko_Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>,
 <linux-um@lists.infradead.org>
Cc: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>, "Glenn Washburn"
 <development@efficientek.com>, "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v2 2/2] hostfs: store permissions in extended attributes
X-Mailer: aerc 0.14.0
References: <20230413223024.11513-3-petrovicmarko2006@gmail.com>
 <20230414023357.63722-1-petrovicmarko2006@gmail.com>
 <8e4ab053944c39ba6ba686f0acc748bb7f76632a.camel@sipsolutions.net>
 <CRWNG4ROL7ON.2DVU93FENOO89@laptop-fedora>
 <5a61dc08683e4e7988693f5ffe4836be7aaf7451.camel@sipsolutions.net>
In-Reply-To: <5a61dc08683e4e7988693f5ffe4836be7aaf7451.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_091018_591430_B13F0256 
X-CRM114-Status: GOOD (  36.78  )
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

T24gVHVlIEFwciAxOCwgMjAyMyBhdCAxMDoyNiBBTSBDRVNULCBKb2hhbm5lcyBCZXJnIHdyb3Rl
OgpIZWxsbywKVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyEKPiBPbiBGcmksIDIwMjMtMDQtMTQg
YXQgMTk6MTkgKzAyMDAsIE1hcmtvIFBldHJvdmnEhyB3cm90ZToKPiA+ID4gPiArKysgYi9mcy9o
b3N0ZnMvaG9zdGZzLmgKPiA+ID4gPiBAQCAtMzcsNiArMzcsNyBAQAo+ID4gPiA+ICAgKiBpcyBv
biwgYW5kIHJlbW92ZSB0aGUgYXBwcm9wcmlhdGUgYml0cyBmcm9tIGF0dHItPmlhX21vZGUgKGF0
dHIgaXMgYQo+ID4gPiA+ICAgKiAic3RydWN0IGlhdHRyICoiKS4gLUJsYWlzb3JCbGFkZQo+ID4g
PiA+ICAgKi8KPiA+ID4gPiArZXh0ZXJuIGludCB1c2VfeGF0dHI7Cj4gPiA+IAo+ID4gPiAKPiA+
ID4gVGhhdCBzZWVtcyBsaWtlIGFuIG9kZCBwbGFjZSB0byBwdXQgaXQgLSB0aGUgY29tbWVudCBh
Ym92ZSBpcyBzdXJlbHkgZm9yCj4gPiA+IHRoZSBob3N0ZnNfdGltZXNwZWM/Cj4gPiBBY3R1YWxs
eSBpdCBhcHBlYXJzIHRvIGJlIHRhbGtpbmcgYWJvdXQgdGhlIG1pc3NpbmcgZGVmaW5lcyBvZgo+
ID4gQVRUUl9LSUxMX1NVSUQgYW5kIEFUVFJfS0lMTF9TR0lELCB1bnJlbGF0ZWQgdG8gdGhlIHN0
cnVjdCBob3N0ZnNfdGltZXNwZWMuCj4gPiBBcyBmb3Igd2h5IEkgcHV0IGl0IHRoZXJlLCBJIHRo
b3VnaHQgaXQgd291bGQgYmUgbmljZSBub3QgdG8gbWl4Cj4gPiBmdW5jdGlvbiBkZWNsYXJhdGlv
bnMgd2l0aCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMuCj4KPiBPaCwgT0ssIHNvcnJ5LiBNYXliZSBq
dXN0IGFkZCBhIGNvdXBsZSBvZiBibGFuayBsaW5lIGFyb3VuZCBpdCB0aGVuIHNvCj4gaXQgZG9l
c24ndCBsb29rIHNvIGdyb3VwZWQ/IDopCk9rLiBXaWxsIGFkZCB0aGVtLiA6KQoKPiA+IFJlZ2Fy
ZGluZyBuZXN0ZWQgVU1McyB1c2luZyBob3N0ZnMsIGEgc2ltcGxlIGFwcGVuZCBvZiBzb21lIGNo
YXIKPiA+IChvciBzdHJpbmc/KSB0byB0aGUgYXR0cmlidXRlIG5hbWUgd2hlbiBpdCBzdGFydHMg
d2l0aCB1c2VyLnVtbHBlcm1zCj4gPiBzaG91bGQgc29sdmUgdGhlIGlzc3VlLiBUaGVuIGZpcnN0
IFVNTCB3b3VsZCBhY2Nlc3MgdXNlci51bWxwZXJtcywgVU1MCj4gPiBpbnNpZGUgaXQgd291bGQg
YWNjZXNzIHVzZXIudW1scGVybXMxLCBVTUwgaW5zaWRlIHRoYXQgVU1MIHdvdWxkIGFjY2Vzcwo+
ID4gdXNlci51bWxwZXJtczExLCBldGMuIGFzIHNlZW4gYnkgdGhlIGhvc3QuCj4KPiBOb3Qgc3Vy
ZSB0aGF0IHNlZW1zIGxpa2UgYSBnb29kIGlkZWEsIHRoZW4gd291bGRuJ3QgeW91IHJlYWQgdGhl
Cj4gcGVybWlzc2lvbnMgZGVwZW5kaW5nIG9uIHRoZSBuZXN0aW5nIGxldmVsIHlvdSdyZSBydW5u
aW5nIG9uIG9yCj4gc29tZXRoaW5nPyBIb3cgd291bGQgdGhhdCBldmVuIHdvcms/ClllcywgdGhh
dCB3YXMgdGhlIGlkZWEsIGtpbmQgb2YuIEl0IHNlZW1lZCBsaWtlIGEgZ29vZCBpZGVhIGZvciBl
YWNoIFVNTApvbiBlYWNoIG5lc3RpbmcgbGV2ZWwgdG8gaGF2ZSBpdCdzIG93biBwZXJtaXNzaW9u
IGF0dHJpYnV0ZXMgYW5kIG5vdAptZXNzIHdpdGggaG9zdCdzIHBlcm1pc3Npb25zLgo+Cj4gQW55
d2F5IGl0IGFsbCBkb2Vzbid0IHdvcmsgc2luY2UgaG9zdGZzIGl0c2VsZiBkb2Vzbid0IHNlZW0g
dG8gc3VwcG9ydAo+IHhhdHRycyBub3csIHNvIHlvdSBjYW4ndCBzdG9yZSB4YXR0cnMgaW4gaXQs
IHNvIG9ubHkgdGhlbiB3b3VsZCB3ZSBoYXZlCj4gdG8gdGhpbmsgYWJvdXQgaXQuCj4KPiBBbmQg
SSB0aGluayBhdCB0aGF0IHBvaW50IHdlJ2QgcHJvYmFibHkgd2FudCB0byBkbyBzb21lIG1hbmds
aW5nIGxpa2UKPgo+IAl1c2VyLnh5ego+IAlzZWN1cml0eS54eXoKPgo+IGF0dHJpYnV0ZXMgaW5z
aWRlIGhvc3RmcyBnZXR0aW5nIHN0b3JlZCBpbnRvCj4KPiAJdXNlci51bWwudXNlci54eXoKPiAJ
dXNlci51bWwuc2VjdXJpdHkueHl6Cj4KPiBvbiB0aGUgaG9zdCBmaWxlc3lzdGVtLCBvciBzdWNo
LiBBbmQgdGhlbiBpdCB3b3VsZG4ndCBjb25mbGljdCwgYW5kIGlmCj4geW91IG5lc3RlZCwgeW91
J2QgZ2V0ICJ1c2VyLnVtbC51c2VyLnVtbGNyZWQiIChvciB3aGF0IHlvdSBjaG9zZSBub3cpLAo+
IHlvdSdkIGp1c3QgbGltaXQgdGhlIG5lc3RpbmcgaGVyZSBvbiB0aGUgZGVwdGggb2YgdGhlIHhh
dHRyIG5hbWUgOykKPgo+IE5vdGhpbmcgd2UgbmVlZCB0byB0aGluayBhYm91dCB0b28gbXVjaCBy
aWdodCBub3csIEkgZ3Vlc3MuCklmIEkgdW5kZXJzdG9vZCBjb3JyZWN0bHksIHRoYXQgYWxzbyBh
Y2NvbXBsaXNoZXMgbW9yZSBvciBsZXNzIHRoZSBzYW1lCnRoaW5nLCBpdCBqdXN0IHByZXBlbmRz
IHRoZSAidXNlci51bWwuIiBzdHJpbmcgdG8gdGhlIG9yaWdpbmFsIGF0dHJpYnV0ZQppbnN0ZWFk
IG9mIGFwcGVuZGluZyBzb21lIGNoYXIgc28gdGhlcmUgd291bGQgYmUgdXNlci51bWxjcmVkIGZv
ciB0aGUKZmlyc3QgVU1MLCB1c2VyLnVtbC51c2VyLnVtbGNyZWQgZm9yIHRoZSBzZWNvbmQgVU1M
LAp1c2VyLnVtbC51c2VyLnVtbC51c2VyLnVtbGNyZWQgZm9yIHRoZSB0aGlyZCBVTUwsIGV0Yy4K
CkFwYXJ0IGZyb20gbG9uZ2VyIG5hbWVzLCBpdCBzZWVtcyBmaW5lLiBJbiBhbnkgY2FzZSwgYXMg
eW91IHNhaWQsIHdlIHdpbGwKdGhpbmsgdGhpcyB0aHJvdWdoIHdoZW4gaG9zdGZzIGdldHMgZXh0
ZW5kZWQgYXR0cmlidXRlcyBzdXBwb3J0LgoKPiA+ID4gCj4gPiA+ID4gKwlzdHJ1Y3Qgc3RhdDY0
IGJ1ZiA9IHsgMCB9Owo+ID4gPiA+ICsKPiA+ID4gPiArCXN0cmNweShwYXJlbnQsIHBhdGgpOwo+
ID4gPiA+ICsJaSA9IGkgLSAzOwo+ID4gPiAKPiA+ID4gd2h5IC0zPwo+ID4gaSBpcyBpbml0aWFs
bHkgc3RybGVuKHBhdGgpICsgMSwgaS5lLiB0aGUgbGVuZ3RoIG9mIHRoZSB3aG9sZSBzdHJpbmcK
PiA+IGluY2x1ZGluZyB0aGUgbnVsbCBieXRlLiBUaGVuIGktMSBpcyB0aGUgaW5kZXggb2YgdGhl
IG51bGwgYnl0ZSBhbmQgaS0yCj4gPiBpcyB0aGUgaW5kZXggb2YgdGhlIGxhc3QgY2hhcmFjdGVy
LCBidXQgbGFzdCBjaGFyY3RlciBjYW5ub3QgYmUgdGhlCj4gPiBzbGFzaCB0aGF0IHNlcGFyYXRl
cyBmaWxlIGZyb20gaXQncyBwYXJlbnQgZGlyZWN0b3J5LCBzbyBzZWFyY2ggc3RhcnRzCj4gPiBm
cm9tIGktMy4KPgo+IFdvdWxkIGJlIGdvb2QgdG8gYWRkIGEgY29tbWVudCB3aXRoIHRoYXQgSSB0
aGluayA6KQo+Ck9rLiBXaWxsIGFkZCBpdC4KCkJlc3QgUmVnYXJkcywKTWFya28gUGV0cm92acSH
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11
bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
