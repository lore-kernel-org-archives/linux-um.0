Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D6ACA5FA6
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dNDAcGHNy09VRA5c5vXMv5G1dwyTJJ5okykDl+SczM8=; b=GLJ2K7yHq2LuyG+mfuBhosdIiA
	Upd5+hJgOVCKNZf1j9erPh3mnQQfcGQoouY/G0jHpnQLoNXYWoBLYnbfSUBenUliSqQgmmeYeKgyV
	iFL8tjcQxGNlcwN4zb35Fzbnx+vizlyzkIkihzEjfHdXdKLEyLMEA6lkADk6ItHQ3lcmMkG8srznm
	RY9mqDB3qKhGshVoHLot+scELorvAfd75jqgqGYA14wmRGcBxY2p10+GHySjtozyEFYJ+gl22UDUJ
	5gq3nTWf+ZBhTuk6GFyamtEhvfLWRfrwxp3Hv1KGD8XXEkCosGLkc5q9bTFymNzMoAVaej4Y5rY2N
	yC+qopRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBE8M-00000001131-1vYa;
	Mon, 28 Sep 2026 16:23:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBE8L-0000000111q-2IPZ
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 16:23:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BC3A9601EF;
	Mon, 28 Sep 2026 16:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C8B1F0089A;
	Mon, 28 Sep 2026 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612596;
	bh=dNDAcGHNy09VRA5c5vXMv5G1dwyTJJ5okykDl+SczM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AdKe3PuzxBeIfMRzAElN7KJNlKqTeYxTv3RiLkw/Qz7zSVjL8rh3hz+brQG9Rl0bw
	 4FC4Y6iUVl8feOfDgHg3UMd8MhU6S6JawTo5suISocRvxaMFCN044OBdhh8q4QSPzm
	 +84ocNwkhgBfQ1aDLsOl181/6k8blbWN99FN7JDQx3AGzlJNTzWmITGFdRp4WIzIu4
	 jYZICQBD3DbSAThjkRuJHvNzQorEuRquCsQq8bHfEy+9Eo49vSzkuMj34fUFRYF0ow
	 SlysURxuHxAAvgD/PtsHtPh4xlw2nSGiLzbixrt35t5zyhNs9HZSuzvytQul8CXo5P
	 asQRSILi8GvMg==
Date: Mon, 28 Sep 2026 17:23:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, 
	liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, luto@amacapital.net, 
	brendan.jackman@linux.dev, david@kernel.org, liuhangbin@gmail.com, corbet@lwn.net, 
	kees@kernel.org, broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, 
	shuah@kernel.org, surenb@google.com, vbabka@kernel.org, wad@chromium.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	geert@linux-m68k.org, daniel@thingy.jp
Subject: Re: [PATCH v3 2/3] selftests: run tests on nommu architecture
Message-ID: <arqUVCrA0rC7-c0b@gremlin>
References: <20260926010819.604346-1-thehajime@gmail.com>
 <20260926010819.604346-3-thehajime@gmail.com>
 <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
 <arpIi5QBG1_MuZzJ@gremlin>
 <8dfc0ec9ed660e373451c96b6fcc352c35a6a004.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dfc0ec9ed660e373451c96b6fcc352c35a6a004.camel@sipsolutions.net>
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

On Mon, Sep 28, 2026 at 02:32:50PM +0200, Johannes Berg wrote:
> On Mon, 2026-09-28 at 12:00 +0100, Lorenzo Stoakes (ARM) wrote:
> > > Not sure where this should be merged? I guess selftests would make most
> > > sense, but you can't actually test it out before the UML nommu changes,
> > > so that doesn't work too well right now?
> >
> > I seem to recall Hajime saying he tested this on an actual nommu
> > device/virtualised equivalent so nommu UML isn't strictly necessary (though very
> > nice to have!)
>
> Oh, I don't recall, but I guess that's plausibe.
>
> > I think I saw something fly by that implied it might be coming in 7.4 is that
> > so? :)
>
> I did end up merging just about everything that was pending for
> uml/next, so if we don't forget to send a pull request in the merge
> window, or something equally catastrophic happens, yes ;-)

Awesome, thanks! :)

>
> Sorry for the delay. The onslaught of LLMs means priority is elsewhere,
> sadly.

Yeah understood, onslaught has reached all areas of the kernel it seems...

>
> johannes

--
Cheers, Lorenzo

