Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FEC636CD
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsBGFv7/2ydZEOkBg6eGvL3+vE+CvqROkK/13fVrQcw=; b=y7GS6zZyH1T5JW
	T7pW9mpifvFvHfH79Q2nRvlrv5y0rbhaNhItVjuY85/Akwz89qXGJ4dpSAeE6BxWvuMEkyzaGDw8g
	k8Pihjl7OJtu1ur3xy6oG1OsWrFUfMYCpwA2CC8dwJQ/8fbHygpieIXZ1LceZFCmkDZYo6c3pgmYe
	7HWsru7Lwor+Kl1JnQNblPA5YiVZsWW/oYgTgwXOF20jybXDPmIrpJJmzoOzze0CaTkcmedPezcWC
	KbzwPtcXlchsYDzOD0txCogdY1KsWH2HaYENyvNKzZ4uuD2oLxYRVzJdADypj2sxwGjH9TerEQxff
	9lMvBHFtzbDkFrHGVrMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMnwU-007R6M-Lj; Tue, 31 Jan 2023 10:32:46 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMnJf-0079me-1c
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 09:52:40 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1pMnJU-006txR-HK; Tue, 31 Jan 2023 09:52:30 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1pMnJR-00BDtr-Ol; Tue, 31 Jan 2023 09:52:28 +0000
Message-ID: <0edb046c-16de-cd18-2b13-4ac7e0b084b3@kot-begemot.co.uk>
Date: Tue, 31 Jan 2023 09:52:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Using ftrace
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>
Cc: Glenn Washburn <development@efficientek.com>,
 linux-um <linux-um@lists.infradead.org>
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
 <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
 <1215849138.84344.1675149765214.JavaMail.zimbra@nod.at>
 <98f7e8b52dbb222f4d959d5440e27b4257005b93.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <98f7e8b52dbb222f4d959d5440e27b4257005b93.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_015239_120041_295F8282 
X-CRM114-Status: UNSURE (   8.51  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


On 31/01/2023 09:10, Johannes Berg wrote:
> On Tue, 2023-01-31 at 08:22 +0100, Richard Weinberger wrote:
>> Adding function (and function graph) tracing to UML is possible but a bit of work.
>> You need to find a way to implement all of ftraces mcount hooks for UML.
>>
> It feels like it shouldn't be that hard, but I coincidentally looked a
> few days ago and got scared :)
Isn't that nearly always the case with UML?
>
> johannes
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
