Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B2CC77B6E
	for <linux-um@archiver.kernel.org>; Thu, 13 Apr 2023 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6M+KwQhYBF0XOHqJgTjv2dfYpAeKQqBpAcaVADBTmao=; b=lAR1HKAYz0wyII
	Ylb0ratYcrM/ydj2X7+D5i4wPLQwSs7gp+R+Vkou6LjLEAc1ajb9syWvckB+00cqBdbKssbo9pcpI
	cAgTDk5BWazBw6NJGGDcHj/0G4odmdFDx+BvOwfQJUtZgmDOIKaRM2UTBP1RWs8UkGVZlqjsiSGho
	FNDftHW498z7JYLqL6bwC8rGsrPOvWki7T+Je2Q9/WLR9fRF1OabueRYIaU+Iw3ZNX95TT00R8v80
	l1Rli1FzjI4Jv6iCzYl5ULtzBzTNELKPHyenQh3F25ZyZ0ICiv4Nemk3kiO9JBjiAWpvRtfex/YNh
	8CZN2ry/ltwn7Wn36FWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn5Sk-007GBC-0x;
	Thu, 13 Apr 2023 22:30:42 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn5Sh-007GAh-31
	for linux-um@lists.infradead.org;
	Thu, 13 Apr 2023 22:30:41 +0000
Received: by mail-wr1-x431.google.com with SMTP id s12so7198009wrb.1
        for <linux-um@lists.infradead.org>; Thu, 13 Apr 2023 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681425037; x=1684017037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUsfpL+K+BlvukIqrGl++82+86oPWJSZfuVWP7V5gsk=;
        b=Zmp/FmaQwlQzyv3m6/mUCpXycw27oR8c69gBialMEwPryH1i9irf5SQL+lcPcshp0u
         6dRSIZdzZvILEU1zRSpfTC204urvfgS84XOaD4VZI/Y+SWy5/kXP3naTOXhN8D9BN4Y3
         RcHHf/t1D4k3Od0KDYCwI9JelSzx7xCv5dPXUg6Hj7htQjMN8mCGVLIQPC3jINT+87jo
         azlccg5+nttopOgFRiYKpCKa9LBcUDHUcEGSMQKhoOnKks24QUKDaAux1xYV6jbmZiQp
         lPmbDzmEcLMSwgM80L7oTsB8r4wgcX6CZom+CPKJXb6XJaOIbybPwtUz01GOlb0iDGPN
         8m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681425037; x=1684017037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUsfpL+K+BlvukIqrGl++82+86oPWJSZfuVWP7V5gsk=;
        b=iSDzf6zyZHsQNfCB3Q0Bg/qtukWbtZDEPlPUS8jrm0TxSVliSziOAJwYFbqSyTUiZn
         KU4Noy++1yO9XKseV5CfvoFrU82ztd9cnqPcEXTxi32oZAOAJ6HlSWSijvxfzJkhlKtR
         JvQmLwjCfT5/X/FXcJJBfiwhg2dpK4EZmQLnZJPXigusdfh0bNGOAQgBNPJ8kpJbmW0r
         psZ+tC+QC1WLmeacsnc6gYIsfzEd2G1PxMnxxjIiiVeUBYOaDIhFy2wR/cmEIukI8lKz
         +hOjXyOpCnm1FrpxZbXKl5KcMxccKjP0uVtluuuUdSrhasJ2sUOtrhSOTaMcwqyRD+cA
         NLrg==
X-Gm-Message-State: AAQBX9fyvfcoGL89+fYh4SULWGubtXGr1QaEGriShfE95ny+05AswfAy
	XlxBJ6lTxjk52skvnzNysgcDXW4dgzShByFBZCc=
X-Google-Smtp-Source: AKy350Z0ah+Eoaj6PIOu+6ZAu11z+/evjtJOHpY/rVRD8NiwMx1Cpevsp30bdZj9RYNqa7eww7yFCg==
X-Received: by 2002:adf:cf08:0:b0:2ef:21da:d611 with SMTP id o8-20020adfcf08000000b002ef21dad611mr2188559wrj.22.1681425037303;
        Thu, 13 Apr 2023 15:30:37 -0700 (PDT)
