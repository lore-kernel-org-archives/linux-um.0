Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948DCC4167D
	for <linux-um@archiver.kernel.org>; Sat,  4 Nov 2023 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uV7MLMbeRTlkxHM9N9WioBvaOUzdH+4FpPuFlxMH2rU=; b=L1FIT54x6LsQgd
	vgsxvPUQ7uvARhDVFe4O8MdoqhA+9qd2Fyyp465EONCJFSeUSDvZ0kVbIn4enxxhdAUNVfhfFJdvk
	MQUymVPd6PrUdfOY/PPFGWlM5iSZSdDCRzAz/Vhc7xfRZapJISdeMZ/d0UH41Y2hVqJSDqRPk435Y
	2xjRkX+do/hSNw0rqZp5NEgspL+NMSEiRZGzOBhhJplmc5cpgfGMjERpNvyeB3tQhTrCCHdgResB/
	LBVvk+TTXZ3G6tP9VT1g9GsMgXZJhKCx+LV5Z0UAHUanhkH+RwO7XGA9Lkcg25ErDKQYZ2TzgQ7vN
	AzAvrydyQHLz10h+vf2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzD9O-00CzBg-00;
	Sat, 04 Nov 2023 09:41:06 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzD9K-00CzAO-21
	for linux-um@lists.infradead.org;
	Sat, 04 Nov 2023 09:41:04 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso37980111fa.2
        for <linux-um@lists.infradead.org>; Sat, 04 Nov 2023 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699090860; x=1699695660; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd+JVCBsQTb3vo5vpK8dzy/SOidwl06tgE7kBJob/WI=;
        b=N9MnI8ypUy3IdNa+0tBUD9NwwH3d5g26n9N6vwpnsKdbDYYS1tzB6Mck3FGMmMJO1m
         /zZpxjyoXe2W06LeaUN7tJ8TSUfPHtMDp0zHzouJRkoraYu5BnpvBJoleypBWItEj7m4
         1DxjO0+ylQDXjwqfyK6dpc2YDnTfjQmVZc0BdhamOYP/EEqF95T3qgc9ta86T0byEEhp
         Qbe6ETnCo1Zhf3tIdQJmJx0hLqw4SN1GBTks7uaTnCOCpfmP90cF7zP3Ox79f1lWEAyu
         lyfEFzHkmjWZRhXa+PHl1KzBfMZoF6TrkLziQCCp/t5yKMoWZq9lTk6oz9fJNUOR0+3S
         +pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699090860; x=1699695660;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd+JVCBsQTb3vo5vpK8dzy/SOidwl06tgE7kBJob/WI=;
        b=l7eFBgI08F5WDGDIfY92zkcjnV3k91lXq7EWWfiAu1MIaVJoAYPZBRhzgzDNqWt1P1
         VZfNBFQIHOXyzlVIn14B8kqF/sih/BI8jdvHx4WyoTYqOgNcllb8D9MAqVudDM4/rOZ1
         A8mrrB//9EDEl6uMyzmPd8Lv+6MCW6cLyld5yohGR30hHwuUvALEkT4bLprp98/MW3ui
         QRC+l2X3VxunLPRIICsd0+Whn88GumNlGVBLu+BeCuK6gNv7/h11ctnUV6cfKn/iBWbM
         EB+I14WGWpe2/RenLR4HZWLSs5ZWhZ8ROSYSeoCYvs9tIQvjjEBT/pVLIvdFuafMgMIe
         zuxg==
X-Gm-Message-State: AOJu0YzS2LPs8W+3rHHrWQXmu0vlYnZqVTR1M5/I/UjfHoKOW4Mi8l7v
	WryJnU+MEZG11Nccqr3bsgQ=
X-Google-Smtp-Source: AGHT+IEftJIWv2xy/HN2RA9SVRF5hUk6vRO0pWpf8fpAzta6q5Z+w4fXdaPctPYCcZ7AS+b98vLE2Q==
X-Received: by 2002:a2e:7a17:0:b0:2c2:a337:5ea with SMTP id v23-20020a2e7a17000000b002c2a33705eamr19126456ljc.27.1699090860201;
        Sat, 04 Nov 2023 02:41:00 -0700 (PDT)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id fb14-20020a05600c520e00b0040841e79715sm5050983wmb.27.2023.11.04.02.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:40:59 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
Date: Sat, 4 Nov 2023 11:40:48 +0200
Cc: Richard Weinberger <richard@nod.at>,
 linux-um@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-Id: <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
