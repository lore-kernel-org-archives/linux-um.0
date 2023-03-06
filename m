Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1A1C678D4
	for <linux-um@archiver.kernel.org>; Mon,  6 Mar 2023 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/6SVNaW8xzadBKxjlXdONUWWV5f2gZqZ3ixT404+HtI=; b=HzF4mTngwVlnvd
	YZo/QA/XKtrH1wbd4WzoiVYO6YZhLn2Adm2fH2LQb7nfv99aIjuLdMXLtO/D6VzxXbRv+J3TGIs5L
	NYinzdc6afQt+P4DCuIV5KcV5latYPflM5ZmrtpIxSdI+SAGCJO6Vj4Ipd4G1ZDD4T/wTyk2eIKlo
	aKGPzbJLcRVc0BhXCtDMJJEnj43IsiHNMHwzh5p+j88kbcDqxtdao2LsM+16qlz/E0r6z8K9gFY5L
	1bRVqOoZviXFFEoKbt0vDj1bHmXiVf/gcj/ELksQ3u5esaWhUEa2iNf19GnMMGmwxHgtAe0SZW8Pr
	1zSu/yHL3BZ1xgqefoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZCNF-00DW61-Hi; Mon, 06 Mar 2023 15:03:37 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZCN9-00DW31-EY
	for linux-um@lists.infradead.org; Mon, 06 Mar 2023 15:03:33 +0000
Received: by mail-qt1-x835.google.com with SMTP id y10so10811409qtj.2
        for <linux-um@lists.infradead.org>; Mon, 06 Mar 2023 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678115009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HMH11DaGTaXP5Kg7KWcarVQSoUphrJzN35p/leafus=;
        b=PZ+tgh//XFXTI2guva1HgTFSzTBNqktat7MIz9bOn24EDy4LVWVHtazYw5t4wl8XOY
         AeVUCuLl3NRhinu3vouLgsVYJ34pqeAaxHNuEx8I5ddhqrgWwT0du9Xgg3FMJ2TIN1UD
         UOJsbpGu05P4XviiO4ZHoG++eMMdxXMKHw0Cc4eyYU74Lmr7RT2zWZiw91DJotdnbdjb
         2q4EH0rhro8FUyM9cH6P/BZPvhNPnBngJnsRW0d8J7fs+hTK7ZU3pZl1/q2erAd8e7k+
         qF0ll2xfEmR/AZZxiLaKEnGBJjBbIxRjYFzYJa4jALC9T1gMI4vAaLhbizy5NvA1T5zG
         9tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678115009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HMH11DaGTaXP5Kg7KWcarVQSoUphrJzN35p/leafus=;
        b=PXHAln/cuVgZw1v64TGsKEnMrhM2GG6mwIILKki5SKiDmSWZuP6t8JWVRKoZeZWjt0
         FkQwU0P5HzIH92Ed/NEJRz5KGR85EaYF0h6mvC5GlJCpE1NtExlvWb+MO5EGHdFAhcE1
         6LIX5zVXiLf2zDBbJrD15qO7ymaSKfYWn1bVkeAnypr2ux2cnslJ7wqr1dyjyMytxLjQ
         qoFGX8pfMCC4p4VKDMYINQOqtOfa0seQkS8/6ahM4ol39LEyUXHgbn9mTqNwjtzSpYl2
         HxwoH/LfBr8YbOrLZoexyGmT0tHqa9V59em+gqYFs+kLtOnSSRfK8TfySU1rAYBGxKhi
         sRRQ==
X-Gm-Message-State: AO0yUKWtxigEIpFKnLMvinRch0RkpIer/mRchqnOcvzcZ4nt2MuLXEwQ
	UPt/NFdztxxkWfrDMwoyysc=
