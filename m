Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64578C38142
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vutE4uCwMS5CVQ92dxDarumturOwOJ0PfwfcLYlfXYE=; b=RDZFprfYdZDiXq
	Sf2fYPbeQ8AGNFE/pqnInx1uE4YU68jDWk5pvsKDH1CNjaOTzVgn+U/vVdllPWEuPmM3nckLx1+US
	mRit37+VKiD7ANI5HRkVH2WCb+bb4thQWSAR+MwTjASGmgtr+dxGX/XC098oNlR9aZySnypKdBr7G
	B30I4mNuBQd1Z4G2+2dFFOJMDvF8nU/uheTt0dk17VoZLZJt/qyPkID+TtNjFkUunQOIyHqgT7TNE
	0B+7XjiexTpZQ+EcBfCqlyTbUnng3mPfo9MIFqWdWVaHINMjQ7PyW5WYy000UKijaF/q/4KuEnw+0
	SAyHFuo0HHqAhJEjfVrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMvcf-0091Im-63; Tue, 31 Jan 2023 18:44:49 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMvcc-0091Hz-3s
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 18:44:47 +0000
Received: by mail-qt1-x82c.google.com with SMTP id m26so14325721qtp.9
        for <linux-um@lists.infradead.org>; Tue, 31 Jan 2023 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bhSkd/j2uPDlX15OkSCXywuoGprRbUO9ekmEG/ONE60=;
        b=GQx4/IFVpid/kVVPWHvrQh1UVNxrknAKCWWP3OiFpYr9izB9S0WmrYcYYsvrdfbxM7
         YN9rqLc4PXUSAYZ4AzzkipFTHidqwcuACSYghi/Tgyb1gJ9QE66+ZmgRC3rN4SpITqU0
         9EyUBtTnsJ3R/50byptVvaMYMJzXxVQOIHFQ0sycnkQXq68n8GtNSdosXW9dRE0cndMx
         1b7lqCItGDdvsmrrqzMZH5HPsjgTVKyguQ+/CdD4ooa7Jj5NqK92mRX8SJ8FFzgcKcFT
         IGq5ar6Opr/w4xz2QpsQ5OrCDlOjmltyM3cy7EJtxIpv6Ll3S892obJdSLrdakUFg+2h
         UPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhSkd/j2uPDlX15OkSCXywuoGprRbUO9ekmEG/ONE60=;
        b=j//dAz/GdDfW3DHnoNBIihQ8jeczeo7aON04urLYXE1v0919ufAetXQYJQw0X1e5AK
         coWcY5oWDw9HLjNd+gDQwHkqsXQP9L2iJZo1CjadH1qfdLcm4Z5zfW99wDNcO0Pu1hrY
         tWiwZhfpcfSkqOZznj/xzRffOokSW3fJb2Oxx6rfx5+0n5/uIhvgTKAHRQHopN/Z9LjM
         0SfKTypHXXBecDE0+Zsft8PZIBfDf5sWTPpgTeNbaEmA9uQsK6tkwKMK+HqgPhCQhWkf
         yMD8NjOrnuOSnIWxvPmCkgaOMeL/jXE8BUtcKfcY/q6F+jM88vjC1F+mi8koioDJS+IC
         i25w==
X-Gm-Message-State: AFqh2krtsI949wXcOhxiPUDjRjQi5c7aa8duJqExiIdWFLJDqFgrMUTk
	m5OK733bMyT1AgDKB3lPGVzQbg==
X-Google-Smtp-Source: AMrXdXswOmTVmW2zIaRe2I8UhWHud5zoaCEy8R/A3eD8uXyUBEO9WRldxmqHJU+NPZ9nx9cqsJmOBQ==
X-Received: by 2002:a05:622a:1a27:b0:3b7:ec1b:1fa7 with SMTP id f39-20020a05622a1a2700b003b7ec1b1fa7mr56969869qtb.43.1675190684534;
        Tue, 31 Jan 2023 10:44:44 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05620a17a900b0071a49ac0e05sm2884906qkb.111.2023.01.31.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:44:44 -0800 (PST)
