Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB38C27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qOsdq+Rd2jD/oYTlQL4Vcr47c5ELyE1/1jwJx8ny+zc=; b=PaTkzfwLRDgXbsI61w/VajyMQB
	rLkcmQu/yEvTvZmtR48GTahbCl3KK+TgBIhL8AG7lIviXP9ThiNLA2luZ1qcP8s5yw2ySHinzZFkB
	Q3U2QzRZ7UDG2E6mG4VVQEVxbeBgfMt5aBhH8FG3a5HEUyCkAv7atBgYygboTeVT9Ci3TdNo0sgTn
	92BG/9ihNE7aq5dW3g63FfEy8JIEPYbfYif8KT8dAgmQITfjnSub+HVSgIb2XP9JsuWZJdUq99LAF
	milQ4OaSbRj5donih2aCz2qByTe2XAp3Fk2eSLHr4iEH1pdmyqRMcYvk2XdOjW2hlIyALwSOFvH+x
	qnuysKnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iP-00000003OcV-485T;
	Fri, 14 Jun 2024 16:23:50 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iM-00000003OYY-1ikB
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 16:23:47 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2c036a14583so400366a91.1
        for <linux-um@lists.infradead.org>; Fri, 14 Jun 2024 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718382222; x=1718987022; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOsdq+Rd2jD/oYTlQL4Vcr47c5ELyE1/1jwJx8ny+zc=;
        b=rjI13I4GWyEYjIr8nJ4eECfojmJ1C68WNQuE/4p3eRPqItAppL5MmacM3rBE+485QF
         g1CdSgEBtA1qCauGFVbzJe55+8UjfWlf4tyEQv0VkVWNCyvwJpn9EfyXuf7KMamfptPQ
         MYLomnQ1fRz50uR4GpCczmgpfWr8YLU6MoRoRl/7NQcgOs4DjfpUfr0IawaKmt5yw84z
         IMpCjnSFmmvTT7I5LlZw0RDp4ZVhZRXE1UsX9XW/yPEicej2uLTTIZI8J/2DANP6oIyV
         TzANzRNNR44ZFYPR5LLYhT2wodWVFEzA+opZTpQZuaaSL4bAhFlwHb8mEsmDx/veO4dJ
         gcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382222; x=1718987022;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOsdq+Rd2jD/oYTlQL4Vcr47c5ELyE1/1jwJx8ny+zc=;
        b=KGbUImw8CtXbfYEuRc9WMs/yg0zmqVCVQXImfQLrgJt9gHAy8ZIbJ6ZeBpA9SRVKjv
         L7Eawb40c16Sp0uWPdEyNA1IjyH+/Fdinxaf5m1Fszncl6+RenWs2ThVy0uyRrjTfNhU
         0g4os4VS6DR86iRTnIRiB1QXr9wPDg40yO61OxXwlIluXklKPQt8hNtWgYxBWerLeea0
         UOwqHrLh5KZzAjNvRhtoskk1csfquhn96BBt0ktj8S5aNO9eShGtmX1PfA6Fy2tZKPFH
         EGDbZ7Qb+KqME3Fy+KBPNnVGgqjuatvZRg154rfZL6dW6ZDZAQxGehwf0E84H+yeXvIx
         yv3A==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZH9jzgURTpjrfkShOlJOFcmt863obFuVsuahbszY4Y4mLZw/SVB7z2gXV+1aOprwW66iS3R5Ya/VVO6Sbqo0f6x3rIuHShoxDPzl
X-Gm-Message-State: AOJu0YzY0jwMAMG6PD/9i3DbCULshIYCbboq07+M2jKl0O+iAGzcEiz2
	8h/2b+RTE/yFOlQuqLHfAs6IouA323ZVdxDlagrJxpowgD/d5p6HDPH1E/S6aTg=
X-Google-Smtp-Source: AGHT+IFzZlkOeh7ub8gHV6v3rJ7EdBnks7HtbNFvAppAM0NMs6uCGvh3Ey3eFD0Th7n1FGRILE+Uqw==
X-Received: by 2002:a17:90a:d313:b0:2c4:da09:e29 with SMTP id 98e67ed59e1d1-2c4dbd431cbmr3209949a91.3.1718382222558;
        Fri, 14 Jun 2024 09:23:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c46701absm4112038a91.40.2024.06.14.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:23:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Josef Bacik <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
 nbd@other.debian.org, ceph-devel@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
In-Reply-To: <20240531074837.1648501-1-hch@lst.de>
References: <20240531074837.1648501-1-hch@lst.de>
Subject: Re: convert the SCSI ULDs to the atomic queue limits API v2
Message-Id: <171838222101.240089.17677804682941719694.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 10:23:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_092346_574248_3A006C5F 
X-CRM114-Status: GOOD (  12.80  )
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


On Fri, 31 May 2024 09:47:55 +0200, Christoph Hellwig wrote:
> this series converts the SCSI upper level drivers to the atomic queue
> limits API.
> 
> The first patch is a bug fix for ubd that later patches depend on and
> might be worth picking up for 6.10.
> 
> The second patch changes the max_sectors calculation to take the optimal
> I/O size into account so that sd, nbd and rbd don't have to mess with
> the user max_sector value.  I'd love to see a careful review from the
> nbd and rbd maintainers for this one!
> 
> [...]

Applied, thanks!

[01/14] ubd: refactor the interrupt handler
        commit: 5db755fbb1a0de4a4cfd5d5edfaa19853b9c56e6
[02/14] ubd: untagle discard vs write zeroes not support handling
        commit: 31ade7d4fdcf382beb8cb229a1f5d77e0f239672
[03/14] rbd: increase io_opt again
        commit: a00d4bfce7c6d7fa4712b8133ec195c9bd142ae6
[04/14] block: take io_opt and io_min into account for max_sectors
        commit: a23634644afc2f7c1bac98776440a1f3b161819e
[05/14] sd: simplify the ZBC case in provisioning_mode_store
        commit: b3491b0db165c0cbe25874da66d97652c03db654
[06/14] sd: add a sd_disable_discard helper
        commit: b0dadb86a90bd5a7b723f9d3a6cf69da9b596496
[07/14] sd: add a sd_disable_write_same helper
        commit: 9972b8ce0d4ba373901bdd1e15e4de58fcd7f662
[08/14] sd: simplify the disable case in sd_config_discard
        commit: d15b9bd42cd3b2077812d4bf32f532a9bd5c4914
[09/14] sd: factor out a sd_discard_mode helper
        commit: f1e8185fc12c699c3abf4f39b1ff5d7793da3a95
[10/14] sd: cleanup zoned queue limits initialization
        commit: 9c1d339a1bf45f4d3a2e77bbf24b0ec51f02551c
[11/14] sd: convert to the atomic queue limits API
        commit: 804e498e0496d889090f32f812b5ce1a4f2aa63e
[12/14] sr: convert to the atomic queue limits API
        commit: 969f17e10f5b732c05186ee0126c8a08166d0cda
[13/14] block: remove unused queue limits API
        commit: 1652b0bafeaa8281ca9a805d81e13d7647bd2f44
[14/14] block: add special APIs for run-time disabling of discard and friends
        commit: 73e3715ed14844067c5c598e72777641004a7f60

Best regards,
-- 
Jens Axboe