X-Google-Smtp-Source: AK7set/TDMQSsAQ1hzPV9uhS7dPiUj7hXcHVTIntliNYs59ypWEiaD5fgYhKtuh8THhyXN4RDDXTGg==
X-Received: by 2002:ac8:5b56:0:b0:3bf:dbd3:a014 with SMTP id n22-20020ac85b56000000b003bfdbd3a014mr14455969qtw.45.1678115008930;
        Mon, 06 Mar 2023 07:03:28 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:64c7:9450:aac2:7f08? ([2600:1700:2442:6db0:64c7:9450:aac2:7f08])
        by smtp.gmail.com with ESMTPSA id j26-20020ac874da000000b003b82489d8acsm7600561qtr.21.2023.03.06.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:03:28 -0800 (PST)
Message-ID: <b27b1926-ea79-4e77-b0ca-60d4ac1ca7ce@gmail.com>
Date: Mon, 6 Mar 2023 09:03:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J.Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
 <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
 <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
 <c81211fa-2836-fe21-637f-a5cca7237d43@gmail.com>
 <CAL_Jsq+yhdSqiAVfUKh1DGaKTEGHOMPKAYpQPPB=ywA76C6EvA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_Jsq+yhdSqiAVfUKh1DGaKTEGHOMPKAYpQPPB=ywA76C6EvA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_070331_565776_AD32A5C3 
X-CRM114-Status: GOOD (  28.18  )
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