X-Mailer: Apple Mail (2.3731.700.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231104_024102_665854_3359FF1B 
X-CRM114-Status: GOOD (  14.43  )
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

Cgo+IE9uIE5vdiA0LCAyMDIzLCBhdCAxMTozNCBBTSwgQW50b24gSXZhbm92IDxhbnRvbi5pdmFu
b3ZAa290LWJlZ2Vtb3QuY28udWs+IHdyb3RlOgo+IAo+IE9uIDA0LzExLzIwMjMgMDk6MjUsIE5h
ZGF2IEFtaXQgd3JvdGU6Cj4+IAo+PiBJIHdhcyByZWFkaW5nIChhZ2FpbikgdGhlIHg4NiBDIG1h
Y3JvIG9mIOKAnGFsdGVybmF0aXZlKCnigJ0gYW5kIEkgd2FzIGEgYml0Cj4+IHN1cnByaXNlZCBp
dCBkb2VzIGNsb2JiZXIgdGhlIGZsYWdzICjigJxjY+KAnSkgYXMgYSBwcmVjYXV0aW9uLgo+PiAK
Pj4gICNkZWZpbmUgYWx0ZXJuYXRpdmUob2xkaW5zdHIsIG5ld2luc3RyLCBmdF9mbGFncykgXAo+
PiAJYXNtX2lubGluZSB2b2xhdGlsZSAoQUxURVJOQVRJVkUob2xkaW5zdHIsIG5ld2luc3RyLCBm
dF9mbGFncykgOiA6IDogIm1lbW9yeSIpCj4+IAo+PiBBY3R1YWxseSB0aGVyZSBzZWVtcyB0byBi
ZSBvbmx5IG9uZSBpbnN0YW5jZSBvZiBwcm9ibGVtYXRpYyBjYXNlcyAtIGluIHVtLzMyLWJpdDoK
Pj4gCj4+ICAjZGVmaW5lIG1iKCkgYWx0ZXJuYXRpdmUoImxvY2s7IGFkZGwgJDAsMCglJWVzcCki
LCAibWZlbmNlIiwgWDg2X0ZFQVRVUkVfWE1NMikKPj4gICNkZWZpbmUgcm1iKCkgYWx0ZXJuYXRp
dmUoImxvY2s7IGFkZGwgJDAsMCglJWVzcCkiLCAibGZlbmNlIiwgWDg2X0ZFQVRVUkVfWE1NMikK
Pj4gICNkZWZpbmUgd21iKCkgYWx0ZXJuYXRpdmUoImxvY2s7IGFkZGwgJDAsMCglJWVzcCkiLCAi
c2ZlbmNlIiwgWDg2X0ZFQVRVUkVfWE1NKQo+PiAKPj4gUHJlc3VtYWJseSwgaWYgWE1NIG9yIFhN
TTIgYXJlIG5vdCBzdXBwb3J0ZWQsIHRoZXJlIHdvdWxkIGJlIGluc3RhbmNlcyB3aGVyZSBhZGRs
Cj4+IHdvdWxkIGJlIGFibGUgdG8gY2hhbmdlIGVmbGFncyBhcml0aG1ldGljIGZsYWdzIHdpdGhv
dXQgdGhlIGNvbXBpbGVyIGJlaW5nIGF3YXJlCj4+IG9mIGl0Lgo+PiAKPj4gQXMgaXQgb25seSBh
ZmZlY3RzIDMyLWJpdCBMaW51eCBVTSAtIEkgZG9u4oCZdCBlYXNpbHkgaGF2ZSBhbiBlbnZpcm9u
bWVudCB0byB0ZXN0Cj4+IHRoZSBmaXguIEFuIGFsdGVybmF0aXZlICh3b3JkLXB1biB1bmludGVu
ZGVkKSBpcyB0byBhZGQg4oCcY2PigJ0gYXMgYSBwcmVjYXV0aW9uCj4+IHRvIHRoZSBhbHRlcm5h
dGl2ZSBtYWNyby4KPj4gCj4gQXBwbGljYXRpb24gYWx0ZXJuYXRpdmVzIGluIHVtIGlzIHByZXNl
bnRseSBhIE5PUC4gSXQgYWx3YXlzIHVzZXMgdGhlICJibHVudCBhbmQgaGVhdnkgaW5zdHJ1bWVu
dCIgLSB0aGUgbW9zdCBjb25zZXJ2YXRpdmUgb3B0aW9uLgo+IAo+IEl0IGlzIG9uIHRoZSBUT0RP
IGxpc3QuCgpUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4gQnV0IEkgZG9u4oCZdCBzZWUg
aG93IGl0IHByZXZlbnRzIHRoZSBwcm9ibGVtCihpdCBhY3R1YWxseSBtYWtlcyBpdCB3b3JzZSAt
IGFmZmVjdGluZyBYTU0vWE1NMiBDUFVzIGFzIHdlbGwpIHNpbmNlIHlvdQprZWVwIHRoZSDigJxs
b2NrOyBhZGRsICQwLDAoJSVlc3Ap4oCdIGluIHRoZSBydW5uaW5nIGNvZGUsIGFmZmVjdGluZyBl
ZmxhZ3MKd2l0aG91dCB0ZWxsaW5nIHRoZSBjb21waWxlciB0aGF0IHlvdSBkbyBzbyB0aHJvdWdo
IGEg4oCcY2PigJ0gY2xvYmJlci4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXVtCg==
