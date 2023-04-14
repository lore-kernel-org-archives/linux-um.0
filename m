Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD98C77B72
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w108Qj8DFUPbaw7AUg2cVX5dZ/5jP8laDfhKNQ8Vkao=; b=THR/9a8u5LfAaT
	13vQEz32q1F1tNLmQ6tsJ7hSIfHtQe1GgD9VL/nNjiH+NebZsFj2s9JVK6L9UttSvItxIeU+IjoZc
	H2faX9Y+ARqo8cAlqPAusbjVJIJH/BbSFAJfU+ShJrMjzhjL8y+nIsGP4jjzs/on+rzhWQL9moIVN
	W97k4BcwxKht1rLGE96GqnpVPO6r4G4PxIES1r4ICXkTk8iHIRYXUzezmpBNvZsI0d3bH4Q5BWhZ/
	7mzT22tlAdkeTe8e8PFOIN9J5dyjlU4IAgZiD68YdfxBGHBB1MybnZWZHnzl6G1oSxQvnq+fflTMe
	dvxT1nEOUivDQvYZHnDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnNbE-00AIkZ-21;
	Fri, 14 Apr 2023 17:52:40 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnNbB-00AIjL-1h
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 17:52:38 +0000
Received: by mail-wm1-x329.google.com with SMTP id he13so15812298wmb.2
        for <linux-um@lists.infradead.org>; Fri, 14 Apr 2023 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681494753; x=1684086753;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDiQhg7AgR7It7HjJE4baEImmpB228vGjbpjWlOwA0w=;
        b=rhY55Xoy6mb1HlWd5WoeAQN4DRUtqwOrqeKhpvGslFBf9dcH4wmNpY5z5HN18NzFmJ
         AK5R8s3SO3u/zCU3jjB2jJEPMts/y3DqjtAaVI2npZKbakBmBIE69QmPnpt607k2vvrO
         WczTVKhA5vR+vem+SXIGCfh/c0VpKnG1JUAixNQCjigq7G1jen2UE2T/z++PdiLThwPL
         Oqms0KPjlHSr2A1Ggo2LJTG8iQi7200YsEB5UK94mrpr7Ey1/xDGWQxsS5MubW1C6kKz
         qUatfZDfIyEhgprIFLx4zH/1bRPLMRvFY5dTPgImjskYul/qVeRCkNh1VqO4mmWO3Wil
         gfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494753; x=1684086753;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vDiQhg7AgR7It7HjJE4baEImmpB228vGjbpjWlOwA0w=;
        b=NJdB97RULrJKJpRFpw7yqDlMkW3HgutYudkHSNGoHfRNVXPZrqQkHX9wPCd4cxq99D
         GC6yF5L4xMeyCjMvVpaXgi0F2XtIdlo3fgUuY635oBORzlLb9aPQDIr7AdaBVQZ3GbvO
         a9UmV2nSmCmD0/3hH2lRzvEEj+2AOlPst3WEPfb1Uk/UU8qm8bozrNqqTASEmpbJ3gJZ
         4Uo16UWjcJ20btzOxIU2kVu6ufz/vUs6/AUA3RYDT1SeWAVwExmhQs3XnytuEzmGZbi5
         7BYQp358wjIZpAcYw8LR9NrouQbRhJ/J2yGg/kSIsM7Gs04suyiH4LfVEtxOWydWQPBD
         D2xA==
X-Gm-Message-State: AAQBX9dLsfGHZp+q9m+UbhaMgGSy+hN+wOrcAvTnAHO5LFb/c2lX+sXw
	CeleVxm+SfNtwffefC2thUdn3zEwnnEWfbHY
X-Google-Smtp-Source: AKy350a5J3eOvDNQz4jFoOaxaXNMZTQ22NI4SBT9EOMHOReq8wVexcN5mfb5VzCKBhVE8FKcJhW92Q==
X-Received: by 2002:a7b:c7d4:0:b0:3eb:39e0:3530 with SMTP id z20-20020a7bc7d4000000b003eb39e03530mr4789924wmk.41.1681494752713;
        Fri, 14 Apr 2023 10:52:32 -0700 (PDT)
Received: from localhost ([79.175.90.109])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b002efb6e0c495sm4000804wrn.91.2023.04.14.10.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Apr 2023 10:52:32 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 14 Apr 2023 19:52:30 +0200
Message-Id: <CRWO54DLBZE8.1F6QOOS3VHSNI@laptop-fedora>
Cc: "linux-um" <linux-um@lists.infradead.org>, "anton ivanov"
 <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
 <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] hostfs: store permissions in extended attributes
From: =?utf-8?q?Marko_Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: "Richard Weinberger" <richard@nod.at>
X-Mailer: aerc 0.13.0
References: <20230413223024.11513-3-petrovicmarko2006@gmail.com>
 <20230414023357.63722-1-petrovicmarko2006@gmail.com>
 <1668890621.62421.1681469691730.JavaMail.zimbra@nod.at>
In-Reply-To: <1668890621.62421.1681469691730.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_105237_582833_65F05FA7 
X-CRM114-Status: GOOD (  16.88  )
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

