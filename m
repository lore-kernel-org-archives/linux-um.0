Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9F3CD3423
	for <linux-um@archiver.kernel.org>; Sat,  2 May 2026 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vkdJUl9byqmgdH4ISrrSUbw86t4D/yEgNaaTqWmyKRE=; b=jMxFc0a7Inx64FGtpgP7KRg2jY
	NjX3yP0P3yB0cbuVdl32h/+Y5sxwPeYjBvZ71AR1UhR6MXgvp2y5QzZLGoZuV/pyUxS2AQbNdaiyL
	VCtmTWn5X0JX29Bal0E8GT+gqkHiBO78QcM4r3gmKGk3a7m8Fbi9SzBBelj4ZgeuXqVLbJNmcTJge
	xoIqGE6mcVltAGvL9T8dX7AkP16QK8EUt48BHKAZKvMVx96FgXTHX+VgtzmbOmJ0ds84eY2ofChpj
	Bwi+3q7ml2COBTNGZFGjoMhqgS8xezhwnSsmoWYd5/QqhLAVXuOWfK7xg+2WUcr8aF/xIeq1lEV8m
	xt9yb0AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJB8e-000000098rh-2Ryg;
	Sat, 02 May 2026 14:16:12 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJB8b-000000098r3-2Ijg
	for linux-um@lists.infradead.org;
	Sat, 02 May 2026 14:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vkdJUl9byqmgdH4ISrrSUbw86t4D/yEgNaaTqWmyKRE=; b=Ae
	dyKaSRwo8iamjOkvzOLPx0wAtoj63h4rJf+NDQ+B4HrTfC1iaJUoZelsMWgFb216+JISuUJ1Sy2f5
	0hwh7a0gDKqfiRJSg5x+Exg/Ps76LJ0e1KrwEAdaN4yWGrnuxD/NWJsjtb0S1vIV0yO3ERDdUJGaX
	7cE11VZbDlHywBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJB8T-0011Vh-Ph; Sat, 02 May 2026 16:16:01 +0200
Date: Sat, 2 May 2026 16:16:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wang Zihan <3772548978@qq.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, linux-um@lists.infradead.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, mchehab@kernel.org, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix duplicated words
Message-ID: <918f7cdc-c0bc-4cbb-8385-ca0ddb2180c1@lunn.ch>
References: <tencent_B1D6CBBF95486E31D04C2E1B92F5E605A307@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B1D6CBBF95486E31D04C2E1B92F5E605A307@qq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260502_071609_613074_3048DC98 
X-CRM114-Status: UNSURE (   7.40  )
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

On Sat, May 02, 2026 at 07:19:16PM +0800, Wang Zihan wrote:
> Remove duplicated words in three documentation files:
> - "in in" -> "in" (switchdev.rst)
> - "The the" -> "The" (dmx-reqbufs.rst)
> - "on on" -> "on" (user_mode_linux_howto_v2.rst)

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

* don’t repost your patches within one 24h period

We have already told you one of the fixes is wrong, but you did not
wait 24 hours, so have not see our feedback.

Also, in general when using a tool, assume it is wrong, and convince
yourself it is correct, before making a change. "The the in this
sentence is the subject." What does the bot make of that? Can you
convince yourself the bot is correct?

    Andrew

---
pw-bot: cr

