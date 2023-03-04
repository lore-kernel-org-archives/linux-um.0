Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4199C64EC4
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H8dSx53VSZdJH4iP2iIXk+UKe/a7ShVNj6iyQHiDqXw=; b=UlSad8YpG2jQLa
	cFalj2hVvO2AS2Nqy8uxH2ELsUXMx4Bmj+bs3IUjRFjQxQhrMiYMozt7aCx6AsPYRXZRWivTVQ3W/
	edPBhUWA+XjDHLSG3tl7wqFe9ldFUYxbkxQvhjjQyrsKzlIideQxJI/Qxf6J5iD+i1upgq+m3IgCA
	csqGVYxESnC4IijPPdKHihFgNfBuBrhW1xTZue5p9KIHM0CARN75D6RQBeouUfKcjMDs86TGui8GK
	iY3faEm05AJ/2FUNkYncO5aqzZVqpy21Pu3Cw1kwX0mzJuddAZaIC4vYhQOoTyX6HAlGTPdhvIpk/
	fAgCu+dVHJnD+AvD7FCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTtb-009BR4-JN; Sat, 04 Mar 2023 15:34:03 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYTtY-009BPi-0X
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 15:34:01 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id op8so3738507qvb.11
        for <linux-um@lists.infradead.org>; Sat, 04 Mar 2023 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPOaMM4z/o/74PWOB79M+Z3qoHNCo5CnO+zcqkcRKQo=;
        b=FvXAAn2o1qSeFTpmCvjX35ic+nx2wrMTtgs5IZUCRmYfH/jWs3Utbv1hSN31qk0BqT
         +SVXT3xIva4p3q+b3tBWSHE6tttaDu/M9zkxFMZciSiaX/2OsJ+z0Mghg+IWrWQfB0MI
         FaT+EEsdfcuduxbAzdz9HPSxNDhzsRaxqvd9Nft6HmohCCZXGU5dJAYnqyzLPI9Ouv2J
         i8YlTqRA2zBX1YVidCx33Di1NiWLVNRluX0D5yjFepOjMGBOZBKRVDWoeXeHBU4jWNRr
         yCXZeQGyx7yZj2hDijcjUWbPQfcPpgX7NGtqNsEiBNhazvOfh45Fs6qSEFcXshfW/Nty
         2JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPOaMM4z/o/74PWOB79M+Z3qoHNCo5CnO+zcqkcRKQo=;
        b=3LV3OmxbA4cOBhq1HGMRWaU6ew8Kg1wNGomoTtCxn/nrdMzTuf892/g2qG1gPHzC0Y
         wVAymfFKKhfUgK2mXj27DluKns/Rw25ZWC8p/EaosKA9a15FWh3Zlnp4AXiNND/e2lxI
         0z+5B48VoCyRpkgJ2qXFthkJwH3EwWkvSGAPOqowkUoyX5c6x+WhMzVg3vIZs6xxDkq+
         dwUhq4EClcY2SjXXye8oZhARdsltspDxmoWUC2hWhnFxz+dParB50v8PrkX4p+IUekJt
         Kz1xPcWCeLUcUsbh8cdiM6cD6tkKW1GP5oivmFLnXOss2o49mAvA5p3lk7q8zBojZ0o1
         3PwQ==
X-Gm-Message-State: AO0yUKUbR4uYis7Zq0+PEQgHZZ+kYcd+mgYvTEpop0Eq3q6mK8OxwPCr
	kHGkQK+wm/haNQXQ7SwPssI=
X-Google-Smtp-Source: AK7set/T7IN44aotHKkdLQvQ0WoRv5q5jtuBgNAw15hXHEf80xrX+2vcxqYGR9yqGE61Tg2YbRjKbw==
X-Received: by 2002:a05:6214:d05:b0:56f:154:2517 with SMTP id 5-20020a0562140d0500b0056f01542517mr9775900qvh.10.1677944029257;
        Sat, 04 Mar 2023 07:33:49 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id c134-20020ae9ed8c000000b0073d873df3fesm2859393qkg.30.2023.03.04.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:33:48 -0800 (PST)
