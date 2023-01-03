Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C93C46467
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QcoWkwa5tbWDzcUFy2VRMfPx1EYqyvQbuD6fIejf9QA=; b=mLUHFjQvB14LSM
	Iznz4O/OpfL5MATcl/eiIc8nu67wkicwJd56i+hu+rzwhtvGQ1ikhhnkmGiEhukF3jwoVP6rURk8E
	2nTYFoWsQ+O28qwib3wDbw6//iNbrkTNL378y5YiyGnH9eqN+Njw+V41yaWDcd8DmQYGgEVG5ZBuy
	1w+yxDqyDK5oJwGX/oz1d8QdmO0UxhUyTWNQ0g0/ayrmDNRGOAJHZnPWbxriJrG8Q9xLbUB3ljUFX
	5M7X1HJqTd2B2eRZoQ1xaF31EsqWtAfpy/pqgLvL7lgUlmB5OQON89d3pb5CCZKg8e7ocleP8v6R8
	+Q7nnszzRyxknZ7ooi3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCi3V-001rUa-Bj; Tue, 03 Jan 2023 14:14:17 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCgEQ-001BLR-Bk
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 12:17:27 +0000
Received: by mail-pl1-x62d.google.com with SMTP id m4so32428812pls.4
        for <linux-um@lists.infradead.org>; Tue, 03 Jan 2023 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfHfxq3lX1f1scaBbnguDJEQzcQB49P5IAxROskdV+Y=;
        b=IKGnRgMpl0f0h7CR06OjOBmJXVNuyPBZdFuYhwyKib57ildXrzfTeCj7jnxdwYBm+O
         s6eh5WjpxSN/nyh/4VNrNeNwvKsxI+PJbXPOBe+jBMIM6rMqBdeVt33MOWFCZ7WwZY6A
         FH5HbOL0x2yBF8Y4Ny5C6TnHgYRvPGEvQ47hagVL4mpLX1F1hu8jWPut68MnPGxPDPnN
         9R9e8YIuP7zh+udt+1rTkDG+bY0jf0TbxDGjYe+0YoV1ROYY7CrO8c7lkdyJ28v7WXNS
         DRdj+bz7wLEJg2XTVpIE3hUFo3t/x6Hlm/4BEvP06zt4dxpDA7rtTCBiuC0uovGwxRdI
         GE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfHfxq3lX1f1scaBbnguDJEQzcQB49P5IAxROskdV+Y=;
        b=JZ1K1chXueKfEACK7At3LesZHlHrfHCTJWaJcphoXsOMfvCuzWVWenLf5kp+R+wLnA
         Jlp5XxprAPw6HIGSQ0j7hIvrVbrk4UZyr5P6mJpVtG/NErqJtdX8IgUdtD1Z/qD4C0D+
         DVipuaJ3SMRym86QVRAH4cP0/Rcfn1LOkIp6xAMTVTnrsuOXap5zG7zJ9jrjRei2ubW5
         4KOifNAJcSVrN40LpYVYoJXxTz2FWZ2eid6SII3oAbBL4vLsqVuHqqyzDintQ4bhDWSk
         1k9s5LJmzbFo7t4IlPfzF292So+BM/JddXlUy/VEv3g6fa2L7bd1/2KEWpgPWTxD/V0e
         c5Lg==
X-Gm-Message-State: AFqh2kolU3CSj2YTwRGQUPaQwhrViV3uq1Iyvi/WJubcK6KsflxQl38I
	I7pYbqzA1xPQzfpgtcFmbio=
X-Google-Smtp-Source: AMrXdXuPj0aDU2Pv1FchTwsvpXdW+66hAyjk7/7CmbxZ+eZvWBGR1MYIcryRSJ3NGLpc7z/HKBKwbA==
X-Received: by 2002:a17:902:d491:b0:192:b40b:e41 with SMTP id c17-20020a170902d49100b00192b40b0e41mr21388428plg.61.1672748241839;
        Tue, 03 Jan 2023 04:17:21 -0800 (PST)
Received: from [192.168.0.105] ([183.254.109.196])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm22174565plg.46.2023.01.03.04.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:17:21 -0800 (PST)
Message-ID: <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
Date: Tue, 3 Jan 2023 20:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221229075323.1394010-1-linmq006@gmail.com>
 <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
 <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
