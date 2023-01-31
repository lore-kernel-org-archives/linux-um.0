Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB0C636CC
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I2m5FwFfLvYYthYEcnIjoe2GSS57v99Hv5f8bJdyz2w=; b=NjuuFGBj/nEJjI
	auqRHPsBcvJ3BnOutVAYQ0EAIUJ0FFb2aHVALB7FMhTQwWaRN/hJXlsbYAphQn99uv60XElzdDwmZ
	344m+gI9oKGyldt5RIs79fbxg7yIe22F2jGtUoCEpC1pTRug0TdTUhX+2mEFmfTG+MkwA5WAYZdGq
	2ui9M/dLArNAcFXcChbpSgcSZ8GoNLsvC08AQr4ZZMwCRdLWwZVcvw8MaVC0RgicktVGF2gVqXme4
	LwL6C5zNUD3FtZQ+xP2u5/0oF7Yys+0BgvcRhqWyBVilqlHsWc67MPw/ya2BooUSlOencpRBLoohy
	/xqzoa5STV/KIviRhoaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmfW-006vFO-GT; Tue, 31 Jan 2023 09:11:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmfP-006vBs-Ly
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 09:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QoRU9wuNEqrYy5fjccmOeWm7SjA1+xyzqT7O6c1Shj0=;
	t=1675156260; x=1676365860; b=MPcbUHB01pJeJfJgLzXARUG7PyGTin2s/omYpVJeqxXnnG8
	QbgDAxt0DlS9NCIouP2laXBlFfL+KMWZE5N180eRwoz07o26T4HX4FvWRn3jJN9ckEaXSX6CmRm5f
	MDHXzhCJ3bVuZEHIYuDjQ389mpMUKBa2DCqc1Y3DoKEyYGulaAgmNPwbYecDmHOSmWQx+ND9pg8jh
	OZ/0AXkvlEa8hHW7D48g30yqC0Uxd6jZ54yoNtPenGT8cCioM7XZWR4ReKb1OKDqlr6wKL/2uqxKL
	Ol9a4xa0rk67Z/u7VqhOLzwSKJs8SX97YCmJtL4j+XkoCmat49m6jwMFLUY47JiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pMmfG-00GujO-2o;
	Tue, 31 Jan 2023 10:10:55 +0100
Message-ID: <98f7e8b52dbb222f4d959d5440e27b4257005b93.camel@sipsolutions.net>
Subject: Re: Using ftrace
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@kot-begemot.co.uk>
Cc: Glenn Washburn <development@efficientek.com>, linux-um
	 <linux-um@lists.infradead.org>
Date: Tue, 31 Jan 2023 10:10:53 +0100
In-Reply-To: <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
	 <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
	 <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_011103_743040_6DE727C6 
X-CRM114-Status: UNSURE (   6.45  )
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

On Tue, 2023-01-31 at 08:22 +0100, Richard Weinberger wrote:
> 
> Adding function (and function graph) tracing to UML is possible but a bit of work.
> You need to find a way to implement all of ftraces mcount hooks for UML.
> 

It feels like it shouldn't be that hard, but I coincidentally looked a
few days ago and got scared :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
