Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B16C6FD18
	for <linux-um@archiver.kernel.org>; Tue, 25 Apr 2023 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TDgwry51yazB0DOehwL19gUCcaejDiNzaQRvKds36NQ=; b=PZxn+Ygr1O6S5Y
	IfAqvOZ0s+cFqFa2kyi2AeihUfTgngSWJOOQIFflWnJXvKEV0zrfDAIb2VH+lcIjfbbN9OJHGGlT7
	b54dHLVg2hL1Cq6Z5997ZrtV942Z/U4QaVyYfeuR6q7x8e3JteOZ0BltsIi+sxTS19JSYwJnOjodO
	AHdId4MTQg2BfQEzOBOKUqcueaLz6Ps361JINUhG62tlDNWQ8ehRhMHTDsDB8VfXbDYkNzNHNMPw3
	2OrQy/QGo73UyKT8UqOpKIWlQGOKx5jDqw7FoJtihhu/X+u0ZbG9HrL9cX6U42eyEmSSp+dqNjqK/
	6aD0Vh/V3MdfxXNB31Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prLdm-001gUv-0Y;
	Tue, 25 Apr 2023 16:35:42 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prLdk-001gUN-0k
	for linux-um@lists.infradead.org;
	Tue, 25 Apr 2023 16:35:41 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f6c285d92so1128787066b.3
        for <linux-um@lists.infradead.org>; Tue, 25 Apr 2023 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682440538; x=1685032538;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bErh9eAHDXLfPPJMLsihyTVic/+6f0Oibb2Hrr0qb8=;
        b=kv7ydElIEHV8nQIE9grkMxkyb2JcXHSu6ksMQTFiR9I6uq+ontIZIQwDKEjz5aKiuH
         n4hSSl2ria/IoZftd+8YWOCNt9L3FabRg654SCQtfPbSLyPx0qdZA8HNv+ljDaS4qQfs
         0jz49/NfBR6U1Q/nioIWEuAQMdzqXhSt2P1hXd7HqZdsRzP9+yHnKCmjFBmeSSAyjaOS
         3w8jQvC4VBwO/7MpU8zo5HOiIkjH8VOzzKLk8UJpn9MM4tFA8ya+FaChFae2Myf8LB7d
         HQIfNEwDSLw4uWfmDT1FFa45AsNttF7DSkSajmyNaI9Zzqon5NrondcOXy2B8+pA9bu1
         NhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440538; x=1685032538;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9bErh9eAHDXLfPPJMLsihyTVic/+6f0Oibb2Hrr0qb8=;
        b=hkcnoJCtppLWeDqZvQ4gtGHn74dTT1qEjfLfIOR+bP/HBxmxtvArtGKRxbR6OAO3bR
         tZb2V3LnyveMbhsUqtPrA5YEA1gDGdsh8Q+rMHvjkQxlQoMSy+yO5s0H/I96pfD5ujsp
         tRgSWVkW13F5Fi2yth6cvwS1PRNA3IZldaR39MF97B9bMmOG9toSjKxoNnRx16vGAMlX
         dl+QmFbeSvCWFbw7uArKuoskvRyat6h8n874Wf2xpNna2hE1e9CpgmgmeJnSD4t7u4Fn
         CporVPBxZEmgo3bH38/OW+PeuaTIVVtkN8vYYnbuQeRmDmOcGBKlhmH8PbE5HtaWdE5S
         oBLw==
X-Gm-Message-State: AAQBX9cPTRBo34QJouOM1mPCKvhQRx8L/YjeY29ib0CokgIDhox/Gj6b
	/yh/njeuLy6CXJhROpbGOc6vmGtbdxynGQ==
X-Google-Smtp-Source: AKy350aP9BZQhAFTzPUer4CxwzhcyJp4LnOGC+rVX8vEtKN6aIBthDQ01+xAHhdQi118dsSq3w2rHQ==
X-Received: by 2002:a17:906:3159:b0:957:17c5:8705 with SMTP id e25-20020a170906315900b0095717c58705mr13153868eje.51.1682440538048;
        Tue, 25 Apr 2023 09:35:38 -0700 (PDT)