Received: from laptop-fedora.. ([79.175.90.109])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b002f02dbddc26sm2133889wri.68.2023.04.13.15.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:30:32 -0700 (PDT)
From: =?UTF-8?q?Marko=20Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: linux-um@lists.infradead.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	=?UTF-8?q?Marko=20Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
Subject: Document new xattrperm flag
Date: Fri, 14 Apr 2023 00:30:22 +0200
Message-Id: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_153040_001726_D82C4B55 
X-CRM114-Status: GOOD (  16.09  )
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

SGVsbG8sCgpJIGFtIE1hcmtvIFBldHJvdmnEhy4gSSBoYXZlIGJlZW4gdXNpbmcgVXNlci1Nb2Rl
IExpbnV4IChVTUwpIGZvciBzb21lIHRpbWUKYW5kIEkgaGF2ZSBub3RpY2VkIHRoYXQgaW4gdGhl
IGRvY3VtZW50YXRpb24gaXQgaXMgc2FpZCB0aGF0IFVNTCBjYW4gYm9vdApmcm9tIGhvc3RmcyBo
b3dldmVyLCBob3N0ZnMgZXhwb3NlcyBmaWxlIHBlcm1pc3Npb25zIG9mIHRoZSBob3N0IHRvIHRo
ZQpVTUwsIGFuZCBjaGFuZ2luZyB0aGVzZSBwZXJtaXNzaW9ucyByZXF1aXJlcyB0aGF0IHRoZSBr
ZXJuZWwgaGFzIG5lY2Vzc2FyeQpwcml2aWxlZ2VzIG9uIHRoZSBob3N0LgpJbiBhZGRpdGlvbiB0
byB0aGF0LCBhbGwgZmlsZXMgYXJlIGNyZWF0ZWQgd2l0aCB0aGUgb3duZXJzaGlwIG9mIHRoZQpr
ZXJuZWwncyB1c2VyIGFuZCBncm91cCBzaW5jZSB0aGUga2VybmVsIGlzIHBlcmZvcm1pbmcgZmls
ZSBjcmVhdGlvbi4KClRoaXMgY3JlYXRlcyBvYnZpb3VzIHByb2JsZW1zIHdoZW4gYSBtdWx0aXVz
ZXIgc3lzdGVtIGlzIHJ1bm5pbmcgaW5zaWRlClVNTCBzaW5jZSBhcHBsaWNhdGlvbnMgY2Fubm90
IGNyZWF0ZSBmaWxlcyB0aGF0IHRoZXkgb3duIGFuZCB0aGUgVU1MCmtlcm5lbCBmb3JiaWRzIGZ1
cnRoZXIgYWNjZXNzIHRvIHRoZXNlIGZpbGVzLiBUaGlzIGluIHBhcnRpY3VsYXIgY2FuCnByZXNl
bnQgcHJvYmxlbXMgd2hlbiBib290aW5nIGZyb20gaG9zdGZzIHRoYXQgYXBwZWFycyB0byBvdGhl
cndpc2UgYmUKc3VwcG9ydGVkLgoKT25lIHNvbHV0aW9uIHdvdWxkIGJlIGZvciB0aGUga2VybmVs
IHRvIHJ1biB3aXRoIHRoZSBuZWNlc3NhcnkgcHJpdmlsZWdlcwp0byBhbHRlciBmaWxlIHBlcm1p
c3Npb25zIGFuZCB5ZXQgc3RpbGwgYWNjZXNzIHRoZW0gaW4gb3JkZXIgdG8gc2VydmljZQpzeXNj
YWxscyB0byBVTUwgcHJvY2Vzc2VzIGFuZCBhbm90aGVyIChpbiBteSBodW1ibGUgb3Bpbmlvbiwg
cHJlZmVyYWJsZSkKc29sdXRpb24gd291bGQgYmUgdG8gc3RvcmUgcGVybWlzc2lvbnMgdXNlZCBi
eSB0aGUgVU1MIGtlcm5lbCBzZXBhcmF0ZWx5CmZyb20gaG9zdCdzIHBlcm1pc3Npb25zIHNvIHRo
YXQgdGhlIGtlcm5lbCBjYW4gcnVuIHdpdGggc3RhbmRhcmQKcHJpdmlsZWdlcy4KCkluIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgSSBoYXZlIHdyaXR0ZW4gYSBwYXRjaCB0aGF0IGFkZHMg
YSBib290Cm9wdGlvbiBmb3IgaG9zdGZzIGZvciBlbmFibGluZyB0aGUgdXNhZ2Ugb2YgZXh0ZW5k
ZWQgYXR0cmlidXRlcyBmb3IKc3RvcmluZyB0aGVzZSBwZXJtaXNzaW9ucy4gRXh0ZW5kZWQgYXR0
cmlidXRlcyBzZWVtZWQgbGlrZSB0aGUgbW9zdApyZWFzb25hYmxlIGNob2ljZSBmb3IgdGhpcyBw
dXJwb3NlIGFuZCBtb3N0IExpbnV4IGZpbGVzeXN0ZW1zIHN1cHBvcnQKdGhlbS4KCkkgaGF2ZSBh
bHNvIGFkZGVkIGEgdHJ5IGZvciBkb2luZyByZWd1bGFyIGNob3duKDIpIG9uIGZpbGUKY3JlYXRp
b24gd2hlbiBleHRlbmRlZCBhdHRyaWJ1dGVzIGFyZSBkaXNhYmxlZC4gSWYgdGhlIGtlcm5lbCBp
c24ndApydW5uaW5nIGFzIHJvb3QsIGl0IHdpbGwgZmFsbCBiYWNrIHRvIHRoZSBvbGQgYmVoYXZp
b3IuCgpJbiBhbm90aGVyIHBhdGNoLCBJIHByb3ZpZGUgZG9jdW1lbnRhdGlvbiB1cGRhdGUgZm9y
IGV4cGxhaW5pbmcKdGhlIHVzYWdlIG9mIHRoZSBuZXcgZmxhZyB3aGVuIGJvb3RpbmcgZnJvbSBo
b3N0ZnMuIEkgaGF2ZSBhbHNvIGNoYW5nZWQKdGhlICJmaW5kIiBjb21tYW5kIHRoYXQgd2FzIHVz
ZWQgdGhlcmUgc28gdGhhdCBpdCBub3cgc2tpcHMgc3ltbGlua3MKc2luY2Ugc29tZSBzeW1saW5r
cyBwb2ludCB0byBhYnNvbHV0ZSBwYXRocyBhbmQgdGhhdCB3YXMgY2hhbmdpbmcKcGVybWlzc2lv
bnMgb24gdGhlIGhvc3QgaW4gdW5pbnRlbmRlZCB3YXlzLgoKSSBhbSBsb29raW5nIGZvcndhcmQg
dG8geW91ciBmZWVkYmFjayBvbiB0aGlzIHdvcmsuCgpQLlMuIEkgYXBvbG9naXplIGlmIHRoZXJl
IGFyZSBhbnkgZ3JhbW1hciBlcnJvcnMgaW4gdGhlIG1haWwgYXMgRW5nbGlzaCBpcwpub3QgbXkg
Zmlyc3QgbGFuZ3VhZ2UuIEFzIHRoaXMgaXMgbXkgZmlyc3QgcGF0Y2gsIEkgYWxzbyBhcG9sb2dp
emUgaWYgSQpoYXZlIG1pc3NlZCBhbnkgcGFydCBvZiB0aGUgcGF0Y2ggc3VibWlzc2lvbiBwcm9j
ZWR1cmUuIEZvciBmdXR1cmUgcGF0Y2hlcwpJIHdpbGwgY29ycmVjdCBhbGwgZW5jb3VudGVyZWQg
bWlzdGFrZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
