Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F33FCE79A8
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=127EhjPfXH16DyP6r3QH6vTXIDG435NT3MbvWlYyJAY=; b=Dfyw0m0VxWOLoh
	o7QIKsY5Ll0dOOmmUulee9KkiXaQYNXijLVfyK84AGRSRIUw2LKqfuGwogOiVzAFKaBmLM+rvPY3W
	kwcJ7Sl1kK0uZNRVJD5ONWBzKdnyhi/vihu4ZfuE9kzC+qilJJRbR6t0BxmAshaxH5XbqnHLxjw6i
	8Q6N43dQqvGMdAuq+TZjzOMIo+WNCzRQ4gZre96KR/3pAv+kdrwbALMXtuyqRx7j5O9J6Fn+rHlZ4
	9azJv5xBYXPQZPaZpQjTgbbG1hS+lCeMCejFSz9Tf06gJirqzI7/xhc5cxIKgiWCYSumsg1f7KQEK
	a8qAW+gRvo7MHXqUa/7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidBp-000omY-2K;
	Tue, 19 Sep 2023 16:03:05 +0000
Received: from mail-yb1-f174.google.com ([209.85.219.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidBm-000ojU-0L;
	Tue, 19 Sep 2023 16:03:03 +0000
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d84c24a810dso2534565276.2;
        Tue, 19 Sep 2023 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139379; x=1695744179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ60uW+tbu6+KHWBtVlQ7lvtyHPfNfut3/R5HxH+TlQ=;
        b=mAZcHwhXVgm92Y/s/GodMZeUcLOktboaTMDPDZX2W72Ze8rN9DXgusa+7Oquhv4wNu
         8rhFSr66w0jOMWvlg7NA0Qj80c2r1hpeA3yBGhHJOT5WNKeSUlEPlT50n68ADeB5IGnb
         EsPwRGfjgsz7JkwUTRgBQWVJHxbK0y0f/N+7hc8+QWHkdtDJl8Ynwy7ESPhWo1IOJeOc
         3NRIHHoGbGEwMP4VxBojClqV6hglOrtWuAhF4Y1Pg4pc9TKuIFKtcW28MLpRUg4D5V+K
         YzuZXSCAnjiEL8b5F0zeGAhLyQuzZj9RLkkvlJ3SlonmqfI9Mf8ObKIXElIcmTGmCNYd
         pRqQ==
X-Gm-Message-State: AOJu0YxWity8M6q93rOjE2G1Drg0nY2KXOLuQj4RJldNJnWcYfLvWzSN
	FVVkrB4U4GYFZfCwk23rXk2ru+fkJx9QcQ==
X-Google-Smtp-Source: AGHT+IG4cjuBEJLKdr1a50B5sL7yV3kX21aalpZVJRvyQXbUWFsrAb6lAMYFW7n063S7QZ6TVs61DA==
X-Received: by 2002:a25:2d5:0:b0:d82:d72c:ed70 with SMTP id 204-20020a2502d5000000b00d82d72ced70mr12696ybc.36.1695139372666;
        Tue, 19 Sep 2023 09:02:52 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id s4-20020a259004000000b00d728a2738f1sm2760637ybl.61.2023.09.19.09.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 09:02:52 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d7e904674aeso5686288276.3;
        Tue, 19 Sep 2023 09:02:51 -0700 (PDT)
X-Received: by 2002:a25:cb0f:0:b0:d7b:8d0c:43ee with SMTP id
 b15-20020a25cb0f000000b00d7b8d0c43eemr12315ybg.37.1695139371557; Tue, 19 Sep
 2023 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca>
In-Reply-To: <20230919155832.4179-1-peter@n8pjl.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2023 18:02:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Message-ID: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: segher@kernel.crashing.org, anton.ivanov@cambridgegreys.com, 
	ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, 
	richard.henderson@linaro.org, richard@nod.at, tsbogend@alpha.franken.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_090302_148598_02CB8821 
X-CRM114-Status: GOOD (  14.23  )
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

SGkgUGV0ZXIsCgpPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCA1OjU44oCvUE0gUGV0ZXIgTGFmcmVu
aWVyZSA8cGV0ZXJAbjhwamwuY2E+IHdyb3RlOgo+ICAyKSBTdG9wcyBidWlsZGluZyBhbiBvYnNv
bGV0ZSBhbmQgbGFyZ2VseS11bnVzZWQgZmlsZXN5c3RlbSB1bm5lY2Vzc2FyaWx5Lgo+ICAgICBT
b21lIGhvYmJ5aXN0IHRhcmdldHMgbGlrZSBtNjhrIGFuZCBhbHBoYSBtYXkgcHJlZmVyIHRvIGtl
ZXAgYWxsIGZpbGVzeXN0ZW1zCj4gICAgIGF2YWlsYWJsZSB1bnRpbCB0b3RhbCByZW1vdmFsLCBi
dXQgb3RoZXJzIGxpa2UgYXJtIGFuZCBVTUwgaGF2ZSBubyBuZWVkIGZvcgo+ICAgICBSZWlzZXJG
UyB0byBiZSBidWlsdCB1bmxlc3Mgc3BlY2lmaWNhbGx5IGNvbmZpZ3VyZWQuCgpBcyBVTUwgaXMg
dXNlZCBhIGxvdCBmb3IgdGVzdGluZywgaXNuJ3QgaXQgYWN0dWFsbHkgY291bnRlci1wcm9kdWN0
aXZlCnRvIHJlbW92ZSBSZWlzZXJGUyBmcm9tIHRoZSBVTUwgZGVmY29uZmlnPyAgVGhlIGxlc3Mg
dGVzdGluZyBpdApyZWNlaXZlcywgdGhlIGhpZ2hlciB0aGUgY2hhbmNlIG9mIGludHJvZHVjaW5n
IHJlZ3Jlc3Npb25zLgoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXgg
YmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNh
dGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQK
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0t
IExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
