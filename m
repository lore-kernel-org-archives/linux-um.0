Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE5CD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oalVF5rskk13LsxYZPaMVXMiqE1K1wBZW+BOx0KtAdI=; b=HQmnpd5r1ePAJG
	xTSflgd67v+Ju5vOA7vIiaf10p7sif0D4xmY7dmqNvS0O23eYnHMYrGptDjCSnNhI0Whg8kSqHY7I
	8QnI18N3hck6Fb23vrlRA3RhWaGosUnn4EJO1AaPV+6yFzHUH1W3DZzQhTcVShE89n8Tv3mewFhg4
	ykPnahcD7Sl3guX7koBfA4EElDDgM4T9HEi6IVwwVXJxw/jfiph7SHr8AjLxcG7vwBo8THTm8wP9I
	6IWEbwhPIF/q5aonCbnD3/sqNbhbHmKB/XFGGnAJnOQmNWrLsHJxo5OpWDf4f950jfPvTiItE2chD
	aNee7dlYTx4HZtLXD5rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiFhf-00Fh7q-1d;
	Mon, 18 Sep 2023 14:58:23 +0000
Received: from mail-yw1-f174.google.com ([209.85.128.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiFhb-00Fh6y-2z
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 14:58:21 +0000
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59bdb3d03b1so45620947b3.3
        for <linux-um@lists.infradead.org>; Mon, 18 Sep 2023 07:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695049098; x=1695653898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL0rujHXVlNw13Fb7ZtkGEh5b6OFxFiF646QN9UA4CU=;
        b=jAwr95dvB0nSmwiO0k0uEVq8K1ClA+uLpLMzTivG2IvTrB8Pg7Zf9vTxGpRsmo5/0q
         m4oZSMhJ/ETjerdNRXcUMqnqA6WAvMR1eVYKlTpgys+40ORVHL0Iq5IXMyLnqyIimb0+
         JEWClxyhT/Uy2lOVp3c4W+5OXPbYPR6+inxqxZkJ+cdHRyJ9vMRepXOJTkaU5HyVv1Uz
         sFc6PpX0J+bzXK8QNcECer7qU91DP2NydbD4X3fUc0ACatu6iro5HvzB5EgQFZUIH88C
         EbvRdqKrjWVdPoHahZ2dMjqdbAAyY5DdjSoIQ0LLivAS3ylsnXpiOxR7n1T+JG/YqW0a
         IYPg==
X-Gm-Message-State: AOJu0YyTJzVHE6ik79+aieKTYQrjtmS3bE/0qKBj9UHq4AkN/5lxCmnL
	7512xTdG9xMuuZAqvxGE7DTay6MoAQlmow==
X-Google-Smtp-Source: AGHT+IFLIm+asKLERFAHAMXlgsc1Yr71AMvjNVU8BDv2mTW7BvFf5wdMU2GOt+4uVlrr9FFMs0KRtA==
X-Received: by 2002:a0d:d695:0:b0:59a:4898:8e13 with SMTP id y143-20020a0dd695000000b0059a48988e13mr9534639ywd.16.1695049097998;
        Mon, 18 Sep 2023 07:58:17 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id i3-20020a0dc603000000b0057a8de72338sm2587683ywd.68.2023.09.18.07.58.17
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:58:17 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59bdb3d03b1so45620727b3.3
        for <linux-um@lists.infradead.org>; Mon, 18 Sep 2023 07:58:17 -0700 (PDT)
X-Received: by 2002:a0d:ee83:0:b0:573:bb84:737c with SMTP id
 x125-20020a0dee83000000b00573bb84737cmr9358141ywe.26.1695049097356; Mon, 18
 Sep 2023 07:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230910232640.113938-1-peter@n8pjl.ca> <20230918125744.4342-1-peter@n8pjl.ca>
 <20230918132614.zmmuc72purc2psik@quack3>
In-Reply-To: <20230918132614.zmmuc72purc2psik@quack3>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Sep 2023 16:58:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
Message-ID: <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com>
Subject: Re: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
To: Jan Kara <jack@suse.cz>
Cc: Peter Lafreniere <peter@n8pjl.ca>, linux-um@lists.infradead.org, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	reiserfs-devel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_075819_969722_4A487178 
X-CRM114-Status: GOOD (  20.12  )
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

SGkgSmFuLAoKT24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMzoyNuKAr1BNIEphbiBLYXJhIDxqYWNr
QHN1c2UuY3o+IHdyb3RlOgo+IE9uIE1vbiAxOC0wOS0yMyAxMjo1ODoyNiwgUGV0ZXIgTGFmcmVu
aWVyZSB3cm90ZToKPiA+IFJlaXNlckZTIGhhcyBiZWVuIGRlcHJlY2F0ZWQgZm9yIGEgeWVhciBh
bmQgYSBoYWxmLCB5ZXQgaXMgc3RpbGwgYnVpbHQKPiA+IGFzIHBhcnQgb2YgYSBkZWZjb25maWcg
VU1MIGtlcm5lbC4KPiA+Cj4gPiBBY2NvcmRpbmcgdG8gY29tbWl0IGViMTAzYTUxNjQwZSAoInJl
aXNlcmZzOiBEZXByZWNhdGUgcmVpc2VyZnMiKSwgdGhlCj4gPiBmaWxlc3lzdGVtIGlzIHNsYXRl
ZCB0byBiZSByZW1vdmVkIGluIDIwMjUuIFJlbW92ZSBpdCBmcm9tIHRoZSBkZWZjb25maWcKPiA+
IHByb2ZpbGUgbm93LCBhcyBwYXJ0IG9mIGl0cyBkZXByZWNhdGlvbiBwcm9jZXNzLgo+ID4KPiA+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIExhZnJlbmllcmUgPHBldGVyQG44cGpsLmNhPgo+Cj4gTWFr
ZXMgc2Vuc2UgYnV0IEkndmUgbm90aWNlZCB0aGVyZSBhcmUgbWFueSBtb3JlIGFyY2hpdGVjdHVy
ZXMgdGhhdCBkZWZpbmUKPiBDT05GSUdfUkVJU0VSRlNfRlMgaW4gdGhlaXIgZGVmY29uZmlnIChz
aCwgcG93ZXJwYywgbWlwcywgbTY4aywgaWE2NCwgYXJtLAo+IGFscGhhKS4gU28gcGVyaGFwcyB3
ZSBzaG91bGQgZG8gdGhpcyBmb3IgYWxsIG9mIHRoZW0gd2hlbiB3ZSBhcmUgYXQgaXQ/CgpUaGUg
cG9saWN5IGZvciB0aGUgbTY4ayBkZWZjb25maWdzIGlzIHRvIGVuYWJsZSBhbGwgYXZhaWxhYmxl
IGV4b3RpYwpmaWxlIHN5c3RlbXMgYXMgbW9kdWxlcywgc28gc3VwcG9ydCBmb3IgdGhlbSBpcyBh
dmFpbGFibGUgd2hlbiBuZWVkZWQuCgpQbGVhc2UgbGV0IG1lIGtub3cgd2h5IHRoaXMgc2hvdWxk
IGJlIGNoYW5nZWQsIGFzIGxvbmcgYXMgUmVpc2VyRlMgaXMKc3RpbGwgYXZhaWxhYmxlIGluIHRo
ZSB1cHN0cmVhbSBrZXJuZWwuCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29u
dmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIu
IEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1t
ZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
dW0K
