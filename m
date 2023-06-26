Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C95EB64D7
	for <linux-um@archiver.kernel.org>; Mon, 26 Jun 2023 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3BerNbwAtCnCPidVHb0Gsvm2UEqVJw1Eftl2LSk4ZKc=; b=Xz4xOdorKJg6wy
	F/HEiu+SqiEqEVJhikvm5lUD7jCo/GNs6Yf0oTQ1MTOHSWwyuWx65raZ7STMDwzc0qfENTmpIAjTD
	2/ugdKKMu1ib2qNqesHUoqUxUbOr+ocQC7XBVbUcWBs81fHP57Dx7uO8AhIixdsKLWvH6ZUFrVCnR
	L+6KEK+4Npf5ml4g2yQ01qTOfqhqRz7OukUNRJnzqVKJ+ScGwjlICQ1ndlLXkGwAcIGnsb88bsKHj
	6dYCk+xiS9dcWLTAgsZtw2eifs42j5HQuuVmyGEGdty/8ZuFOHdqoM/8CJGmhsR6s38Pc8Ap/Yzkq
	58IKauPBjG4TK+wbc+Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDhu0-009fVy-2F;
	Mon, 26 Jun 2023 08:48:52 +0000
Received: from smtp-1909.mail.infomaniak.ch ([2001:1600:3:17::1909])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDhtw-009fUv-1z
	for linux-um@lists.infradead.org;
	Mon, 26 Jun 2023 08:48:51 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QqM2M0mHtzMpqsT;
	Mon, 26 Jun 2023 08:48:43 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QqM2L1jyXzMpvVT;
	Mon, 26 Jun 2023 10:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1687769323;
	bh=aEhUEFjlWBzIziOJJuCpxbJR2jQcCyx7meGNZnSvhvk=;
	h=From:To:Cc:Subject:Date:From;
	b=MZ7Nlj8eZb95HPTOedrkSDfhjlo2sRy4yuyIQMydvoqcfNvedTf3b8bIzBMun4lJ1
	 VtzLHyotWl8rHCLzSE9oT2lbpGtyjenJjAWryvZQttYBXTRLb4HfLl836g8K0x4cVH
	 LFdChgyxRi3Zi+H5y11/TQQRLq5/N2C+qhfgJqf8=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [GIT PULL] Landlock updates for v6.5
Date: Mon, 26 Jun 2023 10:48:30 +0200
Message-ID: <20230626084830.717289-1-mic@digikod.net>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_014849_114451_81945C33 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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