Date: Tue, 31 Jan 2023 12:44:35 -0600
From: Glenn Washburn <development@efficientek.com>
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um
 <linux-um@lists.infradead.org>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Using ftrace
Message-ID: <20230131124435.1f3cfc16@crass-HP-ZBook-15-G2>
In-Reply-To: <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
	<aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
	<1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_104446_399143_4FDC072D 
X-CRM114-Status: GOOD (  17.21  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAzMSBKYW4gMjAyMyAwODoyMjo0NSArMDEwMCAoQ0VUKQpSaWNoYXJkIFdlaW5iZXJn
ZXIgPHJpY2hhcmRAbm9kLmF0PiB3cm90ZToKCj4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAt
LS0tLQo+ID4gVm9uOiAiQW50b24gSXZhbm92IiA8YW50b24uaXZhbm92QGtvdC1iZWdlbW90LmNv
LnVrPgo+ID4gT24gMzEvMDEvMjAyMyAwNDoxNywgR2xlbm4gV2FzaGJ1cm4gd3JvdGU6Cj4gPj4g
SSdtIHRyeWluZyB0byB1c2UgdGhlIGZ0cmFjZSBmYWNpbGl0eSB3aXRoaW4gVU1MLiBJdCBhcHBl
YXJzIGFzCj4gPj4gdGhvdWdoIGl0IGV4aXN0cyBpbiB0aGUgbWVudWNvbmZpZywgYnV0IEkgY2Fu
J3Qgc2VlbSB0byBnZXQgdGhlCj4gPj4ga2VybmVsIHRvIHJlY29nbml6ZSB0aGUgdHJhY2VmcyBm
aWxlc3lzdGVtLiBJJ20gd29uZGVyaW5nIGlmCj4gPj4gc29tZW9uZSBjYW4gY29uZmlybSB0aGF0
IGVpdGhlciBmdHJhY2UgZG9lcyBvciBkb2VzIG5vdCB3b3JrIGluCj4gPj4gVU1MLgo+ID4gCj4g
PiBJIGhhdmUgbm90IHVzZWQgaXQuIFdlIGhhdmUgbm90IGhhZCBhbnkgcmVxdWVzdHMgcmVsYXRl
ZCB0byBpdAo+ID4gZWl0aGVyCj4gPiAKPiA+IEkgd2lsbCBsb29rIGludG8gaXQuCj4gCj4gVHJh
Y2luZyBpdHNlbGYgc2hvdWxkIHdvcmsuIEJ1dCBmdW5jdGlvbiB0cmFjaW5nIGlzIG5vdCBzdXBw
b3J0ZWQuCj4gWW91J2xsIGdldCB0cmFjZWZzIGFzIHNvb24geW91IHNlbGVjdCBvbmUgdHJhY2Vy
IChzdWNoIGFzCj4gQ09ORklHX0lSUVNPRkZfVFJBQ0VSKS4KCk9rYXksIHRoYXQgbWFrZXMgc2Vu
c2UuIFllcywgSSB3YXMgcmVhbGx5IGFza2luZyBhYm91dCBmdW5jdGlvbgp0cmFjaW5nLgoKPiBB
ZGRpbmcgZnVuY3Rpb24gKGFuZCBmdW5jdGlvbiBncmFwaCkgdHJhY2luZyB0byBVTUwgaXMgcG9z
c2libGUgYnV0IGEKPiBiaXQgb2Ygd29yay4gWW91IG5lZWQgdG8gZmluZCBhIHdheSB0byBpbXBs
ZW1lbnQgYWxsIG9mIGZ0cmFjZXMKPiBtY291bnQgaG9va3MgZm9yIFVNTC4KClNvdW5kcyBsaWtl
IG1vcmUgdGhhbiBJIHdhbnQgdG8gaW52ZXN0IGF0IHRoaXMgcG9pbnQuIEknbGwgZ2V0IG9uCndp
dGhvdXQgaXQgZm9yIHRoZSB0aW1lIGJlaW5nLiBUaGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24u
IAoKR2xlbm4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
