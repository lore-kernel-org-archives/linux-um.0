Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00677D0C5F4
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RKObska7+GUjR7ZNPlzOvxg6ZN9EWC2LgOs8FAxb4PQ=; b=I1PBSeFsmraYzqT02WIZdk7E5v
	nQz0RK5cNsAK9pzbqpZhnZ8QEdtjp0dsJPH8dGgqG37vy3odprbVUPp8gCdX6meGw6HTdH/sXq5zK
	c4kgfp10Q800tmlV7/isxFaRZNGXqcrbTUZLtVLktuvTPk8+Wadw5rg3+xv6Z2tUIVmivGs7lZ179
	MkZ9zNwl40SSJTrKA1dZN6A5L/bd30CUbprJ41qzoWC/DKG3V4MU5agbSxYLUrwjm+zv1gg9fJs/y
	typKlUysM12RPRZy6krRzWPQoiNNcfKTXlZbQVTVq1sJB3plhRUz6a6hxQpFOWgPe4nO67pjIL4xo
	IbpScSqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Gdb-00000003Auc-2SQ8;
	Fri, 25 Oct 2024 09:29:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Gd4-00000003ArT-19G8
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RKObska7+GUjR7ZNPlzOvxg6ZN9EWC2LgOs8FAxb4PQ=;
	t=1729848550; x=1731058150; b=UAu1WMANElEnKVLyuOKdvl9HWynXAS28RM8Fnt+TL34yJr0
	JnnZmy5WLmMsHDa564ZVQMDyr+xjZrn2rXbzygK6v0AAFTGQBqnxG1PCsPg4BQNRFwvmo7UrOvCzs
	6d/0SKtWvRM57nWMAsBEU5I1bN99AaRGyzhrfWU9Ptr5BJwFCziLk7fbfeG3s1HzU5Yc9hX5w7Vg3
	mrl0oQTb8ZlBKI5Ga5uwizLudRHIjRwLrqgnm5vmZsT3kZnRwyG/+xAQsVZQcjd8ixRC5jIHX4j+I
	FN8IiuxA0ISG4VVxl+0khwk6yfbujDyDBASKrhx8JrfMifRVLtpcHaGvIbQRWxMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Gd2-00000004Slq-0Vn3;
	Fri, 25 Oct 2024 11:29:08 +0200
Message-ID: <94caed762cad1f49c9ad31957ca2990179567e7f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 08/13] x86/um/vdso: nommu: vdso memory update
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:29:07 +0200
In-Reply-To: <18e83579370620b2b35d35b4ca1b7609d20fb8d3.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <18e83579370620b2b35d35b4ca1b7609d20fb8d3.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_022910_339330_35B82F1C 
X-CRM114-Status: UNSURE (   3.36  )
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


>  oom:
> -	printk(KERN_ERR "Cannot allocate vdso\n");
> +	pr_err("Cannot allocate vdso");

kind of unrelated change

johannes

