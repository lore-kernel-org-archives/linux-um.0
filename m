Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1353DCA5FD6
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0JwbUYYrULzWB47hYNIr342NMFY/RUwXnmibkziqko=; b=GPeB8FkBgycEZunByQw2n8mVEJ
	dYkw2SiSKH2AwFhNIUKKnpcQCz8gqTXCkRO2N/LOy5jKEhhedufBbyH0q/d05YKIY2lR8zkeVOkEj
	XoMyQ7PbgDo2tNDAOVwRfAdC4PUq1dsz3kovKp2tle9k8jPIVZgeElwOxMVD1Zjgr/28bcnVLUtFy
	30EqdUcYGJ+3z/GAoqPHT4uDkLZtT/zUfm5Kgki2QBC/4D6sAGd87+BtZ05vKWjufiwwfJFsjvvIK
	a2R+/geeWax5OY4E79dJRC5OSmYKpUIT2kMEBGlDHrHOsQE//l6kmVWwpSvBskpOML/b0WyuSkfpk
	mVSnETAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCTAt-0000000AWKG-2nwN;
	Fri, 02 Oct 2026 02:39:03 +0000
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCTAq-0000000AWJs-3O2U
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 02:39:02 +0000
Received: by mail-pj2-x0d.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso5439000a91.0
        for <linux-um@lists.infradead.org>; Thu, 01 Oct 2026 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790908739; x=1791513539; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W0JwbUYYrULzWB47hYNIr342NMFY/RUwXnmibkziqko=;
        b=ncsBkLmaGJruzDk4r5y6vGlxONS+wSHhJXLkyzjRkpxFeoLGIQ9GAiIpwtXsHOKF6u
         vXSA0Ff2NDKJj/zHdrOldNeXkxDlT9zXJDiySuYKU7slWDTYm+hKoK0zJ+6ZnaKWgkIs
         06+pO4ruMJyvXmxtEW2YvwjO/eKohjZB+HL1xMrjg+XAoRaVVSfwomHxKXr6iCRfvXQl
         Qf+EuaFGRs3FrezcGWY7Ior5+cMjOM/ajtxE3Qh5glHA6RpxL23wNgar4y6u0owZW7ij
         FS/jf7qrhbv/GOp4zOWaqlwlWRhYDVCMLA32EX2ryGW7HqJusPzGzkhwJQYZ9IxurhPZ
         5jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790908739; x=1791513539;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W0JwbUYYrULzWB47hYNIr342NMFY/RUwXnmibkziqko=;
        b=BcwXqy5pbxpvPHGb9lT9qM7kt/dqqBt490hL+9VZ3X7oxaTlzHBIrkaS6V8nMCo/CP
         YYxm4JnzK+wJOK9qalQrdEhXGIggaj798w+fSdYDlvDB1iwWGtZHLy3jWt3uGB8Wq22l
         Gr5LKdwzM0dbznMcEUMg2y7ImONoHy2Vld6nW6GpaCxP0IV1zxA+VlJ+DFjOjnWzMm0T
         BvZVQcqU8R7KHWQPk+pOXsI3keTsYEYB5zA3w/d7zv+BhkKoqOUitLy8JBCjkJ9JT2C1
         9xu1NhgvBMG7/4bCu5fYLVMJDACZfFlbwH3kyQq5tpfVL0QI0TbhOrRPkDqXtUuzRjpx
         xwyQ==
X-Forwarded-Encrypted: i=1; AKwUvBysJrh9nAOBDZe6kZ1mt+jE9otj1h9Mw7k/13C52VA36lHhOtgQ+ZDQqi83FIaXtMCyKPKDQjSuiQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLkxg6hY11r4LBoPyvfZ9utievJlYqnXnUwV8vV1rl+NJQFbUQD
	htM6wm0lPsWbJNuccNpAlBlGPHArUOrMaBMokSvUjAkQPbkb40gc9CGi
