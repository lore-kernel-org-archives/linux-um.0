Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1A9CD484B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jRxkoHo9aZXH83kJ40GfQDBTydrjiQRyTDZe4sB1hxQ=; b=QarAISgXXUcAac
	HIuQCmSf+2adG6kIsP1ZZILFqvnlzBuEWfjB7/t/ANvwZ8Ahn1kbq6tFUanQT0EI3DWHQDPZ3+G8d
	IM2rFCIGpwCUORQ/TaWueyuB52eTyVx56tmZZ0tLT68PzYQH1Xhp4pKAT6jOneBUSqdX8sC21W0Gu
	yDh4g3YkLiCZLQ5gRGb61NjpWU7yQAUSHrBZwNSyyBBTlvXXuuzmGEm3tk7aDxjbmokK55FnATECL
	CoqnIdE2mxU1Vj+IMxsD8YLUIRphgmRAqt+rDDa/oNYjuePxZoJIX2pVvEuVpWymkNwW10xnvlmRK
	hf4zXS5RbCKUml3Et3EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjkgr-009bkB-0J;
	Fri, 22 Sep 2023 18:15:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjkgo-009bjh-1o
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 18:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mMzzyfQDScxcWWO6iuyZuwPLWLwORr+3MD7HM5RHDKk=;
	t=1695406541; x=1696616141; b=yFxgxm5B32SyoSIx5EiaWo/ONpTaP6YlH+TgpC3v3cZx2g6
	qPIu5/o3VKbvFEgYHLqIo/SQ9RaIDX37mFjuCsQLlaFj9O96RGgCumscWrWALcZz3PiJckryNdY/V
	4CKytIRh487dQo4PkVrp3CbDBaDd9jUegQsZ8euL4iGVoiquOS+huxDIBXvLooezME9nWCQBOZy9v
	6Gy5k8uS3s5dk5QHBjkV7ib+aO+HR/C6qRMVg+AeYXC7QohA4GLT7WrD0yKPEGNJE05X5eRX1PDHM
	mnIEeSwdAcAaq9nlF0xW41yO9QdbpnrlLDlAW2s7L/wn/KK4WQyXHIyCsZfLuUUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjkgl-00Fcvg-1f;
	Fri, 22 Sep 2023 20:15:39 +0200
Message-ID: <98862288fba9aeb6a97bac15df6c23fa3e920b9a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date: Fri, 22 Sep 2023 20:15:38 +0200
In-Reply-To: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_111542_598628_AB07B421 
X-CRM114-Status: UNSURE (   5.71  )
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

On Fri, 2023-09-22 at 13:16 +0200, Johannes Berg wrote:
> 
> -	/* Set parent's instruction pointer to start of clone-stub */
> -	thread_regs[REGS_IP_INDEX] = STUB_CODE +
> -				(unsigned long) stub_clone_handler -
> -				(unsigned long) __syscall_stub_start;
> 

For the record, of course we could remove stub_clone_handler too now.

Once I figure out what's going on with this I guess.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
