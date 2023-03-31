Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCA5C761AF
	for <linux-um@archiver.kernel.org>; Fri, 31 Mar 2023 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cz08FvAgPf2dHJ6Ou4ZjYe0WB9L3m4Rw8INKZK3LJlE=; b=muzy3ISw5zW0bb
	QjCmPlZREzgUMFhQ82ajYElOK9w7aFZOcB8PiwFKiK5IJriXs0UoTR+/mvCZ2VCqr9zZvhx4/oD6A
	dokBlQwaX2duKArZNnHoOVoPRvCP6Wq5RDkh5z4V6rIM2huLMEi3uKS4vEjP1WviSAkE6NXN2K5yN
	ZvY0gNeO1smasGO94qrP5dnutQJo1tuO5UO9I5eqBrlDy2zc7qIdXZ4JwcZGEt+cuXTXYzGuuO5dA
	hnqtkuIt1OQZgJ4n/J7nmAGxjixuEi/ETCa1Mjg0NmmcdSwbU3Qe6tItC+16mTeObJ6n0U4UtXe9p
	ngj1xe4buvy+IXTRhyWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piEys-007YWO-2O;
	Fri, 31 Mar 2023 13:39:50 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piEyq-007YVf-0Z
	for linux-um@lists.infradead.org;
	Fri, 31 Mar 2023 13:39:49 +0000
Received: by mail-yb1-xb36.google.com with SMTP id r187so27417637ybr.6
        for <linux-um@lists.infradead.org>; Fri, 31 Mar 2023 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680269986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8HyCR6qUgL2YL9MIarBVNh91rgqxInYdUkkRv7lzCA=;
        b=nRQVT9ShE0pExTB54GDQVPUoE5xeg0yZISdISWCkiaC/z9HRj31sfeE6I5mTha44sY
         FqPQHA8gp7feZ2Ap/WXLKcka4qprU9xOlYAwx/PsdGZrVMjzLZqi2emdau+nG0Hbv0C3
         3/kWmtGI/xWfhv3DXsK6HXxEZX3kBUw71sF2+RvpC1SgGXf/T9LO5ytk9j8HSurCFxee
         8IykdnR/8W6eifFOBjLc/iLlqTguUMNQnQ6jcxlYoujxYzVJa5RTq3wnT+T4zjX/HXub
         ROpXfaWDFJ+FMzmoEHNv30WTzud50vzxa8ncXd6vRq1MBzStrtfx2oA3T2JFefm8Cyoo
         i9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8HyCR6qUgL2YL9MIarBVNh91rgqxInYdUkkRv7lzCA=;
        b=oBzDzNhq5psG7bSljDbePxGUb2i7QEkbXzueKUzkFtVApy8M21N6QhP+c1yTN53PJB
         P5G2yKmLPz7NuJ0aZcYZ49aSIg8uioChodO5G1MpJKvs+OGXwWcWwOdIvqMltLxk2af7
         Umk73KrS/8yPFkazN65Zfuy0s8bi8tM5351COiZNuQBudqzRkyjvLiSLDbzfRKNCQ9rx
         nkgczAKsvi7L3oHbzERQo3Bz8QFJFm3/lrKXzVRrdCqf1ltjeP8SCY1SxhaWBhVDBaRj
         ReCx4Cek8QmgyKjBYSmodN0GmsBhZGegOkT9UMNKE9flQtZMlPhtypndycZ03iaaYOQ7
         0QHw==
X-Gm-Message-State: AAQBX9fwDNt3TNfqQwTP2gtfAKg8ztZF+cGIWtepukeW3C/KG45widqL
	be+qlG3vcsq1Al/l2tU5rDO487ZYOIOuXkC4x4s=
X-Google-Smtp-Source: AKy350apgoEPMUQxWR00klwXYYscnIAK0OZLPQx0ko6VrOlHD0pJFBErJN002gXBJZ2Hpee+HGT0ekYIUQKFrIQIx4Q=
X-Received: by 2002:a25:2f84:0:b0:b6e:d788:eba0 with SMTP id
 v126-20020a252f84000000b00b6ed788eba0mr17842248ybv.11.1680269986074; Fri, 31
 Mar 2023 06:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230318041555.4192172-1-davidgow@google.com>
In-Reply-To: <20230318041555.4192172-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Mar 2023 15:39:35 +0200
Message-ID: <CANiq72==YbpCJPLOkCBGRkTYCOokLrEUNASn_JUpY2Ndw1sHfw@mail.gmail.com>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old GCC bugs
To: David Gow <davidgow@google.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, SeongJae Park <sj@kernel.org>, 
	linux-um@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_063948_234502_179657E9 
X-CRM114-Status: UNSURE (   7.92  )
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

T24gU2F0LCBNYXIgMTgsIDIwMjMgYXQgNToxNuKAr0FNIERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj4KPiBOZXZlcnRoZWxlc3MsIG9ubHkgZGlzYWJsZSBTU0Ugb24gY2xh
bmcgc2V0dXBzLCBhcyB0aGF0J3MgYSBzaW1wbGUgd2F5Cj4gb2Ygd29ya2luZyBhcm91bmQgZXZl
cnlvbmUncyBidWdzLgoKU291bmRzIGdvb2QgdG8gbWUuIElmIEdDQyA+PSAxMSBoYXMgZml4ZWQg
aXQsIHNob3VsZCB3ZSBpbnN0ZWFkIHRlc3QKZm9yIEdDQyA8IDExLCBpLmUuIGl0IGNvdWxkIGhl
bHAgY2F0Y2hpbmcgZnV0dXJlIG5ldyByZWdyZXNzaW9ucyBsaWtlCnRoZSBsaW5rZWQgR0NDIGJ1
ZywgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgcmlnaHQ/IE9mIGNvdXJzZSwgdGhhdApjb3Vs
ZCBiZSBkb25lIGZvciB0aGUgbmV4dCBjeWNsZSwgc2luY2UgdGhpcyBvbmUgbWluaW1pemVzIHRo
ZQpvcmlnaW5hbCBjaGFuZ2Ugdy5yLnQuIHY2LjIuCgpCeSB0aGUgd2F5LCBtaXNzaW5nIHNwYWNl
IG9uIHRoZSB0aXRsZSAoYGFyY2g6dW1gKS4KCkNoZWVycywKTWlndWVsCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
