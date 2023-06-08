Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC06CC7EE45
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UML8h5O2z3O+JsvV9eYFHHAW8xW5xKd47xLX2aGhag4=; b=txX+XHuWjGxbWY
	CdKeIjfF5B7faiOk9A/BJ3/6I0/SXlKIN/vYG5fJAesh3WRyU/vQEjKV++TJIxUHVP4s+b5Us/H2v
	bbA+9Q2lfnWrvYPWrE1Ree69WNDUqQo196J4kAAvht6pQFleOZsfSXL8mdnevH3Ls63Xp/KVCkHFd
	cHpQSrfqYNMv0Ewvgf1ESvhnBQY2qcn3qmTtkta60XiiDwfxPzhs/Lo5rr9lm4a+prvlDSAuSX7U0
	1Ouph1ffznqDGViDcZSqS6TmdyH3KEf1OSiMEoYCW4Ywd9e3tUAFZxjtN8aCtIq8wqYS4dtNt2CJj
	PRB8b5gdDIa9vIjYGMrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7CBw-008jB3-0d;
	Thu, 08 Jun 2023 09:44:28 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7CBs-008j9X-2I
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 09:44:25 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso285745f8f.0
        for <linux-um@lists.infradead.org>; Thu, 08 Jun 2023 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686217463; x=1688809463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UW1P1+u4z8C1yYHhcCc7D6z205h5xRpA4Pis0U9UMY=;
        b=yaY1SeETpr1491wAArwoEz9AJZvZ5z5Oelfq8FTwZjv5Pt/tYo5/JbhJmlnsdXccgT
         rV+izm1qoxfwqsvCOevTNpa9AXiPp34leL/teWpFI8DnWj2gT9oTkJf5RM1JedYJsqOR
         dOTz2gvKJANj4eEOoND3rs/e3YQmKzzRMznHOfQHFfxuyaer9zt098pnWbKtUtWgrjpL
         rngkJTI/oyNl1h5w6WjYslic/vZHxQYsDYNvUly4Suef2mFO3KaGuI4pOX3o87LWbC1v
         fP5qRuJh7sd0u5OqO4m/B3exo8izpU2YK4CbQWdtPhbZm6I3/7vshaMygPH9B4aEMU3h
         0vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217463; x=1688809463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UW1P1+u4z8C1yYHhcCc7D6z205h5xRpA4Pis0U9UMY=;
        b=f/3lEfF2yp19gyUHYAUbuzjOS3rRHHfw2roSyjAEuGjUXvJlIGvXZVgkCVI/uuTedF
         sunGoqyIBfakytPLkOh8eN6cJmG/Zmi7dIqIKYThQyJz4UWI8jXQjwTWxDKZwyfRfaIt
         QLlwGyCKkPDQoXShrIo6Bw+WLQZYERDbupvwCdk4pl/ixjTkwFQ1QCpRay9ZAM/+XD9R
         qtzXcwNX08v5JCn+Of+OmbBfzWznEWpWKf5z9kwKzqjj5cjqsfQhb2wJR35HyYMI0Cni
         +9HqD+nM8MXLWwFfEN95Wo0p2wmF4T9Kev6iLagu1oop+I9p4hlVcapei9tJBEApheaM
         Y2Qg==
X-Gm-Message-State: AC+VfDypjWrhTf+Tn1FqhErQMuOk1faY4xvCwePfCNAEUGJPDLhjmNr0
	Cvq/h5N7RO1+FMFM9/67PorY1w==
X-Google-Smtp-Source: ACHHUZ55+QiuKZDDVF2xerotwpMLkKmO7qQkxSxt7AJ+yBOXmT5EW03OqeXuJJ7vWtahwa0aPclqwA==
X-Received: by 2002:adf:e60c:0:b0:30a:e3da:efe5 with SMTP id p12-20020adfe60c000000b0030ae3daefe5mr6178509wrm.32.1686217463182;
        Thu, 08 Jun 2023 02:44:23 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b00307bc4e39e5sm1027878wrs.117.2023.06.08.02.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:44:22 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:44:20 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <ZIGi9GMGeKruSrrW@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
 <ZH+6qd1W75G49P7p@equinox>
 <20230608084129.GA14689@lst.de>
 <ZIGVn9E9ME26V0Gn@equinox>
 <20230608090444.GA15075@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230608090444.GA15075@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_024424_751960_1CFA1C26 
X-CRM114-Status: GOOD (  18.04  )
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

On Thu, Jun 08, 2023 at 11:04:44AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 08, 2023 at 09:47:27AM +0100, Phillip Potter wrote:
> > Yes indeed - I was under the impression it was appropriate for a
> > maintainer to signal their approval of a patch to maintained code using
> > a Signed-off-by tag due to their involvement in the submission process?
> > Apologies if I've got this wrong, happy to send Reviewed-bys by all
> > means.
> 
> Signed-off-by is for the chain that the patches pass through.  You add
> it when you apply or forward the patch.  Just give me a Reviewed-by
> tag and say it shold apply to patches 1 to 6 and I'll add it.

Thanks for the guidance. Please apply the following to the block patch
(1) and the CD-ROM patches (2-6) of your series, all looks good to me:

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