Received: from localhost (178-221-25-206.dynamic.isp.telekom.rs. [178.221.25.206])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906924f00b0094f507aa0e9sm7046662ejx.19.2023.04.25.09.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 09:35:37 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 25 Apr 2023 18:35:36 +0200
Message-Id: <CS5ZE898WMR0.153HXDH3AHACG@laptop-fedora>
Cc: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v3 2/2] hostfs: store permissions in extended attributes
From: =?utf-8?q?Marko_Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>,
 <linux-um@lists.infradead.org>
X-Mailer: aerc 0.14.0
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
 <20230415164821.166606-1-petrovicmarko2006@gmail.com>
 <CRYCSOJIMYCY.3UJQ3W04LGKK7@laptop-fedora>
 <9811ef569aac8a2f2ff5a9f2d1039b5d041f6377.camel@sipsolutions.net>
In-Reply-To: <9811ef569aac8a2f2ff5a9f2d1039b5d041f6377.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_093540_273899_CDFBAF89 
X-CRM114-Status: GOOD (  33.27  )
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

T24gVHVlIEFwciAxOCwgMjAyMyBhdCAxMDozMSBBTSBDRVNULCBKb2hhbm5lcyBCZXJnIHdyb3Rl
OgpIZWxsbywKVGhhbmtzIGZvciB5b3VyIHJlcGx5IQo+IEhpLAo+Cj4gT24gU3VuLCAyMDIzLTA0
LTE2IGF0IDE5OjI0ICswMjAwLCBNYXJrbyBQZXRyb3ZpxIcgd3JvdGU6Cj4gPiAKPiA+IEkgaGF2
ZSB3cml0dGVuIHRoZSB0aGlyZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4gVGhhbmsgeW91IGZvciBh
bGwgb2YgeW91cgo+ID4gcmVjb21tZW5kYXRpb25zLgo+ID4gCj4gPiBXaGlsZSB3cml0aW5nIHRo
ZSB0aGlyZCBwYXRjaCB2ZXJzaW9uLCBJIG5vdGljZWQgdGhhdCB0aGVyZSB3YXMgYQo+ID4gc2Vy
aW91cyBsaW1pdGF0aW9uIG9mIHRoZSBjb2RlIGluIHNlY29uZCBwYXRjaCwgbmFtZWx5IHRoZSB3
aG9sZQo+ID4geGF0dHJwZXJtIGZlYXR1cmUgd2FzIGF2YWlsYWJsZSBvbmx5IGFuZCBvbmx5IGFz
IGJvb3QgdGltZSBmbGFnIHNvIGl0Cj4gPiBjb3VsZCBub3QgYmUgdXNlZCB3aGVuIGhvc3RmcyB3
YXMgYnVpbHQgYXMgbW9kdWxlIHNpbmNlIG1vZHVsZXMgZG9uJ3QKPiA+IGhhdmUgaG9zdGZzX2Fy
Z3MoKSBmdW5jdGlvbi4KPiA+IAo+ID4gVG8gb3ZlcmNvbWUgdGhhdCBpc3N1ZSwgSSBoYXZlIGNo
YW5nZWQgdGhlIGNvbnRlbnQgb2YKPiA+IHN0cnVjdCBzdXBlcl9ibG9jayAtPiBzX2ZzX2luZm8g
dG8gcG9pbnQgdG8gYSBzdHJ1Y3QgaG9zdGZzX2ZzX2luZm8KPiA+IGNvbnRhaW5pbmcgdGhlIHN0
cmluZyB0aGF0IHdhcyBwcmV2aW91c2x5IHRoZXJlICh0byBiZSB1c2VkIGJ5IG9sZAo+ID4gZnVu
Y3Rpb25zKSBhbmQgdGhlIHBlci1tb3VudHBvaW50IHVzZV94YXR0ciBmbGFnLgo+ID4gVGhpcyBh
bGxvd3MgZWFzeSBleHRlbmRpbmcgb2YgbW91bnQgb3B0aW9ucyBpbiB0aGUgZnV0dXJlIGFuZCB0
aHVzCj4gPiBwcm92aWRpbmcgbW9yZSBmbGV4aWJpbGl0eSB0byB1c2Vyc3BhY2UgdG8gY29uZmln
dXJlIHRoZSBmaWxlc3lzdGVtLgo+ID4gRm9yIGV4YW1wbGUsIGhvc3Rmc19hdHRyLCBhY2wgYW5k
IG5vYWNsIGNvdWxkIGJlIHRoZSBtb3VudCBvcHRpb25zIGFkZGVkCj4gPiBmb3IgUE9TSVggQUNM
cyBhbmQgZXh0ZW5kZWQgYXR0cmlidXRlcyBpbiB0aGUgZnV0dXJlIGFuZCBpZiB0aGVyZSBpcyBh
Cj4gPiBkZXNpcmUgZm9yIHRoYXQsIGFwcGVuZCBjb3VsZCBiZWNvbWUgYSBtb3VudCBvcHRpb24g
bm93IHRvby4KPiA+IAo+ID4gUmVnYXJkaW5nIHhhdHRycGVybSBhcyB0aGUga2VybmVsIGJvb3Qg
cGFyYW1ldGVyLCBJIGxlZnQgaXQgYXZhaWxhYmxlIGFuZAo+ID4gaXQgZGVmaW5lcyB0aGUgZGVm
YXVsdCBiZWhhdmlvciB3aGVuIG1vdW50aW5nIHRoZSBmaWxlc3lzdGVtICh3aGVuCj4gPiBuZWl0
aGVyIHhhdHRycGVybSBub3Igbm94YXR0cnBlcm0gaXMgc3BlY2lmaWVkIGluIG1vdW50IG9wdGlv
bnMpLgo+Cj4gSXQgc2VlbXMgdGhhdCBfbWF5YmVfLCBzaW1pbGFyIHRvIHRoZSAnaG9zdGZzJyBr
ZXJuZWwgYXJndW1lbnQsIHRoZXJlCj4gc2hvdWxkIGJlIGEgd2F5IHRvIGNvbnRhaW4gdGhlIHNl
dCBvZiBvcHRpb25zPwo+Cj4gV2hhdCBkbyBJIG1lYW4gYnkgdGhhdD8gSSBtZWFuIHRoYXQgdG9k
YXksIHRoZSBpbnNpZGUgb2YgdGhlIHZpcnR1YWwKPiBtYWNoaW5lIChmb3IgbGFjayBvZiBhIGJl
dHRlciB3b3JkKSBjYW4gb25seSBtb3VudCBvdXRzaWRlIGZvbGRlcnMgdGhhdAo+IGFyZSBjb250
YWluZWQgaW4gdGhlIGZvbGRlciBpbmRpY2F0ZWQgYnkgdGhlICdob3N0ZnMnIGFyZ3VtZW50Lgo+
IFNpbWlsYXJseSwgcGVyaGFwcyB0aGUgIm91dHNpZGUgYWRtaW5pc3RyYXRvciIgc2hvdWxkIGJl
IGFibGUgdG8KPiBpbmRpY2F0ZSB0aGF0IHhhdHRyIHBlcm1pc3Npb25zIF9tdXN0XyBiZSB1c2Vk
LCBvciBfbXVzdCBub3RfIGJlIHVzZWQ/Ck5pY2Ugb2JzZXJ2YXRpb24uIEl0IHNob3VsZG4ndCBi
ZSBoYXJkIHRvIGRvIHRoaXMsIEkgY2FuIGp1c3QgY2hhbmdlCnRoZSBpbnRlcnByZXRlZCBtZWFu
aW5nIG9mIG1udF91c2VfeGF0dHIgYW5kIGhvc3Rmc19mc19pbmZvLT51c2VfeGF0dHIKdG8gY29t
cGx5IHdpdGggdGhpcyBiZWhhdmlvci4gVGhhbmtzIGZvciBicmluZ2luZyB0aGlzIHRvIGF0dGVu
dGlvbi4KPgo+IFdoaWNoIHdvdWxkIGltcGx5IGEgbmV3IGtlcm5lbCBhcmd1bWVudCB0aGF0IGNh
biBiZSBjb25maWd1cmVkIHRvICJmb3JjZQo+IHVzZSIsICJmb3JjZSBkb24ndCB1c2UiIGFuZCAi
ZG9uJ3QgY2FyZSIsIHdpdGggcGVyaGFwcyBldmVuIGZvciBiYWNrd2FyZAo+IGNvbXBhdGliaWxp
dHkgdGhlIGRlZmF1bHQgYmVpbmcgImZvcmNlIGRvbid0IHVzZSI/Cj4KPiBOb3Qgc3VyZS4gQW50
b24/IFJpY2hhcmQ/IEFueSBvcGluaW9ucz8KTWF5YmUgeGF0dHJwZXJtIGFuZCBub3hhdHRycGVy
bSBjYW4gYmUga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudHMKdXNlZCBmb3IgImZvcmNlIHVz
ZSIgYW5kICJmb3JjZSBkb24ndCB1c2UiIGFuZCB3aGVuIG5vbmUgaXMgc3BlY2lmaWVkLAp0aGUg
YmVoYXZpb3IgY291bGQgYmUgImRvbid0IGNhcmUiIHdoaWNoIHdvdWxkIHRodXMgYmUgdGhlIGRl
ZmF1bHQuCgpUaGF0IG1heSBhbHNvIGJlIHJlYXNvbmFibGUgZm9yIHRoZSBwdXJwb3NlIG9mIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkKc2luY2UgdGhlIHVzYWdlIG9mIGV4dGVuZGVkIGF0dHJpYnV0
ZXMgd291bGQgdGhlbiBiZSBzcGVjaWZpZWQgYXMgYW4gbW91bnQKb3B0aW9uIGFuZCBhcHBsaWNh
dGlvbnMgbm90IGF3YXJlIG9mIGl0IHdvdWxkIGp1c3QgdXNlIHRoZSBvbGQgYmVoYXZpb3IKKHNp
bmNlIHRoZSBleHRlbmRlZCBhdHRyaWJ1dGVzIHdvdWxkIGJlIHVzZWQgb25seSB3aGVuIHNwZWNp
ZmllZCBpbgptb3VudCBvcHRpb25zKS4KCk9uIHRoZSBvdGhlciBoYW5kLCB0aGF0IHdvdWxkIHJl
cXVpcmUgYSBsaXR0bGUgZGlmZmVyZW50IG1vdW50aW5nIG9mCnJvb3QgZmlsZXN5c3RlbS4gTWF5
YmUgYWRkaW5nIHJvb3R4YXR0cnBlcm0gYXMgYSBuZXcga2VybmVsIGNvbW1hbmQgbGluZQphcmd1
bWVudCBmb3IgbW91bnRpbmcgcm9vdCB3aXRoICJyb290ZnN0eXBlPWhvc3RmcyBob3N0ZnM9cm9v
dHhhdHRycGVybSIKY291bGQgYmUgdGhlIHNvbHV0aW9uIChmb3Igd2hlbiByb290IHNob3VsZCB1
c2UgZXh0ZW5kZWQgYXR0cmlidXRlcywgYnV0CnRoZSBnZW5lcmFsIGJlaGF2aW9yIHNob3VsZCBz
dGlsbCBiZSAiZG9uJ3QgY2FyZSIpPwpXaGF0IGFyZSB5b3VyIG9waW5pb25zPwoKQmVzdCByZWdh
cmRzLApNYXJrbyBQZXRyb3ZpxIcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
dW0K