T24gMy82LzIzIDA2OjUzLCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBTYXQsIE1hciA0LCAyMDIz
IGF0IDk6MznigK9BTSBGcmFuayBSb3dhbmQgPGZyb3dhbmQubGlzdEBnbWFpbC5jb20+IHdyb3Rl
Ogo+Pgo+PiBPbiAzLzIvMjMgMTc6NTcsIFN0ZXBoZW4gQm95ZCB3cm90ZToKPj4+IFF1b3Rpbmcg
Um9iIEhlcnJpbmcgKDIwMjMtMDMtMDIgMTI6MTg6MzQpCj4+Pj4gT24gVGh1LCBNYXIgMiwgMjAy
MyBhdCAxOjQ04oCvUE0gU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPj4+
Pj4KPj4+Pj4gUXVvdGluZyBSb2IgSGVycmluZyAoMjAyMy0wMy0wMiAwOToxMzo1OSkKPj4+Pj4+
Cj4+Pj4+PiBHb29kIHRvIHNlZSBiaW5kaW5ncyBmb3IgdGhpcy4gSSd2ZSBiZWVuIG1lYW5pbmcg
dG8gZG8gc29tZXRoaW5nIGFib3V0Cj4+Pj4+PiB0aGUgRFQgdW5pdHRlc3Qgb25lcyBiZWluZyB1
bmRvY3VtZW50ZWQsIGJ1dCBJIGhhZG4ndCByZWFsbHkgZGVjaWRlZAo+Pj4+Pj4gd2hldGhlciBp
dCB3YXMgd29ydGggd3JpdGluZyBzY2hlbWFzIGZvciB0aGVtLiBUaGUgY29tcGF0aWJsZXMgYXQK
Pj4+Pj4+IGxlYXN0IHNob3cgdXAgd2l0aCAnbWFrZSBkdF9jb21wYXRpYmxlX2NoZWNrJy4gUGVy
aGFwcyB3ZSB3YW50IHRvIGp1c3QKPj4+Pj4+IGRlZmluZSBzb21lIHZlbmRvciAobm90ICdsaW51
eCcpIHRoYXQncyBhbiBleGNlcHRpb24gcmF0aGVyIHRoYW4KPj4+Pj4+IHJlcXVpcmluZyBzY2hl
bWFzIChhY3R1YWxseSwgdGhhdCBhbHJlYWR5IHdvcmtzIGZvciAnZm9vJykuCj4+Pj4+Cj4+Pj4+
IFN1cmUuIE1heWJlICJrdW5pdCIgc2hvdWxkIGJlIHRoZSB2ZW5kb3IgcHJlZml4PyBPciAiZHRi
dW5pdCI/Cj4+Pj4KPj4+PiBXZSdkIHdhbnQgdG8gdXNlIHRoZSBzYW1lIHRoaW5nIG9uIHRoZSBE
VCB1bml0dGVzdHMgb3IgYW55dGhpbmcgZWxzZQo+Pj4+IHBvdGVudGlhbGx5LiBIb3cgYWJvdXQg
anVzdCAndGVzdCc/Cj4+Pgo+Pj4gU291bmRzIGdvb2QuCj4+Pgo+Pj4+Cj4+Pj4+PiBJdCdzCj4+
Pj4+PiBsaWtlbHkgdGhhdCB3ZSB3YW50IHRlc3QgRFRzIHRoYXQgZmFpbCBub3JtYWwgY2hlY2tz
IGFuZCBzY2hlbWFzIGdldAo+Pj4+Pj4gaW4gdGhlIHdheSBvZiB0aGF0IGFzIHdlIGRvbid0IGhh
dmUgYSB3YXkgdG8gdHVybiBvZmYgY2hlY2tzLgo+Pj4+Pgo+Pj4+PiBIYXZpbmcgdGhlIHNjaGVt
YXMgaXMgbmljZSB0byBtYWtlIHN1cmUgdGVzdHMgdGhhdCBhcmUgZXhwZWN0aW5nIHNvbWUKPj4+
Pj4gYmluZGluZyBhcmUgYWN0dWFsbHkgZ2V0dGluZyB0aGF0LiBCdXQgc3VwcG9ydGluZyBicm9r
ZW4gYmluZGluZ3MgaXMKPj4+Pj4gYWxzbyBpbXBvcnRhbnQgdG8gdGVzdCBhbnkgZXJyb3IgcGF0
aHMgaW4gZnVuY3Rpb25zIHRoYXQgcGFyc2UKPj4+Pj4gcHJvcGVydGllcy4gTWF5YmUgd2Uga2Vl
cCB0aGUgc2NoZW1hIGFuZCBoYXZlIGl0IGVuZm9yY2UgdGhhdCBpbmNvcnJlY3QKPj4+Pj4gcHJv
cGVydGllcyBhcmUgYmVpbmcgc2V0Pwo+Pj4+Cj4+Pj4gSSB3YXNuJ3Qgc3VnZ2VzdGluZyB0aHJv
d2luZyB0aGVtIG91dC4gTW9yZSB3aHkgSSBoYWRuJ3Qgd3JpdHRlbiBhbnkgSSBndWVzcy4KPj4+
Pgo+Pj4+PiBEbyB3ZSByZWFsbHkgbmVlZCB0byB0ZXN0IGluY29ycmVjdCBiaW5kaW5ncz8gRG9l
c24ndCB0aGUKPj4+Pj4gZHRfYmluZGluZ3NfY2hlY2sgY2F0Y2ggdGhlc2UgcHJvYmxlbXMgc28g
d2UgZG9uJ3QgaGF2ZSB0byB3cml0ZSBEVEIKPj4+Pj4gdmVyaWZpZXJzIGluIHRoZSBrZXJuZWw/
Cj4+Pj4KPj4+PiBGYWlyIGVub3VnaC4gVXNpbmcgbXkgZnJlcXVlbnRseSBzdGF0ZWQgcG9zaXRp
b24gYWdhaW5zdCBtZS4gOikKPj4+Pgo+Pj4+IEkgZG8gaGF2ZSBhIHNlY3JldCBwbGFuIHRvIGlt
cGxlbWVudCAoZGVidWcpIHR5cGUgY2hlY2tzIGludG8gdGhlCj4+Pj4gb2ZfcHJvcGVydHlfKiBB
UElzIGJ5IGV4dHJhY3RpbmcgdGhlIHR5cGUgaW5mb3JtYXRpb24gZnJvbSBzY2hlbWFzCj4+Pj4g
aW50byBDLgo+Pj4+Cj4+Pgo+Pj4gT2suIEkgc3VzcGVjdCB3ZSBtYXkgd2FudCB0byB0ZXN0IGVy
cm9yIHBhdGhzIHRob3VnaCBzbyBJIGRvbid0IGtub3cKPj4KPj4gWWVzLCBleGFjdGx5Lgo+Pgo+
Pj4gd2hhdCB0byBkbyBoZXJlLiBGb3Igbm93IEknbGwganVzdCBsZWF2ZSB0aGUgYmluZGluZ3Mg
aW4gcGxhY2UgYW5kCj4+PiBjaGFuZ2UgdGhlIHByZWZpeCB0byAidGVzdCIuCj4+Pgo+Pj4+Cj4+
Pj4+PiBXZSBhbHJlYWR5IGhhdmUgR1BJTyB0ZXN0cyBpbiB0aGUgRFQgdW5pdHRlc3RzLCBzbyB3
aHkgaXMgY2xvY2tzCj4+Pj4+PiBkaWZmZXJlbnQ/IE9yIHNob3VsZCB0aGUgR1BJTyB0ZXN0cyBi
ZSBtb3ZlZCBvdXQgKHllcywgcGxlYXNlISk/Cj4+Pj4+Cj4+Pj4+IEFoIEkgZGlkbid0IG5vdGlj
ZSB0aGUgR1BJTyB0ZXN0cyBpbiB0aGVyZS4gVGhlcmUgYXJlIGkyYyB0ZXN0cyB0b28sCj4+Pj4+
IHJpZ2h0PyBBbGwgSSBjYW4gc2F5IGlzIGNsa3MgYXJlIHVzaW5nIGt1bml0LCB0aGF0J3MgdGhl
IGRpZmZlcmVuY2UgOy0pCj4+Pj4KPj4+PiBZZWFoLCB0aGV5IHNob3VsZCBwZXJoYXBzIGFsbCBt
b3ZlIHRvIHRoZSBzdWJzeXN0ZW1zLgo+Pj4KPj4+IEdvdCBpdC4KPj4+Cj4+Pj4KPj4+Pj4+IFdo
YXQgaGFwcGVucyB3aGVuL2lmIHRoZSBEVCB1bml0dGVzdCBpcyBjb252ZXJ0ZWQgdG8ga3VuaXQ/
IEkgdGhpbmsKPj4+Pj4+IHRoYXQgd291bGQgbG9vayBjb25mdXNpbmcgZnJvbSB0aGUgbmFtaW5n
LiBNeSBpbml0aWFsIHRob3VnaHQgaXMKPj4+Pj4+ICdrdW5pdCcgc2hvdWxkIGJlIGRyb3BwZWQg
ZnJvbSB0aGUgbmFtaW5nIG9mIGEgbG90IG9mIHRoaXMuIE5vdGUgdGhhdAo+Pj4+Pj4gdGhlIG9y
aWdpbmFsIGt1bml0IHN1Ym1pc3Npb24gY29udmVydGVkIHRoZSBEVCB1bml0dGVzdHMuIEkgd291
bGQKPj4+Pj4+IHN0aWxsIGxpa2UgdG8gc2VlIHRoYXQgaGFwcGVuLiBGcmFuayBkaXNhZ3JlZWQg
b3ZlciB3aGF0J3MgYSB1bml0IHRlc3QKPj4+Pj4+IG9yIG5vdCwgdGhlbiBhZ3JlZWQsIHRoZW4g
ZGlkbid0Li4uIEkgZG9uJ3QgcmVhbGx5IGNhcmUuIElmIHRoZXJlJ3MgYQo+Pj4+Pj4gZnJhbWV3
b3JrIHRvIHVzZSwgdGhlbiB3ZSBzaG91bGQgdXNlIGl0IElNTy4KPj4+Pj4KPj4+Pj4gSG9uZXN0
bHkgSSBkb24ndCB3YW50IHRvIGdldCBpbnZvbHZlZCBpbiBtaWdyYXRpbmcgdGhlIGV4aXN0aW5n
IERUCj4+Pj4+IHVuaXR0ZXN0IGNvZGUgdG8ga3VuaXQuIEknbSBhd2FyZSB0aGF0IGl0IHdhcyBh
dHRlbXB0ZWQgeWVhcnMgYWdvIHdoZW4KPj4+Pj4ga3VuaXQgd2FzIGludHJvZHVjZWQuIE1heWJl
IGlmIHRoZSBvdmVybGF5IHJvdXRlIHdvcmtzIHdlbGwgZW5vdWdoIEkgY2FuCj4+Pj4+IGNvbXBs
ZXRlbHkgc2lkZXN0ZXAgaW50cm9kdWNpbmcgYW55IGNvZGUgaW4gZHJpdmVycy9vZi8gYmVzaWRl
cyBzb21lCj4+Pj4+IGt1bml0IHdyYXBwZXJzIGZvciB0aGlzLiBJJ2xsIGNyb3NzIG15IGZpbmdl
cnMhCj4+Pj4KPj4+PiBZZWFoLCBJIHdhc24ndCBleHBlY3RpbmcgeW91IHRvLiBJIGp1c3Qgd2Fu
dCB0byBtYWtlIHN1cmUgdGhpcyBtZXNoZXMKPj4+PiB3aXRoIGFueSBmdXR1cmUgY29udmVyc2lv
biB0byBrdW5pdC4KPj4+Cj4+PiBQaGV3IQo+Pj4KPj4+Pgo+Pj4+IFRoZXJlJ3MgYWxzbyBzb21l
IHBsYW5zIHRvIGFsd2F5cyBwb3B1bGF0ZSB0aGUgRFQgcm9vdCBub2RlIGlmIG5vdAo+Pj4+IHBy
ZXNlbnQuIFRoYXQgbWF5IGhlbHAgaGVyZS4gT3Igbm90LiBUaGVyZSdzIGJlZW4gYSBmZXcgdmVy
c2lvbnMKPj4+PiBwb3N0ZWQgd2l0aCBGcmFuaydzIGluIHRoZSBsYXN0IHdlZWsgb3IgMi4KPj4+
Pgo+Pj4KPj4+IE9rLiBJIHRoaW5rIEkgaGF2ZSBzb21lIHRpbWUgdG8gdHJ5IHRoaXMgb3Zlcmxh
eSBhcHByb2FjaCBzbyBsZXQgbWUgc2VlCj4+PiB3aGF0IGlzIG5lZWRlZC4KPj4KPj4gUGxlYXNl
IGF2b2lkIG92ZXJsYXlzLiAgU2VlIG15IG90aGVyIHJlcGxpZXMgaW4gdGhpcyB0aHJlYWQgZm9y
IHdoeS4KPiAKPiBJZiBvdmVybGF5cyB3b3JrIGZvciB0aGUgY29uc3RyYWluZWQgZW52aXJvbm1l
bnQgb2YgdW5pdCB0ZXN0cywgdGhlbgo+IHVzZSB0aGVtLiBJZiBvdmVybGF5cyBhcmUgbm90IHRv
IGJlIHVzZWQsIHRoZW4gcmVtb3ZlIHRoZSBzdXBwb3J0IGZyb20KPiB0aGUga2VybmVsLiBQdXR0
aW5nIGlzc3VlcyBpbiBhIHRvZG8gbGlzdCBpcyBub3QgZ29pbmcgdG8gZ2V0IHRoZW0KPiBkb25l
LiBIYXZpbmcgdXNlcnMgd2lsbC4KCk92ZXJsYXlzIGFyZSBub3QgdXNlZCB0byBlbmFibGUgT0Yg
dW5pdHRlc3RzIHRoYXQgYXJlIHVucmVsYXRlZCB0bwpvdmVybGF5cyAodG8gdGhlIGJlc3Qgb2Yg
bXkgbWVtb3J5IC0gSSByZXNlcnZlIHRoZSByaWdodCB0byBiZQpjb3JyZWN0ZWQpLiAgT3Zlcmxh
eSB1c2FnZSBpbiBPRiB1bml0dGVzdHMgaXMgc3BlY2lmaWNhbGx5IHRvIHRlc3QKb3ZlcmxheSBm
ZWF0dXJlcy4KCj4gCj4gUm9iCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=
