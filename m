Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F64EB64D9
	for <linux-um@archiver.kernel.org>; Tue,  4 Jul 2023 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DomtcgZRx3peAz1b+bjeq6axosp5LnrW0bkMwiAfOZA=; b=T3DX52bWapYEHI
	J83ncWgEs3gIX/NsIY04RkxVWBuDSePsjlpkni4oKRGUKQbBgv9Rj+RKq6bFgmsWd0xBmRpkztMSA
	W9qcChrALRUgud1QNB+rAqZ17Op8++mUJCrXF31AytaYHlzNHjOVfEmRpOebtx/qg02bF/7GEllIy
	nPE8+AP6NP+Mm1Y9rgs7DeID4t5Otzv2IPC+6pOfi2ylJmcafC9mFpxRvHx3kLl71m9cU5Jj/BX5B
	Kjyl3IlThBMZkf79dwBrVaE38APnE+LmQV/3Z2CFVnXRGxBwNwVHVUKtIwoK0+bLTdaxlWdH3UMtP
	S7R3d+H8YllZS1vxt95w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGb7k-00CXQ2-0L;
	Tue, 04 Jul 2023 08:11:00 +0000
Received: from mout.web.de ([212.227.15.14])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGb7h-00CXPA-2D
	for linux-um@lists.infradead.org;
	Tue, 04 Jul 2023 08:10:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688458240; x=1689063040; i=markus.elfring@web.de;
 bh=MbgMZUtDc5LOymBuVB4BFHT9KcCaMcbbhxDpCilF3pk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oBfsflY89gRUJ3BtJcb7ccqLlONqosNPjJQe8W0w/uGt/P/nrVfNUHns5jmZc7+hxejmEdu
 +kCPrCo4NQhqreoS0ZyZX1xG0AdWd9+Q173kEq9ygDZSTNl9qlS0/TpTOJkmanviva74W+9K6
 QLtFaqGzmViihZNyo+bf4Exgym4MW/qM7hAQPZMnHwJ35+onldScTt0B4wpZN/5QFgWXf0ET8
 TCu06fgdbFhIGc3wNOCHCorZLn5QTyqho9PTchHZ7uQzhc54QHakJINMnzX6Wdq+BW5vwjVVi
 DEJlojyR79aWm1RIrzWWuowVJX7YDNdnBIe9S+os8HTgiW6Eh0dA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1qMMot2jxj-007Wrm; Tue, 04
 Jul 2023 10:10:40 +0200
Message-ID: <a30aec3c-fb81-4e5d-c131-e59de87a3aed@web.de>
Date: Tue, 4 Jul 2023 10:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] um: vector: Replace undo_user_init in old code with
 out_free_netdev
Content-Language: en-GB
To: Minjie Du <duminjie@vivo.com>, linux-um@lists.infradead.org,
 kernel-janitors@vger.kernel.org, bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230704042942.3984-1-duminjie@vivo.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230704042942.3984-1-duminjie@vivo.com>
X-Provags-ID: V03:K1:Gr4ZCxwnyhoYOnwb21965EOD9UzhKJD7CwSw+3kSpNxyjoCCozS
 r+uOxpLUhREiRakKn3e1XP3WVp/FhdY8Sh36t0V6FOS/welkJE4TlMLmEOiD9+/t1Q4nJRn
 L95IifQkAMFRfpHIQlrun9zEqEFFGRNSl/nSLbRbI6BYFGmaS7QdKAKJlIfevqL/RudIIvA
 I+EQvB0dXmGEa4JJi7m8Q==
