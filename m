Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E650C25B75
	for <linux-um@archiver.kernel.org>; Thu, 23 May 2024 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KvJPlzstfT6/U4tjXdaE8p4ykHzflFZIf4papy00MWc=; b=sGiH8AQlyB+XbvV2PGf8gGYTx0
	K7Ns4Bc+x3P7+0I91wTo4zRZOATU62/fTCjBcE7Tght281w1aEs0hRpzfPoIybD6WX+Y6by1n/tte
	j+rkFk3Ol2WyEElQWDJDMn2o6DYMQRiaqsWUEv6Lnd0E+1DcFK9epkappqi5VWknsslhs0Ufp69au
	S36ZAgca0Ek7CSK8RwlgfesDPFY4cGc1MUAcniRdoQVCP1pYISsWEjRtO6FY/UyJTHuk3kbqpe7Dm
	jQ3WK2LMxPwm2tPa7bzdwiAJxG3d1tzNpH0+9Mw+w42VDq3VaBYpknCJnxjvKvgq6wm25Q2OjMu0y
	AiwC8Xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA5Z-00000006bp8-2Br3;
	Thu, 23 May 2024 15:10:41 +0000
Received: from mx.treblig.org ([2a00:1098:5b::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA5W-00000006bmo-0jZm
	for linux-um@lists.infradead.org;
	Thu, 23 May 2024 15:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=KvJPlzstfT6/U4tjXdaE8p4ykHzflFZIf4papy00MWc=; b=mldHXJ7D0RcTWYGQ
	XzTbqT3nMvYKn6lFHrKyrhVeu12iw2fB2TKclPAqx8znrZIA6k4oYvGFgT9PNGBgRkgave+5HAaah
	JowTkYco+GNq7QjzqLkDwDnYPn1syUoqPKEjtpcQbYk6Bvu/WwM5WuM8OcCTMws3vta6uJKabcR3X
	ip07TjwEMOTw+d4jbgxh/dmN4Aer7nT1nV+ZPeEwNfU9QGZF5OMx3e/qLb0LVoPKf96n11H3rOwei
	WHbVCyfZ1axpZjKQySGfmtjKUCI+bP8mWrY4JdTVkdIbWomN9kv4kO1R2sgY3bjS0z6MRKV8SJMS4
	OSatCmS1rp+SLOZ80w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sAA5N-002FNU-2I;
	Thu, 23 May 2024 15:10:29 +0000
Date: Thu, 23 May 2024 15:10:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <Zk9cZdjhR4983Wpz@gallifrey>
References: <20240505001508.255096-1-linux@treblig.org>
 <20240506070648.GA6506@lst.de>
 <ZktoVIG500he350_@gallifrey>
 <20240520152049.GB398@lst.de>
 <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:10:09 up 15 days,  2:24,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_081038_249270_7C7FFA6F 
X-CRM114-Status: GOOD (  10.67  )
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

* Richard Weinberger (richard@nod.at) wrote:
> ----- Ursprüngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > An: "Dr. David Alan Gilbert" <linux@treblig.org>
> > CC: "hch" <hch@lst.de>, "richard" <richard@nod.at>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > Gesendet: Montag, 20. Mai 2024 17:20:49
> > Betreff: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
> 
> > On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
> >> * Christoph Hellwig (hch@lst.de) wrote:
> >> > Looks good:
> >> > 
> >> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> 
> >> Thanks Christoph; any ideas who might take this?
> > 
> > Probably Richard who is alredy on Cc.
> 
> Yes, after the merge window.

Thanks; no rush, just trying to keep an eye on where each patch is
going.

Dave

> Thanks,
> //richard
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

