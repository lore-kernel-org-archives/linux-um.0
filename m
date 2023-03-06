Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1FC61DA4
	for <linux-um@archiver.kernel.org>; Mon,  6 Mar 2023 05:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tjLCw6TktSJL8riSwbOb3htQgNfNl+z6y6nrVhUFOYo=; b=bcpjhz9GT/pjgV
	RKifrmm6xA4Y9o1Y84qndS6oWN7ugS4tK8rAkNeeo5y1af/Zd0M3WT9uH6M5Tpk6ENK53zWJjmLPd
	aKDfgDhcKTn2ZzFIbOt/lF0HhrG20X+I3jsC1kCme3ygkXRMJyu0wsycFHFvTLLy4GNVZXJNlbE8Q
	Tr+FdQ9ogMjxzKUjSKpABE7tQnd2d90WVfvnL7RVcrJnrbzjBeg/GXbIl36Lw6DNqEWr8/vK2CuTM
	dhFmOWO7uCxzpGc1Lk4+4os6vmiRTze8Zi/t10G6zUnJYYDMKC3JRyGT74frOTTJREq2GzBqFRu9t
	mtMtK16oLFexcWiXizlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ3Sd-00BOpG-CG; Mon, 06 Mar 2023 05:32:35 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ3SZ-00BOno-39
	for linux-um@lists.infradead.org; Mon, 06 Mar 2023 05:32:33 +0000
Received: by mail-qv1-xf34.google.com with SMTP id ks17so5891266qvb.6
        for <linux-um@lists.infradead.org>; Sun, 05 Mar 2023 21:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678080747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiPKMsiLMYcbxYp4rynCMsLu6OEagFUTtrUpOTm5FG4=;
        b=fFeQ+3l0U1qzYT1ysduN2sP0GdfNjC+8AF0rG6ywGf9vi6SrINzCLoPFKmgBsRRkYK
         gOLbqqCx7O2dWpJJL+GA27+EcmZ5ooeWJUGzHkk+3XL0hjGw6mxdUIGB6NbiKXeWxz4B
         wilnFH3qr/uU8kNpWYJG1BIL5c/UWzMAZX95L2u4fAji7ifhqlysAwg5bFQ9AWnWRXAB
         turO4Xhctv2S+cLzKLTrKZXxAQRcHPeosedXwn0aw8Sbhdunndq3E62VAllOlVKn+V6K
         +UimW74g+P8uXesrSOMIUKy++dFWpcc//YvdriqaMThusqA5kcjAvOVMN4CmPnNNBarE
         W40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678080747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiPKMsiLMYcbxYp4rynCMsLu6OEagFUTtrUpOTm5FG4=;
        b=J7L9zwtYmJtoucuf97QLexHgMLT03hLXHR7Mt6EQb4HfT1Yty8k65Tyerqz23a8IeO
         600C+s40LoW+BjFJmokYordu3a3w1l+oVZprMxJUJISYZj3Fi53D0k6NyaYQwEvvN3Wu
         bQzpfZPdyZI+xHVOIcdie5bGqH2KRW7AOxUPZtwOVPEo0uohD+6lGPIvRN1qcHcfQyPl
         ceBJI+8XTH84iOYX6tgVa84+dnzoNXLWJfz00uOevnk1G3BKCq7xLY3jCRcn2yC3qW9v
         MjqqpGC1Yye8JRDzv4vgv9ZVOHxefjS9AV8+S09Jx/hrqfd8YcCY2XjxcuybPhRZIzCR
         EmbA==
X-Gm-Message-State: AO0yUKXWdRzcu2r5H5Fre9NcjlOA+yA2PDvTCvlRjy1gYwQ6D/zhIj5o
	WNUCJ6/F2PXEohVREFFarRI=
X-Google-Smtp-Source: AK7set8x6C04G7U2rQVgc1T5sV7S1ZXKsemoJPLSenK3Bh4gKMTRpKktDP6kENr18uH4v3IYHuBG3w==
X-Received: by 2002:ad4:5de8:0:b0:571:d69:da8c with SMTP id jn8-20020ad45de8000000b005710d69da8cmr15359208qvb.19.1678080747037;
        Sun, 05 Mar 2023 21:32:27 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:64c7:9450:aac2:7f08? ([2600:1700:2442:6db0:64c7:9450:aac2:7f08])
        by smtp.gmail.com with ESMTPSA id x184-20020a3763c1000000b00738e8e81dc9sm6021908qkb.75.2023.03.05.21.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 21:32:26 -0800 (PST)
