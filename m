Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D487C6379F
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b/BchCSnYZWFw7QkeSXkfJ0p1vnbmYuksfTICXPIgEU=; b=JzGhd3BmBAk/80
	JLWr6tPVrWmNDmEK7aLU7Tm++u3S9i469W7DRKn4yUovLMvB7aebMvY4CsmAF7guH2A/rUxCEfozU
	gP2s9amtfE6qVklghxtQmPwLUPFdCowqtgYXxpSFcNDF/Cwe1HKxsn6xoU74B37gXnFPDp9Kvciu6
	mbHLMt3DcLaSsZc/qAYgw50BEr9I9USjTrs7wAtu54EcG8CiR0s0+hYqGL24dwgSP3HnAcf0PwFqr
	LzFLgXOYcCM/RdkWYVCiLklS7DM7nt+IqsRPK0yGL2zqi8wSNPN0ZlIOuNH3mVBfEsxeALscKsqQ8
	l7GmCF4/K4Re5QB4xpBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCpG-0058kp-5s; Wed, 15 Feb 2023 08:07:38 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCpD-0058kG-Jv
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 08:07:37 +0000
Received: by mail-qt1-f169.google.com with SMTP id w3so20948705qts.7
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 00:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx6raGPVkjLOh5DBbFhiid2XbozsdzVzlVKzi7He69I=;
        b=37PYfSxUa3xEPg+9AhAvUOzy/yioi6xeR/QeY1A8/nn85SA0p7qY0uc3iVMy98YUX9
         +6kfMRF/5Zg0W431sqh/QovLucs9/42L3DUs3vrTZ0hDe4+BpXzvOBOhl4kBwXsPfTFH
         siv6uWym7YdW69agLWhHG9WCxn+Bq9YszNEM4BbqzrVmFZ5fX9n7T2+k4jtT/NbujSNW
         cPq4Ht046HkVa8eu08RWquRaZqAuHBJrmF6giGV80rZ7tZBBjRoKVfhZBvT2xEg8L/rA
         vhod1mPq0S7wSNFMadND9TQk1kfbvyRzgEmqVIPLaP1Vzfavp1myOs0AjgD4UgfkL1Va
         Au6Q==
X-Gm-Message-State: AO0yUKXHEmq2vHmYlXSjj/nZRls1udDrxKeiEieSWTq3ezQjq8vu3JTu
	mYFLJdy92K/J3Ja6fLtvCvcpxHP+xP91TX9w
X-Google-Smtp-Source: AK7set+XLa6p7nhRqCFZyo95+bP6UGFYGHiMY6tl39nQ6zDQ6Fmk3FyidtzJzfYR5cAKxRQWgpjEEg==
X-Received: by 2002:ac8:7e84:0:b0:3b8:6b1b:e3a2 with SMTP id w4-20020ac87e84000000b003b86b1be3a2mr1842930qtj.10.1676448453775;
        Wed, 15 Feb 2023 00:07:33 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id p23-20020ac84097000000b003a530a32f67sm12622200qtl.65.2023.02.15.00.07.33
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:07:33 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-52f1b1d08c2so124539047b3.5
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 00:07:33 -0800 (PST)
X-Received: by 2002:a81:6a03:0:b0:52f:972:e6a1 with SMTP id
 f3-20020a816a03000000b0052f0972e6a1mr173556ywc.235.1676448452756; Wed, 15 Feb
 2023 00:07:32 -0800 (PST)
MIME-Version: 1.0
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at> <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
In-Reply-To: <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Feb 2023 09:07:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Message-ID: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Subject: Re: [PATCH V1] um: Fix compilation warnings
To: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc: Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_000735_677663_2EF8C73A 
X-CRM114-Status: GOOD (  22.07  )
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

SGkgU3Jpbml2YXNhcmFvLAoKT24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgNjozNiBBTSBTcmluaXZh
c2FyYW8gUGF0aGlwYXRpCjxxdWljX2Nfc3BhdGhpQHF1aWNpbmMuY29tPiB3cm90ZToKPiBPbiAy
LzE1LzIwMjMgMzoyNyBBTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+ID4gLS0tLS0gVXJz
cHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+ID4+IFZvbjogIlNyaW5pdmFzYXJhbyBQYXRoaXBhdGki
IDxxdWljX2Nfc3BhdGhpQHF1aWNpbmMuY29tPgo+ID4+IHN0YXRpYyB2b2lkIHNpZ19oYW5kbGVy
X2NvbW1vbihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAqc2ksIG1jb250ZXh0X3QgKm1jKQo+ID4+
IHsKPiA+PiAtICAgIHN0cnVjdCB1bWxfcHRfcmVncyByOwo+ID4+ICsgICAgc3RydWN0IHVtbF9w
dF9yZWdzICpyOwo+ID4+ICAgICAgaW50IHNhdmVfZXJybm8gPSBlcnJubzsKPiA+Pgo+ID4+IC0g
ICAgci5pc191c2VyID0gMDsKPiA+PiArICAgIHIgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCB1bWxf
cHRfcmVncykpOwo+ID4gSSBmZWFyIHRoaXMgaXMgbm90IGNvcnJlY3Qgc2luY2UgbWFsbG9jKCkg
aXMgbm90IGFzeW5jLXNpZ25hbCBzYWZlLgo+Cj4gVGhhbmtzIFJpY2hhcmQgZm9yIHF1aWNrIHJl
c3BvbnNlLiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3QgYWx0ZXJuYXRpdmUKPiBmdW5jdGlvbiBv
ZiBtYWxsb2MoKSB3aXRoIGFzeW5jLXNpZ25hbCBzYWZlLgo+Cj4gaWYgdGhhdCBpcyBub3QgcG9z
c2libGUgSXMgdGhlcmUgYW55IG90aGVyIHdheSB0byBmaXggdGhpcyB3YXJuaW5nPyBPUgo+IGRv
IHdlIG5lZWQgdG8gbGl2ZSB3aXRoIHRoYXQgd2FybmluZz8KCkRvZXMgdGhpcyBsaW1pdCBhY3R1
YWxseSBhcHBseSB0byB0aGlzIGZpbGUsIHdoaWNoIGNhbGxzIGludG8gdGhlIGhvc3QgT1M/CgpI
b3cgY29tZSB5b3UgZXZlbiBzZWUgdGhpcyB3YXJuaW5nLCBhcyB3ZSBoYXZlCgogICAgQ0ZMQUdT
X3NpZ25hbC5vICs9IC1XZnJhbWUtbGFyZ2VyLXRoYW49NDA5NgoKc2luY2UgY29tbWl0IDUxN2Y2
MDIwNmVlNWQ1ZjcgKCJ1bTogSW5jcmVhc2Ugc3RhY2sgZnJhbWUgc2l6ZSB0aHJlc2hvbGQKZm9y
IHNpZ25hbC5jIikgaW4gdjUuMTE/CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dy
YW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