UI-OutboundReport: notjunk:1;M01:P0:kYSE/kgDd3k=;pm6qATdE/9V8SP38mZT26tP/0dZ
 dJMu9xkJ4MFXCXBMnZ5avnUteo1KOygJVaSzp3vfhkJwbxoPNZs94xpkcnDkKdhWCQ2/stb4u
 1VqNpbc0yuLR+GwspKM/quSFqQ9z6MJYyMNtAqvSVkjO4UxS47CYB6R8r+3yx12BcXf2xdf1/
 4l7rHDX6ck8ZVhzTHaDEqSSGgSsbjnJCIEOk+WfAhcck8isxSZQfeYFN0ApeZZZhCYvifBUbo
 jXq6Esj0tKzT0RJWQC6mQuYRF3mMZOo3Lafu2LPocDgtPX3OmQHrt5G2rC/NCTYoTMNN8C0cs
 hRkKt7SKQZ4J538axWIKqyOGrNx+4NW4zksXiIj5bULWAMHyrKTZ4N/7hYXOO768rdn+INWct
 LOchIkSHw5CWXl6wADBLXID2zy9xZiEbZZmLAr3SbqV4Mo4zKlmhkEiC+L5iZ7ychZO1qEB1V
 Ovf51G9VgG9z9YnyLL2E/TYokyu4ArsvAXMMfQK41Ce3tIQ+nmWHiA+J3xLM/v5bFr9wY5QXv
 R20I99Cg4nqWA0X2lUE1zg27dE0cvnwiJvp2Yu45ARAFae4yNiiibqoO10KyIN1GmZRbE55hI
 83tQ1qBMIPnnYe+SJ+1LAL/Gjd9E7yVZZR6gqvBTXYCzKyB7aeYc9flLwrTVZbYiiCigyyHfM
 nLwKlZ1uYZ9llBEPfKPtQPMkCWbaAZyHoxenxuV7c4wxCCQoQ76DndxuHNjEfcy+WbaHHf8h+
 i0YsOvkv6nJ6vJ09jU62h1gcohGJ6AEgc5aqCokQoxsxjM3smxTsqNSjDyDCACzbYbMho5Qpf
 +x4EwRZUN6AoQTgEIn1vkTnIMl59h3CcA5dTUhGwJC0vu3NJ05f2zM/jdk7NuvE/7uxR4owW3
 QPxyFVGC9IvqCUn5nWAPtxkbkjTQ97HMhh9sWTBhrl21WL+2XyQ2At/0enrvWGNMngA2vhk7A
 27PFWQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_011058_003243_D51484A0 
X-CRM114-Status: GOOD (  11.14  )
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

PiBUaGFua3MgZm9yIHlvdXIgcmVzcG9uc2UgYW5kIHN1Z2dlc3Rpb25zLAo+IEkgbWFkZSBzb21l
IG1pc3Rha2VzLiBUaGlzIGlzIGEgcmVzdWJtaXR0ZWQgcGF0Y2guCgpZb3UgcHJlc2VudCBhIG5l
ZWQgZm9yIGZ1cnRoZXIgaW1wcm92ZW1lbnRzLgoKCj4gSSBnb3Qgc29tZSBlcnJvcnMgd2l0aCBt
eSBsb2NhbCByZXBvc2l0b3J5LAo+IHNvIEkgbG9zdCB0aGUgY29tbWl0IFNIQS0xIElELgoKSSB3
b25kZXIgYWJvdXQgc3VjaCBpbmZvcm1hdGlvbiBoZXJlLgoKCj4gRml4ZXM6ICgiZHJpdmVyczog
dXNlIGZyZWVfbmV0ZGV2IGJlZm9yZSByZXR1cm4gaW4gdmVjdG9yX2V0aF9jb25maWd1cmUoKSIp
CgpQbGVhc2UgcHJvdmlkZSBhIG1pc3NpbmcgZGV0YWlsLgoKCj4gUGxlYXNlIGNoZWNrIHRoaXMg
bGluayB0byBzZWUgcHJldmlvdXMgcmVwbGllcy4KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvODg1NDY3NWYtOTllNy0zMTRlLWM5ODYtOGRjOTU0ZWU0YTI3QHdlYi5kZS8KCldv
dWxkIGEgc3ViamVjdCBsaWtlIOKAnFtQQVRDSCB2NF0gdW06IHZlY3RvcjogRml4IGV4Y2VwdGlv
biBoYW5kbGluZyBpbiB2ZWN0b3JfZXRoX2NvbmZpZ3VyZSgp4oCdCmJlIG1vcmUgYXBwcm9wcmlh
dGU/CgoKPiBUaGlzIHBhdGNoIG1ha2Ugb3V0X2ZyZWVfbmV0ZGV2IHJlcGxhY2UgdW5kb191c2Vy
X2luaXQsCj4gZml4IGV0aGVyZGV2IGxlYWsgaW4gZXJyb3IgcmV0dXJuIHBhdGguCgpUaGUgcmVz
b3VyY2UgY2xlYW51cCB3YXMgaW5jb21wbGV0ZSBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhl
IGZ1bmN0aW9uIOKAnHZlY3Rvcl9ldGhfY29uZmlndXJl4oCdLgpUaHVzIHJlcGxhY2UgdGhlIGp1
bXAgdGFyZ2V0IOKAnG91dF91bmRvX3VzZXJfaW5pdOKAnSBieSDigJxvdXRfZnJlZV9uZXRkZXbi
gJ0uCgoK4oCmCj4gLS0tCj4gIGFyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5jIHwgNCArLS0t
CuKApgoKSSB3b3VsZCBhcHByZWNpYXRlIGZ1cnRoZXIgdmVyc2lvbiBkZXNjcmlwdGlvbnMgaGVy
ZS4KClNlZSBhbHNvOgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0
dGluZy1wYXRjaGVzLnJzdD9oPXY2LjQjbjY5OAoKUmVnYXJkcywKTWFya3VzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
