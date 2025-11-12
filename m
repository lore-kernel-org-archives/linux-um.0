Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA057CD13DD
	for <linux-um@archiver.kernel.org>; Wed, 12 Nov 2025 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuZkk1ecQ1y2YiIg61ZBzcctWSlR8+0B252L7V3ihsM=; b=c031XOdNxeiyKxdHi6byIKb8ca
	ycCah5KwO9FLvI5u3KKvO8PGlabIajXKm/OhPd5NXKmPrcj8g+L1pns5SF+VNtTQ2Lo3FuzNmLLCU
	ZwNKnepsB6Ldn6Gmn0ARnOFZYgq3kfnXKwQCxgS2CMjl9SgdXR90snUibyiU3R7ErvAJ8ilbvb+4W
	/M/+MXIRDjnZim+0ePm/C4BdKRmGNc7UNiI1/jxr0A5vkegHKXkSzYIN9fRUXdXZ8gMqM19bLg9Cp
	gb1stFsTMAEltllSCZ349dh5uJls861/z3UoFdkGxwPHghhzgvlxseXGOze3yquKrtw7Q3EK3VECK
	x+mcR64g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJDqq-00000009Bwz-2I7t;
	Wed, 12 Nov 2025 16:37:44 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJDqn-00000009Buv-2oF6
	for linux-um@lists.infradead.org;
	Wed, 12 Nov 2025 16:37:43 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762965441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IuZkk1ecQ1y2YiIg61ZBzcctWSlR8+0B252L7V3ihsM=;
	b=Wh0PCCqE3a6g2qnRUMXZ1g3BIMxO6mZ6y7v4sB2g+UnJbZBfkGUQ7BmVF9gblYKJEFO0LK
	dkimfm3eG5fmJkuCNVSDL6U/VcZGlbifE4w5cwBp7d9r1g3Oa8628++g3z/VT9AgZtP6Hv
	ZuhetIod+UxQ7KziDDdDSBYYdCb7ncg=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: thehajime@gmail.com
Cc: Liam.Howlett@oracle.com,
	hch@infradead.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v13 00/13] nommu UML
Date: Thu, 13 Nov 2025 00:36:51 +0800
Message-Id: <20251112163651.3689244-1-tiwei.bie@linux.dev>
In-Reply-To: <m2bjl7y6mv.wl-thehajime@gmail.com>
References: <m2bjl7y6mv.wl-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_083741_922108_40BC8B5D 
X-CRM114-Status: GOOD (  12.86  )
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

On Wed, 12 Nov 2025 17:52:56 +0900, Hajime Tazaki wrote:
[...]
> > However, I'm not yet convinced that all of the complexities presented in
> > this patchset (such as completely separate seccomp implementation) are
> > actually necessary in support of _just_ the second bullet. These seem to
> > me like design choices necessary to support the _first_ bullet [1].
> 
> separate seccomp implementation is indeed needed due to the design
> choice we made, to use a single process to host a (um) userspace.  I
> think there is no reason to unify the seccomp part because the
> signal handlers and filter installation do the different jobs.
> 
> I don't see why you see this as a _complexity_, as functionally both
> seccomp handling don't interfere each other.  we have prepared
> separate sub-directories for nommu to avoid unnecessary if/else
> clauses in .c/.h files.

I have the same concern about the complexities introduced by this
patch set. The new processing paths it introduces (such as the
separate handling for FP/SSE/AVX, FS, signal, syscall, ...) add a
lot of unnecessary complexities. I think Johannes's suggestion is
a great idea.

> we haven't seen any functional regressions
> since this RFC version (which was 6.12 kernel).

I took a quick look at the code. It appears that patch 02/13 will
break the mmu build when UML_TIME_TRAVEL_SUPPORT is enabled.

Regards,
Tiwei

