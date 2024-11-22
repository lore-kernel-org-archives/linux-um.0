Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7986AD75E32
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tfIeBq+tuOflX4ksZA/x+0iCc/nSAYnurOOzuWjvZwM=; b=xfqiwJ4J3x/abWRQU7+euWuL0C
	ggNje9WtgCRak2QPprlSgniAUUE7D4zjBqx0dVsqstVe/2N/zqyhhBUe9+z91IspcjNIpuT/0dB5s
	lNQLns8RLZzB3OStuETHAbefybbt9kGNWuiumizYtSv5XKbODIuqW8W6upt58sNzRJ37k58lTw+xr
	QqQOYX57XRTWxcOsaFUu1Civ+N4rx+stTW3hVdrP91gRGNYmrnzs30t9PRVGzUROR2Nq/zr2tN7Oz
	YXtwWRj3gYIsCbAIpCjLLs6L8SVPPpeQhvP0oUseaa+zCeLl+5s7v1PI43lfSoUsn17fIXl9S+7tu
	CHN2gIoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEScL-00000002RHm-0HMP;
	Fri, 22 Nov 2024 12:18:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEScI-00000002RG1-2Of7
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 12:18:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92EBF68D16; Fri, 22 Nov 2024 13:18:26 +0100 (CET)
Date: Fri, 22 Nov 2024 13:18:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
	ricarkol@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	linux-mm@kvack.org, Jann Horn <jannh@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Message-ID: <20241122121826.GA26024@lst.de>
References: <cover.1729770373.git.thehajime@gmail.com> <cover.1731290567.git.thehajime@gmail.com> <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local> <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_041830_748878_A385345C 
X-CRM114-Status: GOOD (  10.70  )
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

Maybe I'm missing something, but where does this discussion about
killing nommu even come from?  Nommu is a long standing and reasonable
well maintained part of the kernel, why would anyone want to kill it
for no good reason?  I know quite a lot of products shipping it.

Btw, nommu UML certainly sounds interesting to me, at least indirectly.
I have a project for next year or so for which the linux kernel library
or something like it would be useful to run an in-kernel workload as
a user space process if needed.  nommu uml sounds like a really good
base for that as there basically won't be any userspace that needs
memory protection to start with.