X-Gm-Gg: AYBFou3PV/cIfNrMwJV10OxXxDkgNUQe4Xe7lg0xla4sbl5l0GI9tUnWUYZJbvPt+UD
	2Jh0KJKmBvju3z6eMKH5IBHexZD5pFwVUdhYfZD/cBtyQjgLlGDlckMQMDmN2Gbob+6rWWD7M+k
	AMd+Tu44EHvHAwFbZp44SxkrBg4jVQ7wC8lc/EilhgguB9XbVgASA+O9kkzI99Rl2qI97T7xuga
	utEYeZjZ5EXHB/FApXRphtyfd3LlwsfII4aTlBQNp57X5UdfEteVS9Lkay36rdYe3FUrKdXrQ0Y
	/gmddEqnRYLpJwTJL9vdhrlBIOjK4eBFmH6eWF7eBsnsoV1G43IHcbelIGGHLn+rsMpd83fERB0
	lycN5RPwjWfMpWw8Z4Ip94TyiOAzWem5Hl+z0KjDwy7vG4bJm53wh3+/vXnqz9yU4AIN1uyQuKw
	ZeUgUIQ/mgfyAHecEkmixO4QyyRsqH9bRappF1JvuKymqZVIJYUfbKNam+kWKcRXe6JZsl0vRDc
	OMqrErvwLjOgUr1xBfS8wv8I2FCLqzZHP2LJAhx/tmY6gTPmHnbHds+RgN7nZLYeoKvmpOp6xCH
	xkKnRp5aA5C0j+iqCbDvOYG5CoMuv36T7Xh8SBGxhu+ciqDksQZW
X-Received: by 2002:a17:90b:4ecc:b0:3a0:ca1d:b40b with SMTP id 98e67ed59e1d1-3a6cec84dffmr1148635a91.50.1790908739319;
        Thu, 01 Oct 2026 19:38:59 -0700 (PDT)
Received: from mars.local.gmail.com ([240a:61:8063:c5f3:3cbb:dbfe:34ef:b37e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f46bc991sm6682074a91.4.2026.10.01.19.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 19:38:58 -0700 (PDT)
Date: Fri, 02 Oct 2026 11:38:51 +0900
Message-ID: <m2se2o3jyc.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: ljs@kernel.org,
	david@kernel.org,
	linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
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
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
In-Reply-To: <94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
References: <20260929235711.2287931-1-thehajime@gmail.com>
	<20260929235711.2287931-2-thehajime@gmail.com>
	<bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
	<ar4br2vW7yZGd3gt@gremlin>
	<94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_193900_857703_35CB9DD8 
X-CRM114-Status: GOOD (  17.13  )
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


David, Lorenzo, Johannes,

thanks for the comments and inputs.

On Thu, 01 Oct 2026 19:01:45 +0900,
Johannes Berg wrote:
> > >  $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=nommu
> > > >  $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=nommu
> > > >  $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p \
> > > >    -c nommu
> > > 
> > > Is there a way we could derive that from the environment in one of these cases?
> > 
> > I thought maybe uname could help but our LLM overlords tell me no.
> 
> Hajime originally wanted uname to indicate it, but that caused
> regressions elsewhere, so we dropped that commit. I guess we could put
> _something_ back?

systemd uses uname information and our (old) patch changing the format
triggered the regression.  thus, we dropped it.

> > It pointed at something though.
> > 
> > In fs/proc/meminfo.c:
> > 
> > #ifndef CONFIG_MMU
> > 	show_val_kb(m, "MmapCopy:       ",
> > 		    (unsigned long)atomic_long_read(&mmap_pages_allocated));
> > #endif
> > 
> > So MmapCopy in /proc/meminfo tells us definitively, weirdly enough.
> 
> Hyrum's law and all that, but I guess it's not highly likely to (want
> to) change :)

a runtime detection is nice.

scanning /proc/meminfo might be useful. although it requires to mount
procfs (we can actually skip procfs mount as it is optional) so, this
is not 100% portable.

checking ENOSYS like syscall(SYS_mprotect) might be useful but I
wasn't sure if this is always the case of NOMMU or not.

My original attempt was to use include/generated/autoconf.h; with that
we can omit environmental variable or command argument of NOMMU=1,
but gave up with handling standalone build/test case which might miss
the generated file (and complicate the patch only for the NOMMU
detection).

So, specifying NOMMU=1 is my previous, though dirty, conclusion.

-- Hajime


