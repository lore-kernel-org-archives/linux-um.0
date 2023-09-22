Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95DCD4F2E
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1UUSqe97/xqiC7rCDVzE697uQxH0qA8a7A8QGls6IwM=; b=QN1SdMV4upyAcz
	vpWtq5q7XvYOURJk/lT0ngIgkLb0x3sEdXhlveD3pSw6DYvEzJ1hrXqu1OPZ5CV0n33zdx5n0VPjj
	FXFr9NJe04wpbustqjd4jd43jfYAzDgu3H/9f1R82iEkSiqdHd1F4jD0DBrPuH57Rv96e8GHaKKKR
	deEFnJaX2blF1SazqCDDB06N+htqw2oBmnaurQG6DkdU1rEJUtTsSzXdR9RwXbdXyZuodoEr1d01i
	5uW4KLaCdYq1RTSbq34p+CDuQo+jwIzLwdWEUwFn8bG64MH/jUnochvZZrp+NFwKP71Us26taK9be
	IIIR2fPtKd4lDhdUul0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbI5-008NXx-38;
	Fri, 22 Sep 2023 08:13:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbI3-008NX8-1Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 08:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+jnqm4ARYW24BKotIWQq98QO6Z5xBY/V/fQ6pCw/rUU=;
	t=1695370411; x=1696580011; b=jqkMGOdMbFZQWMViksVRiB06Vedz2o5L9IAbyX43vaHW/cK
	NeaFX8PXsHVegd5+5mGhXGBtCuqK2E/11Q3Eh2sVY3O9KgFrXANK/ptfMDs6ivU5p6oxaXV7O94KR
	GCQYLv2rOHw2CmAJRmAZw+YFFi6qd4ERBcz1jUgM4sEW2r00jg6ssByewy/SnYuyhCYTPAImKxb4Y
	LZEYj+DHPX7/CaSNuzr6DOExra+Ki1pPzpnKfvuJ18eTeU9UWjIsl9aoWGmpIlmnI6/UwrU39ElDx
	TkTPkHsZuKUEE8MqNJYeLY5o9lVUYjkeJwNi1nIRfOj6zSeDZEokJN3ZFEOcE/Hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjbI1-00F29A-13;
	Fri, 22 Sep 2023 10:13:29 +0200
Message-ID: <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 10:13:28 +0200
In-Reply-To: <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_011331_525448_536C7ADA 
X-CRM114-Status: UNSURE (   9.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2023-09-22 at 09:01 +0100, Anton Ivanov wrote:
> 
> My favorite test which I run on all changes is:
> 
> find /usr -type f -exec cat {} > /dev/null \;
> 
> On Debian this forks /bin/cat for each file and does IO on it. That test passes here every time :(

Oh, apart from the splat, it all _works_ fine.

> However, I did not have debug turned on. So, I would not be surprised if something in the debug

OK.

> portion of the config makes the crashes more likely.

It's just a debug warning for me, no real crash.

> Otherwise, each fork is a forced tlb_flush_all, so it is a massive tlb exercise. Any bugs, locking, etc are likely to show up.
> 

Yes, but when does the fork actually happen?

That part confuses me - the fork_handler() seems to be called at various
kind of random points in time after?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