SGkgTGludXMsCgpUaGlzIFBSIGFkZHMgc3VwcG9ydCBmb3IgTGFuZGxvY2sgdG8gVU1MLiAgSW4g
ZmFjdCwgdGhpcyBmaXhlcyB0aGUgd2F5Cmhvc3RmcyBtYW5hZ2VzIGlub2RlcyBhY2NvcmRpbmcg
dG8gdGhlIHVuZGVybHlpbmcgZmlsZXN5c3RlbSBbMV0uICBUaGV5CmFyZSBub3cgcHJvcGVybHkg
aGFuZGxlZCBhcyBmb3Igb3RoZXIgZmlsZXN5c3RlbXMsIHdoaWNoIGVuYWJsZXMgdG8Kc3VwcG9y
dCBMYW5kbG9jayAoYW5kIHByb2JhYmx5IG90aGVyIGZlYXR1cmVzKS4gIFRoaXMgUFIgYWxzbyBl
eHRlbmRzCkxhbmRsb2NrJ3MgdGVzdHMgd2l0aCA2IHBzZXVkbyBmaWxlc3lzdGVtcywgaW5jbHVk
aW5nIGhvc3Rmcy4KClRoaXMgUFIgY2FuIGxlYWQgdG8gYSB0cml2aWFsIG1lcmdlIGNvbmZsaWN0
IHdpdGggdGlwIFsyXSB3aGVyZSBvbmUgb2YKVGhvbWFzJ3MgY29tbWl0IGFkZHMgQVJDSF9IQVNf
Q1BVX0ZJTkFMSVpFX0lOSVQgYW5kIG9uZSBvZiBtaW5lIHJlbW92ZXMKQVJDSF9FUEhFTUVSQUxf
SU5PREVTIGluIGFyY2gvdW0vS2NvbmZpZy4KClBsZWFzZSBwdWxsIHRoZXNlIGNoYW5nZXMgZm9y
IHY2LjUtcmMxIC4gIFRoZXNlIGNvbW1pdHMgbWVyZ2VkIGNsZWFubHkKd2l0aCB2Ni40LCBhbmQg
aGF2ZSBiZWVuIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgaW4gdGhlIGxhdGVzdCBsaW51eC1uZXh0CnJl
bGVhc2VzIGZvciBhIGZldyB3ZWVrcy4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMzA2MTIxOTE0MzAuMzM5MTUzLTEtbWljQGRpZ2lrb2QubmV0LwpbMl0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL2I1NzQ4MWFmLTU4MjQtNzJmNy1kMjBmLWNmZDc4ZmNkZTUxOUBkaWdp
a29kLm5ldC8KClJlZ2FyZHMsCiBNaWNrYcOrbAoKLS0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNp
bmNlIGNvbW1pdCA4NThmZDE2OGE5NWM1Yjk2NjlhYWM4ZGI2YzE0YTlhZWFiNDQ2Mzc1OgoKICBM
aW51eCA2LjQtcmM2ICgyMDIzLTA2LTExIDE0OjM1OjMwIC0wNzAwKQoKYXJlIGF2YWlsYWJsZSBp
biB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9taWMvbGludXguZ2l0IHRhZ3MvbGFuZGxvY2stNi41LXJjMQoKZm9y
IHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDM1Y2E0MjM5OTI5NzM3YmRjMDIxZWU5MjNmOTdl
YmU3YWZmOGZjYzQ6CgogIHNlbGZ0ZXN0cy9sYW5kbG9jazogQWRkIGhvc3RmcyB0ZXN0cyAoMjAy
My0wNi0xMiAyMToyNjoyMyArMDIwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGFuZGxvY2sgdXBkYXRlcyBmb3IgdjYu
NS1yYzEKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KTWlja2HDq2wgU2FsYcO8biAoNik6CiAgICAgIGhvc3RmczogRml4IGVw
aGVtZXJhbCBpbm9kZXMKICAgICAgc2VsZnRlc3RzL2xhbmRsb2NrOiBEb24ndCBjcmVhdGUgdXNl
bGVzcyBmaWxlIGxheW91dHMKICAgICAgc2VsZnRlc3RzL2xhbmRsb2NrOiBBZGQgc3VwcG9ydHNf
ZmlsZXN5c3RlbSgpIGhlbHBlcgogICAgICBzZWxmdGVzdHMvbGFuZGxvY2s6IE1ha2UgbW91bnRz
IGNvbmZpZ3VyYWJsZQogICAgICBzZWxmdGVzdHMvbGFuZGxvY2s6IEFkZCB0ZXN0cyBmb3IgcHNl
dWRvIGZpbGVzeXN0ZW1zCiAgICAgIHNlbGZ0ZXN0cy9sYW5kbG9jazogQWRkIGhvc3RmcyB0ZXN0
cwoKIGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyAtCiBh
cmNoL3VtL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQogZnMvaG9z
dGZzL2hvc3Rmcy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGZzL2hvc3Rmcy9o
b3N0ZnNfa2Vybi5jICAgICAgICAgICAgICAgICAgICB8IDIxMyArKysrKysrKy0tLS0tLS0tCiBm
cy9ob3N0ZnMvaG9zdGZzX3VzZXIuYyAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogc2VjdXJp
dHkvbGFuZGxvY2svS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAyICstCiB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9jb25maWcgICAgfCAgIDkgKy0KIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xhbmRsb2NrL2NvbmZpZy51bSB8ICAgMSArCiB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMgfCAzODcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0KIDkgZmlsZXMgY2hhbmdlZCwgNDc4IGluc2VydGlvbnMoKyksIDE0NCBkZWxldGlvbnMoLSkK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9jb25m
aWcudW0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
