Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF0C7EE25
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 21:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VymAkdm8LLVxOFK77tBuRxxstEOvCs9wDzje+QGEW7s=; b=iwIYEVsI+xtq+e
	xQ/YUvmTBFxplsVWIGy2WI9Qq3uuMjhlz/wfhOEzCqXRUbFD/bpkb/oDi8kpSdWXWx6BG8DeCQgXB
	3Bol/CZF/k+phu0mP6jJ4gwrNi0SnHmXYXRRS9GhnqNukBNJDlJ9GC+Blw4JUsBwZCcByFhYsAZHy
	xR1924iJWe0GZocWsnVRsw1j3eAjSVvFAKZvefR9PA3RPX+bsRj7exdIE7/zelugqh7zEtLARE0+P
	nmVqKkI4++s83XiJW4LdP3YyT0KBFGnjfXYjlCDExfXn/a8W2Pn0FgflldWZA+2b0BNV2hNRHSw+U
	iPReJDQZ1vcohfWRkwTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jl4-00EK3E-2O;
	Fri, 09 Jun 2023 21:34:58 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jl2-00EK2h-36
	for linux-um@lists.infradead.org;
	Fri, 09 Jun 2023 21:34:58 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-786d10951d8so806412241.3
        for <linux-um@lists.infradead.org>; Fri, 09 Jun 2023 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346496; x=1688938496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g2CkLL/4yGzWZqO3b6RZAXklev+mp6Fy0i6OZOPQIk=;
        b=EO09QpsjpKrLGL7DHyLbPLp+EWHMBIFl3CGbn03V+M9RmYJaSLIVwEycdhNNy7ifKi
         Ign6Sy4zZkhiHyKeFymndPSMkSJqy2WIMxjqKrZVHDXVM8/juTkKFKs5oT7abFw77Kub
         CESJnLTikhwVXJs3B0OMVH5N4K1kV8OLARSfKfZoePsneLfQvb7kHRyuoE8cy71iwJsx
         f1oJ2gmHelpkOxHNsZaTa/netb0FZAIYUggjQO7No4ttZ/MBVTq6wjP9FzF5tCbL4Bxm
         Y/xedyP3uaKAw4C3o2dv9jSH6U71N4G81qRvBR4lhK2M5uGGSYzE+wCtpNPxQeLbtMxH
         t+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346496; x=1688938496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g2CkLL/4yGzWZqO3b6RZAXklev+mp6Fy0i6OZOPQIk=;
        b=d+a1xXaCTUA8GhZw27zFN3jtaebhwtXEJl9mvQmreoLJ2NcneyEe6gwW7eFqCiPaS/
         PmsDYBoXfva714mPnLiAGe9oNp2wOHF6c80WOjAK8LhEci+pu3O4uf+D7tO9dHxXCTgs
         /asDAmDyXFDF9PbpUN5Cblde6byfcJxoqdBvJTglYk/pXxcWnUW+1UA1WFZxsd9+CJgE
         npiUO5BhBTE1B+Ecbji4KH0lRCTsrwsZC1woEjtVLYY6iS/tbPpzG63ZsGFFw91nBowl
         Ib4dcVry0lPtHgbrf6f1AFie5m4zRTORhB7K67kAEQRKiONeDieLPf1EZUOCWvx5l+3/
         zSyw==
X-Gm-Message-State: AC+VfDyAlK1xBKEcMBiKAMVnqfUOqYGnh1w4Nu3krkGRCrsURFctBn3i
	pt5gh6oPky3fnI/RlYvdP9zzCq680UUn3O/5c1wuXQ==
X-Google-Smtp-Source: ACHHUZ4uOlZrQzARsnpEKvHVVeGTzA69TCoAo9WRUuK65g8a56cI413B+BDwzV32gGdkFpzHAkebZEqdVXOVyAdVUe0=
X-Received: by 2002:a67:fc59:0:b0:43b:37d8:2608 with SMTP id
 p25-20020a67fc59000000b0043b37d82608mr1882079vsq.29.1686346495600; Fri, 09
 Jun 2023 14:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-4-masahiroy@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Jun 2023 14:34:10 -0700
Message-ID: <CAKwvOdmA7oPvUZ-AhY8J9DGk0j5z=xCED8r3Ug=n2S9q-BWb+Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_143457_022996_A89625D5 
X-CRM114-Status: UNSURE (   6.83  )
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA3OjI04oCvQU0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBDb21taXQgN2I0NTM3MTk5YTRhICgia2J1aWxkOiBs
aW5rIHN5bWJvbCBDUkNzIGF0IGZpbmFsIGxpbmssIHJlbW92aW5nCj4gQ09ORklHX01PRFVMRV9S
RUxfQ1JDUyIpIG1hZGUgbW9kcG9zdCBvdXRwdXQgQ1JDcyBpbiB0aGUgc2FtZSB3YXkKPiB3aGV0
aGVyIHRoZSBFWFBPUlRfU1lNQk9MKCkgaXMgcGxhY2VkIGluICouYyBvciAqLlMuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgoKVGhhbmtz
IGZvciB0aGUgcGF0Y2ghClJldmlld2VkLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmll
cnNAZ29vZ2xlLmNvbT4KCgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
