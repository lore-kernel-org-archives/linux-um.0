Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D87FAD3E7
	for <linux-um@archiver.kernel.org>; Thu, 23 Apr 2026 03:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:References:In-Reply-To
	:Content-Type:Mime-Version:Subject:From:Content-Transfer-Encoding:Message-Id:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eq2FI4p8/MBsA/db9756DLjX4O4PFQlEacvTm6wyehg=; b=yfdZiC1KrQfIQ7YMbKHtW7rcaK
	q2/iY6jrXgCDALmZi3+kTDWIPkMZZ8xydlPUROQFefY3VS2dVG90A7WJvyX1H7AGiSbJe3JfOXVlb
	Bf9MrO3uw9JrJk1Xq9mLLVXAUDxZ0ajuN3plOnwivDvU5wXiSzSqwhqXrG1ftN3TxiREF9K7D6cUA
	hjKI0b+x1trYqz1P5Q1OYXY4bg/VcKCGL+3GLdv8J29mRjgqv2LXO0lh2J67Ay94BLM/nmgOoGxQO
	7RpIEU9BcEZIurPqNmk/1A5EY+2JthE+A7nQdyK4syngvWTS2ALvSs+6GCMNZkAZSBRQEL0x0pMyq
	1ziPKVww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFkkS-0000000AyxK-25LP;
	Thu, 23 Apr 2026 03:29:04 +0000
Received: from va-2-39.ptr.blmpb.com ([209.127.231.39])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFkkQ-0000000AywW-0Z8I
	for linux-um@lists.infradead.org;
	Thu, 23 Apr 2026 03:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1776914933; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Eq2FI4p8/MBsA/db9756DLjX4O4PFQlEacvTm6wyehg=;
 b=VpQ9qT89fDj2QbY5NNxhqIZ3lKfTUvV7KlEpVpeSXya2Int8Fo6Tw0gz0QMflZ1qTi/fb9
 0J9QLFhj4mV0lMT/oequvOYSlPL4Q1zGxmJfuE0rGw/vOgX0kQsltGhHzpv7vmSQWCkNoR
 FXUanT6K/3heuYzmwuEu7xajQr7zukrBNWXLr+480rzSRZMUMrbgYAjz3iTBwXNd3v18/C
 U4VSMAG/OOnXWRVmsl0gAzIMQ4mvD11e/djx5M62DOskM0RI75DaC2a+HZ5GZ2emgmwHap
 3iWn8w6sOr3pWhxYufPj6YanZ3WYbVpafC4h4aM3nAort1LNNpZRO82aIWUC/g==
Date: Thu, 23 Apr 2026 11:28:45 +0800
Message-Id: <aemR7Ur4H9dnKQ57@pve.cherr>
Received: from pve.cherr ([111.42.148.84]) by smtp.feishu.cn with ESMTPS; Thu, 23 Apr 2026 11:28:48 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+269e991f2+26f70f+lists.infradead.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH] um: proc/exitcode: fix simple_strtol() out-of-bounds read
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260422214507.0078c8ba@pumpkin>
References: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc> <20260422214507.0078c8ba@pumpkin>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Richard Weinberger" <richard@nod.at>, 
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>, 
	"Dan Carpenter" <error27@gmail.com>, 
	"Andrew Morton" <akpm@linux-foundation.org>, 
	"Jeff Dike" <jdike@addtoit.com>, "Yao Zi" <me@ziyao.cc>, 
	<linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_202902_254154_F73C6BDA 
X-CRM114-Status: UNSURE (   9.87  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2026-04-22 21:45, David Laight wrote:
> On Thu, 23 Apr 2026 01:39:25 +0800
> "Shengzhuo Wei" <me@cherr.cc> wrote:
> 
> > The stack buffer 'buf' is declared as char[sizeof("nnnnn\0")] (7 bytes)
> > and the copy size is min(count, sizeof(buf)).  When a user writes 7 or
> > more bytes, copy_from_user fills all 7 bytes without a NUL terminator.
> > The subsequent call to simple_strtol() expects a NUL-terminated string
> > and will read past the end of buf on the stack.
> 
> You should probably also mention that write(, "123", 3) will lead to
> buf[3] being read - which is uninitialised stack.
> 
> 	David

Thanks for the review, will fix in v2.

Best regards