T24gRnJpIEFwciAxNCwgMjAyMyBhdCAxMjo1NCBQTSBDRVNULCBSaWNoYXJkIFdlaW5iZXJnZXIg
d3JvdGU6Cj4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+ID4gVm9uOiAiTWFya28g
UGV0cm92acSHIiA8cGV0cm92aWNtYXJrbzIwMDZAZ21haWwuY29tPgo+ID4gK3N0YXRpYyBpbnQg
dW1sX2Nob3duKGNvbnN0IGNoYXIgKnBhdGhuYW1lLCB1bnNpZ25lZCBpbnQgb3duZXIsIHVuc2ln
bmVkIGludAo+ID4gZ3JvdXApCj4KPiBJcyB0aGVyZSBhIHNwZWNpZmljIHJlYXNvbiB3aHkgeW91
IGFyZSBub3QgdXNpbmcgdWlkX3QgYW5kIGdpZF90Pwo+Cj4gPiArewo+ID4gKwlpbnQgc3RhdHVz
Owo+ID4gKwo+ID4gKwlpZiAodXNlX3hhdHRyKSB7Cj4gPiArCQlpZiAob3duZXIgIT0gLTEpIHsK
Pgo+IERvZXNuJ3QgLTEgY2xhc2ggd2l0aCB0aGUgdWlkIHNwYWNlPwo+IFNhbWUgZm9yIGdpZC4K
Pgo+ID4gKwkJCXN0YXR1cyA9IHNldHhhdHRyKHBhdGhuYW1lLCAidXNlci51bWx1aWQiLCAmb3du
ZXIsCj4gPiArCQkJCQkJCXNpemVvZih1bnNpZ25lZCBpbnQpLCAwKTsKPgo+Cj4gSSdkIHByZWZl
ciBzdG9yaW5nIHRoZSB2YWx1ZXMgcGxhdGZvcm0gaW5kZXBlbmRlbnQuIGUuZy4gaW4gX19sZTMy
LiAKPiBKdXN0IHRvIGJlIGZ1dHVyZSBwcm92ZS4KPgo+IFRoYW5rcywKPiAvL3JpY2hhcmQKSGVs
bG8sClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayEKClRoZXJlIGlzIG5vIHNwZWNpZmljIHJl
YXNvbiBmb3IgcHJlZmVycmluZyBvbmUgb3ZlciB0aGUgb3RoZXIgYmV0d2Vlbgp1aWRfdC9naWRf
dCBhbmQgdW5zaWduZWQgaW50LiBJIHdpbGwgY2hhbmdlIHRob3NlIHR5cGVzIGJhY2sgdG8gdWlk
X3QKYW5kIGdpZF90LgoKQWJvdXQgdXNpbmcgLTEgZm9yIHVpZCBhbmQgZ2lkLCBpbiBkb2N1bWVu
dGF0aW9uIGZvciBjaG93biBpdCBpcyBzdGF0ZWQKdGhhdCAtMSBzaGFsbCBiZSB1c2VkIGlmIHRo
ZSBkZXNpcmVkIHZhbHVlIHNob3VsZCBub3QgYmUgY2hhbmdlZCwgc2luY2UKbm9ybWFsbHkgY2hv
d24oMikgYWNjZXB0cyBib3RoIHVpZCBhbmQgZ2lkIGZvciBjaGFuZ2luZyBpbiBvbmUgc3lzdGVt
CmNhbGwuCkluIHRoZSBjb25jcmV0ZSBpbXBsZW1lbnRhdGlvbiwgc2luY2UgdGhlIHVuZGVybHlp
bmcgdHlwZSBpcyB1bnNpZ25lZAppbnQsIHRoZSAtMSB3aWxsIGJlIHdyaXR0ZW4gaW4gMidzIGNv
bXBsZW1lbnQgYW5kIHRoZW4gdHJlYXRlZCBhcyBhbgp1bnNpZ25lZCBwb3NpdGl2ZSBudW1iZXIu
IEZvciB0aGUgc2l6ZSBvZiA0IGJ5dGVzIGZvciB1bnNpZ25lZCBpbnQsIHRoZQpyZXN1bHRpbmcg
bnVtYmVyIGlzIDQyOTQ5NjcyOTUuIFRoYXQgaXMgYWxzbyB0aGUgbWF4aW11bSBwb3NzaWJsZSBu
dW1iZXIKb2YgdXNlcnMgb24gTGludXgsIGJ1dCBMaW51eCB1c2VyIElEcyBnbyBmcm9tIDAgdG8g
NDI5NDk2NzI5NCBzbyB0aGF0Cmxhc3Qgb25lIGlzIG91dHNpZGUgVUlEIHNwYWNlIGFuZCByZXNl
cnZlZCBhcyAiZG9uJ3QgY2hhbmdlIiBmbGFnIGZvcgpjaG93bigyKS4KCkluIHJlZ2FyZCB0byB0
aGUgc3RvcmUgb2YgdmFsdWVzIGluIHBsYXRmb3JtIGluZGVwZW5kZW50IHdheSwgaW4gbXkKaHVt
YmxlIG9waW5pb24sIEpvaGFubmVzJyByZWNvbW1lbmRhdGlvbiBtYXkgYmUgcHJlZmVycmVkIChz
dG9yaW5nIGFsbApwZXJtaXNzaW9ucyBpbiBvbmUgc3RyaW5nKSBiZWNhdXNlIGJlc2lkZXMgdGhp
cyBpdCBhbHNvIHNvbHZlcyB0aGUKcHJvYmxlbSBvZiBvbmUgc2V0eGF0dHIoKSBzdWNjZWRpbmcg
YW5kIG90aGVyIGZhaWxpbmcgKGZvciB3aGF0ZXZlcgpyZWFzb24gbWF5IHRoYXQgaGFwcGVuKSBp
biB1bWxfY2hvd24oKS4KCkJlc3QgcmVnYXJkcywKTWFya28gUGV0cm92acSHCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