Message-ID: <1f56d371-9344-5c45-0024-ede99c551148@gmail.com>
Date: Sat, 4 Mar 2023 09:33:48 -0600
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
 "Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-um@lists.infradead.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230304_073400_140870_BF738461 
X-CRM114-Status: GOOD (  40.47  )
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

T24gMy8yLzIzIDExOjEzLCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBXZWQsIE1hciAxLCAyMDIz
IGF0IDc6MzjigK9QTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+
PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHVuaXQgdGVzdHMgZm9yIHRoZSBjbGsgZml4ZWQgcmF0
ZSBiYXNpYyB0eXBlIGFuZAo+PiB0aGUgY2xrIHJlZ2lzdHJhdGlvbiBmdW5jdGlvbnMgdGhhdCB1
c2Ugc3RydWN0IGNsa19wYXJlbnRfZGF0YS4gVG8gZ2V0Cj4+IHRoZXJlLCB3ZSBhZGQgc3VwcG9y
dCBmb3IgbG9hZGluZyBhIERUQiBpbnRvIHRoZSBVTUwga2VybmVsIHRoYXQncwo+PiBydW5uaW5n
IHRoZSB1bml0IHRlc3RzIGFsb25nIHdpdGggcHJvYmluZyBwbGF0Zm9ybSBkcml2ZXJzIHRvIGJp
bmQgdG8KPj4gZGV2aWNlIG5vZGVzIHNwZWNpZmllZCBpbiBEVC4KPj4KPj4gV2l0aCB0aGlzIHNl
cmllcywgd2UncmUgYWJsZSB0byBleGVyY2lzZSBzb21lIG9mIHRoZSBjb2RlIGluIHRoZSBjb21t
b24KPj4gY2xrIGZyYW1ld29yayB0aGF0IHVzZXMgZGV2aWNldHJlZSBsb29rdXBzIHRvIGZpbmQg
cGFyZW50cyBhbmQgdGhlIGZpeGVkCj4+IHJhdGUgY2xrIGNvZGUgdGhhdCBzY2FucyBkZXZpY2V0
cmVlIGRpcmVjdGx5IGFuZCBjcmVhdGVzIGNsa3MuIFBsZWFzZQo+PiByZXZpZXcuCj4+Cj4+IEkg
Q2NlZCBldmVyeW9uZSB0byBhbGwgdGhlIHBhdGNoZXMgc28gdGhleSBnZXQgdGhlIGZ1bGwgY29u
dGV4dC4gSSdtCj4+IGhvcGluZyBJIGNhbiB0YWtlIHRoZSB3aG9sZSBwaWxlIHRocm91Z2ggdGhl
IGNsayB0cmVlIGFzIHRoZXkgYWxtb3N0IGFsbAo+PiBkZXBlbmQgb24gZWFjaCBvdGhlci4gSW4g
dGhlIGZ1dHVyZSBJIGltYWdpbmUgaXQgd2lsbCBiZSBlYXN5IHRvIGFkZAo+PiBtb3JlIHRlc3Qg
bm9kZXMgdG8gdGhlIGNsay5kdHNpIGZpbGUgYW5kIG5vdCBuZWVkIHRvIGdvIGFjcm9zcyB2YXJp
b3VzCj4+IG1haW50YWluZXIgdHJlZXMgbGlrZSB0aGlzIHNlcmllcyBkb2VzLgo+Pgo+PiBTdGVw
aGVuIEJveWQgKDgpOgo+PiAgIGR0LWJpbmRpbmdzOiBBZGQgbGludXgsa3VuaXQgYmluZGluZwo+
PiAgIG9mOiBFbmFibGUgRFRCIGxvYWRpbmcgb24gVU1MIGZvciBLVW5pdCB0ZXN0cwo+PiAgIGt1
bml0OiBBZGQgdGVzdCBtYW5hZ2VkIHBsYXRmb3JtX2RldmljZS9kcml2ZXIgQVBJcwo+PiAgIGNs
azogQWRkIHRlc3QgbWFuYWdlZCBjbGsgcHJvdmlkZXIvY29uc3VtZXIgQVBJcwo+PiAgIGR0LWJp
bmRpbmdzOiBrdW5pdDogQWRkIGZpeGVkIHJhdGUgY2xrIGNvbnN1bWVyIHRlc3QKPj4gICBjbGs6
IEFkZCBLVW5pdCB0ZXN0cyBmb3IgY2xrIGZpeGVkIHJhdGUgYmFzaWMgdHlwZQo+PiAgIGR0LWJp
bmRpbmdzOiBjbGs6IEFkZCBLVW5pdCBjbGtfcGFyZW50X2RhdGEgdGVzdAo+PiAgIGNsazogQWRk
IEtVbml0IHRlc3RzIGZvciBjbGtzIHJlZ2lzdGVyZWQgd2l0aCBzdHJ1Y3QgY2xrX3BhcmVudF9k
YXRhCj4gCj4gR29vZCB0byBzZWUgYmluZGluZ3MgZm9yIHRoaXMuIEkndmUgYmVlbiBtZWFuaW5n
IHRvIGRvIHNvbWV0aGluZyBhYm91dAo+IHRoZSBEVCB1bml0dGVzdCBvbmVzIGJlaW5nIHVuZG9j
dW1lbnRlZCwgYnV0IEkgaGFkbid0IHJlYWxseSBkZWNpZGVkCj4gd2hldGhlciBpdCB3YXMgd29y
dGggd3JpdGluZyBzY2hlbWFzIGZvciB0aGVtLiBUaGUgY29tcGF0aWJsZXMgYXQKPiBsZWFzdCBz
aG93IHVwIHdpdGggJ21ha2UgZHRfY29tcGF0aWJsZV9jaGVjaycuIFBlcmhhcHMgd2Ugd2FudCB0
byBqdXN0Cj4gZGVmaW5lIHNvbWUgdmVuZG9yIChub3QgJ2xpbnV4JykgdGhhdCdzIGFuIGV4Y2Vw
dGlvbiByYXRoZXIgdGhhbgo+IHJlcXVpcmluZyBzY2hlbWFzIChhY3R1YWxseSwgdGhhdCBhbHJl
YWR5IHdvcmtzIGZvciAnZm9vJykuIEl0J3MKPiBsaWtlbHkgdGhhdCB3ZSB3YW50IHRlc3QgRFRz
IHRoYXQgZmFpbCBub3JtYWwgY2hlY2tzIGFuZCBzY2hlbWFzIGdldAo+IGluIHRoZSB3YXkgb2Yg
dGhhdCBhcyB3ZSBkb24ndCBoYXZlIGEgd2F5IHRvIHR1cm4gb2ZmIGNoZWNrcy4KPiAKPiBXZSBh
bHJlYWR5IGhhdmUgR1BJTyB0ZXN0cyBpbiB0aGUgRFQgdW5pdHRlc3RzLCBzbyB3aHkgaXMgY2xv
Y2tzCj4gZGlmZmVyZW50PyBPciBzaG91bGQgdGhlIEdQSU8gdGVzdHMgYmUgbW92ZWQgb3V0ICh5
ZXMsIHBsZWFzZSEpPwo+IAo+IFdoYXQgaGFwcGVucyB3aGVuL2lmIHRoZSBEVCB1bml0dGVzdCBp
cyBjb252ZXJ0ZWQgdG8ga3VuaXQ/IEkgdGhpbmsKCk15IGN1cnJlbnQgcGxhbiBpcyB0byB1cGRh
dGUgdGhlIERUIHVuaXR0ZXN0IG91dHB1dCB0byBiZSBjb21wYXRpYmxlCndpdGggdGhlIGt1bml0
IG91dHB1dCwgc28gdGVzdCBoYXJuZXNzZXMgY2FuIHVzZSB0aGUgc2FtZSBmcmFtZXdvcmsKdG8g
cHJvY2VzcyB0ZXN0IG91dHB1dCwgYW5kIGRldGVjdCBhbmQgcmVwb3J0IHJlc3VsdHMuCgprdW5p
dCBtb3ZlZCB0byB0aGUgS1RBUCBmb3JtYXQgYSB3aGlsZSBhZ28uICBJIGFtIHdvcmtpbmcgKG1v
cmUgc2xvd2x5CnRoYW4gSSB3b3VsZCBsaWtlKSB0byBnZXQgdGhlIG5leHQgdmVyc2lvbiBvZiB0
aGUgS1RBUCBzcGVjaWZpY2F0aW9uCmFncmVlZCB0bywgd2hpY2ggaGFzIHNvbWUgZmVhdHVyZXMg
dGhhdCB3aWxsIGJlIG5lZWRlZCB0byBtb3ZlIERUCnVuaXR0ZXN0cyB0byB0aGUgS1RBUCBvdXRw
dXQgZm9ybWF0LgoKV2hldGhlciBpdCBpcyBwb3NzaWJsZSB0byBzdWJzZXF1ZW50bHkgbW92ZSBE
VCB1bml0dGVzdHMgaW50byB0aGUKa3VuaXQgZnJhbWV3b3JrIGlzIGEgZGlmZmVyZW50IHF1ZXN0
aW9uLCB3aGljaCBjb3VsZCBiZSBhZGRyZXNzZWQKYXMgYSBwb3NzaWJsZSBuZXh0IHN0ZXAgb2Yg
RFQgdW5pdHRlc3QgdHJhbnNmb3JtYXRpb24gKGJ1dCBzZWUgbXkKb3BpbmlvbiBiZWxvdykuCgo+
IHRoYXQgd291bGQgbG9vayBjb25mdXNpbmcgZnJvbSB0aGUgbmFtaW5nLiBNeSBpbml0aWFsIHRo
b3VnaHQgaXMKPiAna3VuaXQnIHNob3VsZCBiZSBkcm9wcGVkIGZyb20gdGhlIG5hbWluZyBvZiBh
IGxvdCBvZiB0aGlzLiBOb3RlIHRoYXQKPiB0aGUgb3JpZ2luYWwga3VuaXQgc3VibWlzc2lvbiBj
b252ZXJ0ZWQgdGhlIERUIHVuaXR0ZXN0cy4gSSB3b3VsZAo+IHN0aWxsIGxpa2UgdG8gc2VlIHRo
YXQgaGFwcGVuLiBGcmFuayBkaXNhZ3JlZWQgb3ZlciB3aGF0J3MgYSB1bml0IHRlc3QKPiBvciBu
b3QsIHRoZW4gYWdyZWVkLCB0aGVuIGRpZG4ndC4uLiBJIGRvbid0IHJlYWxseSBjYXJlLiBJZiB0
aGVyZSdzIGEKPiBmcmFtZXdvcmsgdG8gdXNlLCB0aGVuIHdlIHNob3VsZCB1c2UgaXQgSU1PLgoK
SSBkb24ndCB0aGluayBJIGV2ZXIgYWdyZWVkIHRoYXQgdGhlIGt1bml0IGZyYW1ld29yayB3YXMg
c3VpdGFibGUgdG8KaW1wbGVtZW50IERUIHVuaXR0ZXN0LgoKQXQgYSBjb25jZXB0dWFsIGxldmVs
LCBrdW5pdCBhbmQgRFQgdW5pdHRlc3QgZGlmZmVyIGFyY2hpdGVjdHVyYWxseQoodGhlIGZvbGxv
d2luZyBpcyBub3Qgd2hhdCBrdW5pdCBsb29rcyBsaWtlIC0gdGhlIHByb2NlZHVyYWwgZmxvdyBp
cwpoaWRkZW4gYXdheSBpbiBtYWNyb3MgYW5kIHRoZSBzb3VyY2UgbG9va3MgbW9yZSBsaWtlIGRh
dGEgZGVjbGFyYXRpb25zKS4KCiAga3VuaXQKICAtLS0tLQogIHRlc3RfMV9pbml0aWFsaXphdGlv
bigpOwogIHRlc3RfMSgpOwogICAgIHRlc3RfMV9hKCk7CiAgICAgdGVzdF8xX2IoKTsKICAgICAu
Li4KICAgICB0ZXN0XzFfTigpOwogIHRlc3RfMV9jbGVhbnVwKCk7CgogICMjIEVhY2ggb2YgdGVz
dF8xXyooKSByZXBvcnRzIHBhc3MgLyBmYWlsIC8gc2tpcAogICMjIEknbSBub3Qgc3VyZSBpZiB0
aGlzIGlzIGp1c3Qgb25lIHBhc3MgLyBmYWlsIC8gc2tpcCwgb3IKICAjIyBpZiBtdWx0aXBsZSBh
cmUgc3VwcG9ydGVkLgogICMjCiAgIyMgRWFjaCBvZiB0ZXN0XzFfKigpIGFyZSBpbmRlcGVuZGVu
dCBhbmQgY291bGQgYmUgcmVvcmRlcmVkLgoKCiAgRFQgdW5pdHRlc3QKICAtLS0tLS0tLS0tLQog
IHNvbWVfaW5pdGlhbGl6YXRpb25faW5fZWFybHlfYm9vdCgpCiAgb2ZfdW5pdHRlc3QoKQogICAg
IGFfbG90X29mX2luaXRpYWxpemF0aW9uKCk7CiAgICAgc3Vic3lzdGVtX29yX2FyZWFfMV90ZXN0
KCk7CiAgICAgICAgdGVzdF9hcmVhX2luaXRpYWxpemF0aW9uKCk7CiAgICAgICAgdGVzdF8xX2Eo
KTsKICAgICAgICAjIyB0ZXN0XzFfYSgpIG1heSBvciBtYXkgbm90IGltcGFjdCB0aGUgZGV2aWNl
dHJlZSBkYXRhCiAgICAgICAgIyMgaW4gYSBtYW5uZXIgdGhhdCBpcyBwcmUtcmVxdWlzaXRlIGZv
ciB0ZXN0XzFfYigpCiAgICAgICAgdGVzdF8xX2IoKTsKICAgICAgICAuLi4KICAgICAgICAjIyBB
dCBhbnkgcG9pbnQgaW4gdGVzdF8xX2EoKSAuLiB0ZXN0XzFfTigpIG1heSBnb3RvCiAgICAgICAg
IyMgICBvdXRfRVJST1JfeHh4OiBpZiBhIHRlc3QgZmFpbHMgaW4gYSB3YXkgdGhhdAogICAgICAg
ICMjICAgaW1wYWN0cyBzdWJzZXF1ZW50IHRlc3QgZGVwZW5kZW5jaWVzCiAgICAgICAgIyMKICAg
ICAgICAjIyBQb3NzaWJsZSBjbGVhbiB1cCBiZXR3ZWVuIG9yIGFmdGVyIGVhY2ggdGVzdF8xXyoo
KQogICAgICAgICMjIFBvc3NpYmxlIHZhbGlkYXRpb24gdGhhdCB0aGUgZGV2aWNldHJlZWUgZGF0
YSBpcyBjb3JyZWN0CiAgICAgICAgIyMgICBhZnRlciB0ZXN0IGFjdGl2aXR5CiAgICAgICAgdGVz
dF8xX2MoKTsKICAgICAgICAuLi4KICAgICAgICB0ZXN0XzFfTigpOwogICAgIHN1YnN5c3RlbV9v
cl9hcmVhXzJfdGVzdCgpOwogICAgICAgIC4uLgogICAgICMjIEF0IGFyYml0cmFyeSBwb2ludHMs
IGZ1bGwgdHJlZSBvciBzdWItdHJlZSB2YWxpZGF0aW9uIHRvCiAgICAgIyMgY29uZmlybSB0cmVl
IGludGVncml0eSBhZnRlciBjb21wbGV0aW5nIHRoZSBwcmV2aW91cyB0ZXN0cwogICAgIC4uLgoK
ICAgIyMgTXVjaCBvZiB0ZXN0XzFfKigpIGFyZSBkZXBlbmRlbnQgb24gcHJldmlvdXNseSBleGVj
dXRlZAogICAjIyB0ZXN0XzFfKigpIGFuZCBjYW4gX25vdF8gYmUgcmVvcmRlcmVkLgoKLUZyYW5r
CgoKCj4gCj4+Cj4+ICAuLi4vY2xvY2svbGludXgsY2xrLWt1bml0LXBhcmVudC1kYXRhLnlhbWwg
ICAgfCAgNDcgKysKPj4gIC4uLi9rdW5pdC9saW51eCxjbGsta3VuaXQtZml4ZWQtcmF0ZS55YW1s
ICAgICB8ICAzNSArKwo+PiAgLi4uL2JpbmRpbmdzL2t1bml0L2xpbnV4LGt1bml0LnlhbWwgICAg
ICAgICAgIHwgIDI0ICsKPj4gIGFyY2gvdW0va2VybmVsL2R0Yi5jICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyOSArLQo+PiAgZHJpdmVycy9jbGsvLmt1bml0Y29uZmlnICAgICAgICAgICAg
ICAgICAgICAgIHwgICAzICsKPj4gIGRyaXZlcnMvY2xrL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNyArCj4+ICBkcml2ZXJzL2Nsay9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDYgKwo+PiAgZHJpdmVycy9jbGsvY2xrLWZpeGVkLXJhdGVfdGVzdC5j
ICAgICAgICAgICAgIHwgMjk2ICsrKysrKysrKysrKwo+PiAgZHJpdmVycy9jbGsvY2xrLWt1bml0
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgMjA0ICsrKysrKysrCj4+ICBkcml2ZXJzL2Nsay9j
bGsta3VuaXQuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMjggKysKPj4gIGRyaXZlcnMvY2xr
L2Nsa190ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgICB8IDQ1NiArKysrKysrKysrKysrKysr
Ky0KPj4gIGRyaXZlcnMvb2YvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
NiArCj4+ICBkcml2ZXJzL29mL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKwo+PiAgZHJpdmVycy9vZi9rdW5pdC8ua3VuaXRjb25maWcgICAgICAgICAgICAgICAgIHwg
ICA0ICsKPj4gIGRyaXZlcnMvb2Yva3VuaXQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICB8
ICAgNCArCj4+ICBkcml2ZXJzL29mL2t1bml0L2Nsay5kdHNpICAgICAgICAgICAgICAgICAgICAg
fCAgMzAgKysKPj4gIGRyaXZlcnMvb2Yva3VuaXQva3VuaXQuZHRzaSAgICAgICAgICAgICAgICAg
ICB8ICAgOSArCj4+ICBkcml2ZXJzL29mL2t1bml0L2t1bml0LmR0c28gICAgICAgICAgICAgICAg
ICAgfCAgIDQgKwo+PiAgZHJpdmVycy9vZi9rdW5pdC91bWxfZHRiX3Rlc3QuYyAgICAgICAgICAg
ICAgIHwgIDU1ICsrKwo+PiAgaW5jbHVkZS9rdW5pdC9wbGF0Zm9ybV9kcml2ZXIuaCAgICAgICAg
ICAgICAgIHwgIDE1ICsKPj4gIGxpYi9rdW5pdC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNiArCj4+ICBsaWIva3VuaXQvcGxhdGZvcm1fZHJpdmVyLXRlc3QuYyAgICAg
ICAgICAgICAgfCAxMDcgKysrKwo+PiAgbGliL2t1bml0L3BsYXRmb3JtX2RyaXZlci5jICAgICAg
ICAgICAgICAgICAgIHwgMjA3ICsrKysrKysrCj4gCj4gSHVtbSwgd2UgaGF2ZSBEVCBwbGF0Zm9y
bSBkcml2ZXIgdW5pdHRlc3RzIHRvby4gV2hhdCdzIHRoZSBkaWZmZXJlbmNlPwo+IAo+IEFueXdh
eXMsIHRoYXQncyBhbGwganVzdCBteSBpbml0aWFsIHJlYWN0aW9uIGZyb20gb25seSBoYWxmd2F5
IGxvb2tpbmcKPiBhdCB0aGlzLiA6KQo+IAo+IFJvYgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K