Content-Language: en-US
From: Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_041726_511387_21F60A8C 
X-CRM114-Status: GOOD (  19.34  )
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

Ck9uIDIwMjMvMS8zIDE4OjI4LCBBbnRvbiBJdmFub3Ygd3JvdGU6Cj4KPiBPbiAwMy8wMS8yMDIz
IDA4OjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4+IEhpIE1pYW9xaWFuLAo+Pgo+PiBP
biBUaHUsIERlYyAyOSwgMjAyMiBhdCA4OjUzIEFNIE1pYW9xaWFuIExpbiA8bGlubXEwMDZAZ21h
aWwuY29tPiB3cm90ZToKPj4+IGtzdHJkdXAoKSByZXR1cm4gbmV3bHkgYWxsb2NhdGVkIGNvcHkg
b2YgdGhlIHN0cmluZy4KPj4+IENhbGwga2ZyZWUoKSB0byByZWxlYXNlIHRoZSBtZW1vcnkgd2hl
biBhZnRlciB1c2UuCj4+Pgo+Pj4gRml4ZXM6IDQ5ZGE3ZTY0ZjMzZSAoIkhpZ2ggUGVyZm9ybWFu
Y2UgVU1MIFZlY3RvciBOZXR3b3JrIERyaXZlciIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWFvcWlh
biBMaW4gPGxpbm1xMDA2QGdtYWlsLmNvbT4KPj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+Pgo+
Pj4gLS0tIGEvYXJjaC91bS9kcml2ZXJzL3ZlY3Rvcl9rZXJuLmMKPj4+ICsrKyBiL2FyY2gvdW0v
ZHJpdmVycy92ZWN0b3Jfa2Vybi5jCj4+PiBAQCAtNzY1LDYgKzc2NSw3IEBAIHN0YXRpYyBpbnQg
dmVjdG9yX2NvbmZpZyhjaGFyICpzdHIsIGNoYXIgKiplcnJvcl9vdXQpCj4+Pgo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBwYXJzZWQgPSB1bWxfcGFyc2VfdmVjdG9yX2lmc3BlYyhwYXJhbXMpOwo+Pj4K
Pj4+ICvCoMKgwqDCoMKgwqAga2ZyZWUocGFyYW1zKTsKPj4gQXJlIHlvdSBzdXJlIHRoZSBtZW1v
cnkgcG9pbnRlZCB0byBieSAicGFyYW1zIiBpcyBubyBsb25nZXIgdXNlZD8KPj4gInBhcnNlZCIg
c2VlbXMgdG8gY29udGFpbiBwb2ludGVycyBwb2ludGluZyB0byAocGFydHMgb2YpIHRoZSBzdHJp
bmcKPj4gcG9pbnRlZCB0byBieSAicGFyYW1zIiwgc28gaXQgY2Fubm90IGJlIGZyZWVkLgo+Cj4g
KzEuCj4KPiBJIHdhcyBqdXN0IGFib3V0IHRvIHNlbmQgdGhlIHNhbWUgY29tbWVudC4KPgpPaCB5
ZXMsIHRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcy4gV2Ugc2hvdWxkIG9ubHkgcGVyZm9ybSByZWxl
YXNlIHdoZW4gdW1sX3BhcnNlX3ZlY3Rvcl9pZnNwZWMoKSBmYWlscyAocmV0dXJucyBOVUxMKS4g
SW4gdGhpcyBzaXR1YXRpb24sICdwYXJhbXMnIGlzIG5vIGxvbmdlciB1c2VkLiBEbyB5b3UgYWdy
ZWU/CgpUaGFua3MsCgo+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocGFyc2VkID09IE5VTEwp
IHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICplcnJvcl9vdXQgPSAidmVj
dG9yX2NvbmZpZyBmYWlsZWQgdG8gcGFyc2UgcGFyYW1ldGVycyI7Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gR3J7b2V0amUsZWV0aW5nfXMs
Cj4+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBH
ZWVydAo+Pgo+PiAtLSAKPj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwo+Pgo+PiBJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0Cj4+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtLSBMaW51cyBU
b3J2YWxkcwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
