Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF18ECA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tC2G8MEi+Qgc6YtX4GqkDnJqijVswtbQdET6mIsE3zQ=; b=awEVw0HXfX7dx6hhvJw88RTkze
	As1FLtxxGKrj3tWkRIbEUgPvUHL+KOeXEsPDAmuGKHizJKkM0WOaspZnJ9i0ULGO8COIu4W+ZOtJ6
	ykLam/RKsq9ZL4K08O+kUmuaFkI3ieLiI6vfoRX5as51TF6pPC6n4oCvUeUCiZifIMeHyVP11z+ZW
	b0eXxVA6Wa1crjzmvZdFxIrMaCyO7Ywj0lxGUvn7lcCvoxj6c58Ld/rHhyW1OuJGC8+9I0HW4/Stz
	mSzR5d43oNPEPsTTp8dB3x9WzeEA4mo+l9snQ0YJJyroyUdrC4tRNsOaS3wzOZOvW0Wi0r+QMAutb
	XWg4v/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMFk-000000020M5-2HkW;
	Tue, 29 Sep 2026 01:03:28 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMFi-000000020Lj-3IBO
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 01:03:27 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccc02279so2002300a91.1
        for <linux-um@lists.infradead.org>; Mon, 28 Sep 2026 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790643805; x=1791248605; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tC2G8MEi+Qgc6YtX4GqkDnJqijVswtbQdET6mIsE3zQ=;
        b=P/P64Tma9yMOYS5HawGNdfu8dBxIUw/01gYIak31dKQfNkRJ7zqztuoLj8I2xswGOn
         1QeIcK3LN+zsg37YGIYwpiNcnbRR2WMbqW1UjiplAR2JkptmXcpaQ1VuQelS69cJaSf4
         bYL7VpJ3xgTD3zdnv2zrc9uK71QNLQL/qwH91Jg6jodbHFikaQdydMTMKyEveKk6NGg7
         4GhgWD7PWxnIbiElEzPv4LKvx0JmxdjCnMFDPfjHqZinyXu2hqv2f0OA/a/H1lY3QVp8
         t+a3K1/BWyMY2INdUzS52KyADKhyeXsUCVVpvZGmpsAWyQ0q0perobaoqEqmRriMgnj0
         SiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643805; x=1791248605;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tC2G8MEi+Qgc6YtX4GqkDnJqijVswtbQdET6mIsE3zQ=;
        b=Lza1/LbvPnNfhII9TAFzXM5j+/wX0JZQQYPcDhC6AYiUE33kLxopYVvYDBz/OUA9SG
         IJtcD/OVc03Ok6uvqwl50zHNpg5vQx6YG+7DPKEN/xY3DUYr/lMqF/1DhotE5KVIxgFb
         uDSgKlNumhPJz+kYps8vZ0i+fIIhmIuZ9dCxez5/bv/iMA9tbyIeh2ACJiw11xEbpf1J
         WRNAPYZOFk4pp21m26kProlQ1PqO5eGqE+z2ex7HOsgjB6pYp3RkSCpU5qdLx23hJ1sJ
         Xw/YfTdEG7B3o8k3hJEZ2r5SpaN6lWp/XDOjihng2txIBHGoPfuFllpCDV+sszPMIral
         +Gqw==
X-Forwarded-Encrypted: i=1; AKwUvBwqs81L7BPD5mAWuu4ZEY2x1PU4tENjTe0xJcx0Wt1V4rw4TIn8VeYu7wwCWpCeDRc3UIJ6Vonfnw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJY9Dru+ewU9rmqdi/T6f1C5ifMwqZVZHLzVH46C4QpMXzljETn
	owiiRcA/bFjOk6hbW+9+32YKEi8n8FMR2wUtSOhYkVbuDgRXEsvcHJ9L
X-Gm-Gg: AYBFou2c3KwEa8gxQFVxt/yBY4YAel9linVsnyEhZPLTShHcB9OPRaeCbp2FMEf46jJ
	OwtZpUrhJJEe5NJNg1rvzCl1R83Yk6ju6bxIaDC93HxAkSMhtn/yX06xPePkqWPq71aYwV3RaZW
	wa+j+w1ZxturfxzGyaqahNgMUtvRKsEhp/GrEGgp5PZivi/zLOp+qFRfirNq7a583j3AjAd2680
	hkl+busGb6AOdH/gli7ohhKOyQ7ljeJXGcqdr4UwGkniqmaFzr1++MLV460zEjjtik8B3Os1nw0
	A8c6QFVG3XPQvCIkuSCY+jdBU6a/eZeSzDikwmhsvdTiJs3pwujelVZDXkMXmht6Q1yEVPz+Qlc
	QEqOFjvIIwKRSVDLpJ974oMpCa7wT4eGa+ZOm6iFbjkHjW/rPYbxLDkVMTsepuZomb3O9ULWt4s
	q9xmoCmCDqwUAi6/ux5l/DXny0PohjEEuwdD4VrnU9MOOzhT2KRiQcYiN7ZJx5mY9lLZSch34K/
	6H656j3BD/+yQTO6+6wD86SRXsLaKwLWlNlrNhKCcOjPbibp9Uw0cfM8JhrTThxD8c86ot9cJir
	5MG847bg/m2/Ksl58mxbDj6yXeyTHHl987lyB7PtMMsldqcERiAf9w2OsoHJ6iPDfkBpOVnvgMf
	Z
X-Received: by 2002:a17:90b:4acf:b0:3a0:f2c8:9ad6 with SMTP id 98e67ed59e1d1-3a0f2c89d98mr6052076a91.64.1790643805183;
        Mon, 28 Sep 2026 18:03:25 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4985ff0f2sm2052278a91.8.2026.09.28.18.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:03:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:03:18 +0900
Message-ID: <m2zex03m3t.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v3 2/3] selftests: run tests on nommu architecture
In-Reply-To: <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
References: <20260926010819.604346-1-thehajime@gmail.com>
	<20260926010819.604346-3-thehajime@gmail.com>
	<04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_180326_854551_1CEBD3C4 
X-CRM114-Status: GOOD (  12.25  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


On Mon, 28 Sep 2026 16:44:49 +0900,
Johannes Berg wrote:
> 
> On Sat, 2026-09-26 at 10:08 +0900, Hajime Tazaki wrote:
> > Architectures lacks MMU doesn't support fork(2) syscall and only
> 
> nit: Architectures lacking MMU don't support the fork(2) syscall ...

ah, thanks.  will fix this line.

> Not sure where this should be merged? I guess selftests would make most
> sense, but you can't actually test it out before the UML nommu changes,
> so that doesn't work too well right now?

I think this can be used for other NOMMU architecture (riscv, arm,
m68k) if those are properly build so, it isn't intended for UML only
tests.


-- Hajime


