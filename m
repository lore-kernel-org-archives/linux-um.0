Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987AFC04FFE
	for <linux-um@archiver.kernel.org>; Mon, 20 May 2024 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zAi31vd3hZsjgopIAPbpcIqf2rKl76gQoa8HWS+T4+M=; b=pOjxLJwMUzRe9euB1AthoSTjXP
	WmoWx5RvmehQ1d4Qm5qNg0YvTeZkYxc6kz0uVptGDm+7QAJH2Pwki4q1nwsr/9/tY1KTzQVerq+Yv
	fzIvMZJDI0PDX0fyvgzBLoW4lal3LRQwV0YzRBHinU+mCQ/QU6kLccIsvIikgbyM53chyFP/Bwuhy
	BNhxw+6R1ycsXBGfhMbNikRVjHDFAiq0kqfdBfGRxZZhG/y9ytZ2FBOaJZw9pwXPUhghVINV22gjS
	d0uBifFEGa1JKkIsu0/V0CStpQuSKAr8h4LDwae1fOJhGDySzGqzQsbeQHg4rpaKCqDoVSDrPBHsD
	wmOOOAgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94gk-0000000EoDo-1p9I;
	Mon, 20 May 2024 15:12:34 +0000
Received: from mx.treblig.org ([2a00:1098:5b::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94gh-0000000EoCU-1k4n
	for linux-um@lists.infradead.org;
	Mon, 20 May 2024 15:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=zAi31vd3hZsjgopIAPbpcIqf2rKl76gQoa8HWS+T4+M=; b=jQSzeDNxJNOxqsAm
	wmjBPSDqRLBGyfpQHouFqHKGxtovWvypk32AqSyuo3Pl9ABZuxxG83VnaZpDWWLM+Sfb72s5pzHRq
	ujf1lUvRHTx8lU2JTZytag7BuZlTp6M9K5IA5pvQpcqLoJDY6q1LtDCRIycvH6cMrcQ0X0UqWmCkl
	f/zJuI20ldF1XP1TJi83ZBS0zDmXnX3Qh9zajk8kmFKdLEYYOTYIDpn5ukNkjez5DPeWmxZigI3yy
	VlmDqc9Hrw6HGzVxg77QoTH7zfPKm3iJIw7dO6JUhEVJzHoUvqOND5OpYHxHND5WEQnPKSzlBy7mP
	zbfQt7hPVVqq7qoCFg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s94gW-001hiO-35;
	Mon, 20 May 2024 15:12:20 +0000
Date: Mon, 20 May 2024 15:12:20 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@lst.de>
Cc: richard@nod.at, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <ZktoVIG500he350_@gallifrey>
References: <20240505001508.255096-1-linux@treblig.org>
 <20240506070648.GA6506@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240506070648.GA6506@lst.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:11:41 up 12 days,  2:25,  1 user,  load average: 0.07, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_081231_778592_7DF909F1 
X-CRM114-Status: UNSURE (   5.77  )
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

* Christoph Hellwig (hch@lst.de) wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph; any ideas who might take this?

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