Message-ID: <3d64ed75-c9f7-391a-e125-7a7bf6a28bf6@gmail.com>
Date: Sun, 5 Mar 2023 23:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>,
 Rob Herring <robh+dt@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, patches@lists.linux.dev,
 Brendan Higgins <brendan.higgins@linux.dev>,
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
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
 <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
 <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
 <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_213231_178511_139BBB6A 
X-CRM114-Status: GOOD (  37.01  )
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

T24gMy81LzIzIDAzOjI2LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4gSGkgRnJhbmssCj4g
Cj4gT24gU3VuLCBNYXIgNSwgMjAyMyBhdCA0OjMz4oCvQU0gRnJhbmsgUm93YW5kIDxmcm93YW5k
Lmxpc3RAZ21haWwuY29tPiB3cm90ZToKPj4gT24gMy8yLzIzIDEzOjQ3LCBHZWVydCBVeXR0ZXJo
b2V2ZW4gd3JvdGU6Cj4+PiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDg6MjjigK9QTSBTdGVwaGVu
IEJveWQgPHNib3lkQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pj4+IFF1b3RpbmcgUm9iIEhlcnJpbmcg
KDIwMjMtMDMtMDIgMDk6MzI6MDkpCj4+Pj4+IE9uIFRodSwgTWFyIDIsIDIwMjMgYXQgMjoxNOKA
r0FNIERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiBUaHUs
IDIgTWFyIDIwMjMgYXQgMDk6MzgsIFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3Jv
dGU6Cj4+Pj4+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB1bml0IHRlc3RzIGZvciB0aGUgY2xr
IGZpeGVkIHJhdGUgYmFzaWMgdHlwZSBhbmQKPj4+Pj4+PiB0aGUgY2xrIHJlZ2lzdHJhdGlvbiBm
dW5jdGlvbnMgdGhhdCB1c2Ugc3RydWN0IGNsa19wYXJlbnRfZGF0YS4gVG8gZ2V0Cj4+Pj4+Pj4g
dGhlcmUsIHdlIGFkZCBzdXBwb3J0IGZvciBsb2FkaW5nIGEgRFRCIGludG8gdGhlIFVNTCBrZXJu
ZWwgdGhhdCdzCj4+Pj4+Pj4gcnVubmluZyB0aGUgdW5pdCB0ZXN0cyBhbG9uZyB3aXRoIHByb2Jp
bmcgcGxhdGZvcm0gZHJpdmVycyB0byBiaW5kIHRvCj4+Pj4+Pj4gZGV2aWNlIG5vZGVzIHNwZWNp
ZmllZCBpbiBEVC4KPj4+Pj4+Pgo+Pj4+Pj4+IFdpdGggdGhpcyBzZXJpZXMsIHdlJ3JlIGFibGUg
dG8gZXhlcmNpc2Ugc29tZSBvZiB0aGUgY29kZSBpbiB0aGUgY29tbW9uCj4+Pj4+Pj4gY2xrIGZy
YW1ld29yayB0aGF0IHVzZXMgZGV2aWNldHJlZSBsb29rdXBzIHRvIGZpbmQgcGFyZW50cyBhbmQg
dGhlIGZpeGVkCj4+Pj4+Pj4gcmF0ZSBjbGsgY29kZSB0aGF0IHNjYW5zIGRldmljZXRyZWUgZGly
ZWN0bHkgYW5kIGNyZWF0ZXMgY2xrcy4gUGxlYXNlCj4+Pj4+Pj4gcmV2aWV3Lgo+Pj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4gVGhhbmtzIFN0ZXBoZW4gLS0gdGhpcyBpcyByZWFsbHkgbmVhdCEKPj4+Pj4+
Cj4+Pj4+PiBUaGlzIHdvcmtzIHdlbGwgaGVyZSwgYW5kIEkgbG92ZSBhbGwgb2YgdGhlIHRlc3Rz
IGZvciB0aGUKPj4+Pj4+IEtVbml0L2RldmljZS10cmVlIGludGVncmF0aW9uIGFzIHdlbGwuCj4+
Pj4+Pgo+Pj4+Pj4gSSdtIHN0aWxsIGxvb2tpbmcgdGhyb3VnaCB0aGUgZGV0YWlscyBvZiBpdCAo
YWxhcywgSSd2ZSBtb3N0bHkgbGl2ZWQKPj4+Pj4+IGluIHg4Ni1sYW5kLCBzbyBteSBkZXZpY2Ut
dHJlZSBrbm93bGVkZ2UgaXMsIHVoLCBzcG90dHkgdG8gc2F5IHRoZQo+Pj4+Pj4gbGVhc3QpLCBi
dXQgYXBhcnQgZnJvbSBwb3NzaWJseSByZW5hbWluZyBzb21lIHRoaW5ncyBvciBzaW1pbGFybHkK
Pj4+Pj4+IG1pbm9yIHR3ZWFrcywgSSd2ZSBub3QgZ290IGFueSByZWFsIHN1Z2dlc3Rpb25zIHRo
dXMgZmFyLgo+Pj4+Pj4KPj4+Pj4+IEkgZG8gd29uZGVyIHdoZXRoZXIgd2UnbGwgd2FudCwgb24g
dGhlIEtVbml0IHNpZGUsIHRvIGhhdmUgc29tZSB3YXkgb2YKPj4+Pj4+IHN1cHBvcnRpbmcgS1Vu
aXQgZGV2aWNlIHRyZWVzIG9uIG5vbi1VTUwgYXJjaGl0ZWNjdHVyZXMgKGUuZy4sIGlmIHdlCj4+
Pj4+PiBuZWVkIHRvIHRlc3Qgc29tZXRoaW5nIGFyY2hpdGVjdHVyZS1zcGVjaWZpYywgb3Igb24g
YSBiaWctZW5kaWFuCj4+Pj4+PiBwbGF0Zm9ybSwgZXRjKSwgYnV0IEkgdGhpbmsgdGhhdCdzIGEg
cXVlc3Rpb24gZm9yIHRoZSBmdXR1cmUsIHJhdGhlcgo+Pj4+Pj4gdGhhbiBzb21ldGhpbmcgdGhh
dCBhZmZlY3RzIHRoaXMgc2VyaWVzLgo+Pj4+Pgo+Pj4+PiBJJ2xsIHNheSB0aGF0J3MgYSByZXF1
aXJlbWVudC4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gc3RydWN0dXJlIHRoZQo+Pj4+PiB0ZXN0cyB0
byBub3QgaW50ZXJmZXJlIHdpdGggdGhlIHJ1bm5pbmcgc3lzdGVtJ3MgRFQuIFRoZSBEVCB1bml0
dGVzdAo+Pj4+PiBkb2VzIHRoYXQuCj4+Pj4KPj4+PiBUaGF0IGNvdWxkIGJlIGFub3RoZXIgY2hv
aWNlIGluIHRoZSB1bml0IHRlc3QgY2hvaWNlIG1lbnUuCj4+Pj4gQ09ORklHX09GX0tVTklUX05P
VF9VTUwgdGhhdCBpbmplY3RzIHNvbWUgYnVpbHQtaW4gRFRCIG92ZXJsYXkgb24gYW4KPj4+PiBh
cmNoaXRlY3R1cmUgdGhhdCB3YW50cyB0byBydW4gdGVzdHMuCj4+Pgo+Pj4gQXMgbG9uZyBhcyB5
b3UgdXNlIGNvbXBhdGlibGUgdmFsdWVzIHRoYXQgZG9uJ3QgZXhpc3QgZWxzZXdoZXJlLAo+Pj4g
YW5kIGRvbid0IG92ZXJ3cml0ZSBhbnl0aGluZywgeW91IGNhbiBsb2FkIHlvdXIga3VuaXQgdGVz
dCBvdmVybGF5cwo+Pj4gb24gYW55IHJ1bm5pbmcgc3lzdGVtIHRoYXQgaGFzIERUIHN1cHBvcnQu
Cj4+Pgo+Pj4+PiBBcyBhIHNpZGUgdG9waWMsIElzIGFueW9uZSBsb29raW5nIGF0IGdldHRpbmcg
VU1MIHRvIHdvcmsgb24gYXJtNjQ/Cj4+Pj4+IEl0J3Mgc3VycHJpc2luZyBob3cgbXVjaCB4ODYg
c3R1ZmYgdGhlcmUgaXMgd2hpY2ggaXMgSSBndWVzcyBvbmUKPj4+Pj4gcmVhc29uIGl0IGhhc24n
dCBoYXBwZW5lZC4KPj4+Pgo+Pj4+IEkndmUgbm8gaWRlYSBidXQgaXQgd291bGQgYmUgbmljZSBp
bmRlZWQuCj4+Pgo+Pj4gSSBiZWxpZXZlIHRoYXQncyBub24tdHJpdmlhbC4gQXQgbGVhc3QgZm9y
IGFybTMyIChJIGRpZG4ndCBoYXZlIGFueSBhcm02NAo+Pj4gc3lzdGVtcyBsYXN0IHRpbWUgSSBh
c2tlZCB0aGUgZXhwZXJ0cykuCj4+Pgo+Pj4+Pj4gU2ltaWxhcmx5LCBJIHdvbmRlciBpZiB0aGVy
ZSdzIHNvbWV0aGluZyB3ZSBjb3VsZCBkbyB3aXRoIGRldmljZSB0cmVlCj4+Pj4+PiBvdmVybGF5
cywgaW4gb3JkZXIgdG8gbWFrZSBpdCBwb3NzaWJsZSBmb3IgdGVzdHMgdG8gc3dhcCBub2RlcyBp
biBhbmQKPj4+Pj4+IG91dCBmb3IgdGVzdGluZy4KPj4+Pj4KPj4+Pj4gWWVzLCB0aGF0J3MgaG93
IHRoZSBEVCB1bml0dGVzdCB3b3Jrcy4gQnV0IGl0IGlzIHByZXR0eSBtdWNoIG9uZSBiaWcKPj4+
Pj4gb3ZlcmxheSAoaWdub3JpbmcgdGhlIG92ZXJsYXkgdGVzdHMpLiBJdCBjb3VsZCBwcm9iYWJs
eSBiZSBtb3JlCj4+Pj4+IG1vZHVsYXIgd2hlcmUgaXQgaXMgYXBwbHkgb3ZlcmxheSwgdGVzdCwg
cmVtb3ZlIG92ZXJsYXksIHJlcGVhdC4KPj4+Pgo+Pj4+IEkgZGlkbid0IHdhbnQgdG8gcmVseSBv
biB0aGUgb3ZlcmxheSBjb2RlIHRvIGluamVjdCBEVCBub2Rlcy4gSGF2aW5nCj4+Pj4gdGVzdHMg
d3JpdHRlbiBmb3IgdGhlIGZha2UgS1VuaXQgbWFjaGluZSBpcyBzaW1wbGUuIEl0IGNsb3NlbHkg
bWF0Y2hlcwo+Pj4+IGhvdyBjbGsgY29kZSBwcm9iZXMgdGhlIERUQiBhbmQgaG93IG5vZGVzIGFy
ZSBjcmVhdGVkIGFuZCBwb3B1bGF0ZWQgb24KPj4+PiB0aGUgcGxhdGZvcm0gYnVzIGFzIGRldmlj
ZXMuIENMS19PRl9ERUNMQVJFKCkgd291bGQgbmVlZCB0aGUgb3ZlcmxheSB0bwo+Pj4+IGJlIGFw
cGxpZWQgZWFybHkgdG9vLCB3aGljaCBkb2Vzbid0IGhhcHBlbiBvdGhlcndpc2UgYXMgZmFyIGFz
IEkga25vdy4KPj4+Cj4+PiBEb24ndCBhbGwgZ2VuZXJpYyBjbG9jayBkcml2ZXJzIGFsc28gY3Jl
YXRlIGEgcGxhdGZvcm0gZHJpdmVyPwo+Pj4gQXQgbGVhc3QgZHJpdmVycy9jbGsvY2xrLWZpeGVk
LWZhY3Rvci5jIGRvZXMuCj4+Pgo+Pj4+IEJ1dCBwZXJoYXBzIHRoaXMgZGVzaWduIGlzIHRvbyBt
dWNoIG9mIGFuIGVuZC10by1lbmQgdGVzdCBhbmQgbm90IGEgdW5pdAo+Pj4+IHRlc3Q/IEluIHRo
ZSBzcGlyaXQgb2YgdW5pdCB0ZXN0aW5nIHdlIHNob3VsZG4ndCBjYXJlIGFib3V0IGhvdyB0aGUg
bm9kZQo+Pj4+IGlzIGFkZGVkIHRvIHRoZSBsaXZlIGRldmljZXRyZWUsIGp1c3QgdGhhdCB0aGVy
ZSBpcyBhIGRldmljZXRyZWUgYXQgYWxsLgo+Pj4+Cj4+Pj4gU3VwcG9ydGluZyBvdmVybGF5cyB0
byBtb3JlIGVhc2lseSB0ZXN0IGNvbWJpbmF0aW9ucyBzb3VuZHMgbGlrZSBhIGdvb2QKPj4+PiBp
ZGVhLiBQcm9iYWJseSBzb21lIGt1bml0XyooKSBwcmVmaXhlZCBmdW5jdGlvbnMgY291bGQgYmUg
dXNlZCB0bwo+Pj4+IGFwcGx5IGEgdGVzdCBtYW5hZ2VkIG92ZXJsYXkgYW5kIGF1dG9tYXRpY2Fs
bHkgcmVtb3ZlIGl0IHdoZW4gdGhlIHRlc3QKPj4+PiBpcyBvdmVyIHdvdWxkIHdvcmsuIFRoZSBj
bGsgcmVnaXN0cmF0aW9uIHRlc3RzIGNvdWxkIHVzZSB0aGlzIEFQSSB0bwo+Pj4+IGluamVjdCBh
biBvdmVybGF5IGFuZCB0aGVuIG1hbnVhbGx5IGNhbGwgdGhlIG9mX3BsYXRmb3JtX3BvcHVsYXRl
KCkKPj4+PiBmdW5jdGlvbiB0byBjcmVhdGUgdGhlIHBsYXRmb3JtIGRldmljZShzKS4gVGhlIG92
ZXJsYXkgY291bGQgYmUgYnVpbHQgaW4KPj4+PiBkcml2ZXJzL2Nsay8gdG9vIGFuZCB0aGVuIHBy
b2JhYmx5IHNvbWUgbWFjcm9pc2ggZnVuY3Rpb24gY2FuIGZpbmQgdGhlCj4+Pj4gYmxvYiBhbmQg
YXBwbHkgaXQuCj4+Pgo+Pj4gTm8gbmVlZCB0byBtYW51YWxseSBjYWxsIG9mX3BsYXRmb3JtX3Bv
cHVsYXRlKCkgdG8gY3JlYXRlIHRoZQo+Pj4gcGxhdGZvcm0gZGV2aWNlcy4gVGhhdCBpcyB0YWtl
biBjYXJlIG9mIGF1dG9tYXRpY2FsbHkgd2hlbiBhcHBseWluZwo+Pj4gYW4gb3ZlcmxheS4KPj4+
Cj4+Pj4gSXMgdGhlcmUgc29tZSB3YXkgdG8gZGVsZXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2VzIHRo
YXQgd2UgcG9wdWxhdGUgZnJvbQo+Pj4+IHRoZSBvdmVybGF5PyBJJ2QgbGlrZSB0aGUgdGVzdHMg
dG8gYmUgaGVybWV0aWMuCj4+Cj4+PiBSZW1vdmluZyB0aGUgb3ZlcmxheSB3aWxsIGRlbGV0ZSB0
aGUgcGxhdGZvcm0gZGV2aWNlcy4KPj4KPj4gSSBfdGhpbmtfIHRoYXQgaXMgaW5jb3JyZWN0LiAg
RG8geW91IGhhdmUgYSBwb2ludGVyIHRvIHRoZSBvdmVybGF5IGNvZGUgdGhhdAo+PiBkZWxldGVz
IHRoZSBkZXZpY2U/ICAoSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHRoZSBvdmVybGF5IHJlbW92
ZSBjb2RlIGRvZXMgbm90Cj4+IGV2ZW4gY2hlY2sgd2hldGhlciB0aGUgZGV2aWNlIGV4aXN0cyBh
bmQgd2hldGhlciBhIGRyaXZlciBpcyBib3VuZCB0byBpdCAtLSBidXQKPj4gdGhpcyBpcyBvbiBt
eSB0b2RvIGxpc3QgdG8gbG9vayBpbnRvLikKPiAKPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvb2YvcGxhdGZvcm0uYyNMNzY5CgpUaGFua3Mh
ICBUaGF0IGlzIHByZWNpc2VseSB3aGF0IEkgZmFpbGVkIHRvIHJlbWVtYmVyLgoKLUZyYW5rCgo+
IAo+Pj4gQWxsIG9mIHRoYXQgd29ya3MgaWYgeW91IGhhdmUgeW91ciBvd24gY29kZSB0byBhcHBs
eSBhIERUIG92ZXJsYXkuCj4+PiBUaGUgcmVjZW50IGZ3X2RldmxpbmtzIHBhdGNoZXMgZGlkIGNh
dXNlIHNvbWUgcmVncmVzc2lvbnMsIGNmci4KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQU11SE1kWEVuU0Q0clJKLW85MHg0T3ByVWFjTl9ySmd5bzh4Nj05RjlyWistS3pqT2dAbWFp
bC5nbWFpbC5jb20KPiAKPiBHcntvZXRqZSxlZXRpbmd9cywKPiAKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBHZWVydAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
