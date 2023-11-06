Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B989C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sYNCDFKC5xU9gXaI+acjh1/LKBhp+lLYZE662lbZ5/Y=; b=CUexVOJhNYGlFH
	zk5psI7+Pv84xQIub2DugqD3so95XTQhwugAdnt5ApfqRXKiKprjC0cdKfFTrxgyUDNqGw8gGZuXN
	cfQfctatV0HrhfF0JEyqhutF+EzzI4gUSNNfO02DWctEeyyFun77HOqA9YuYfqaiqXmwFlHkLyP6r
	lXFf2GINlwsrIm80zQGKeDLnTB4CaYh49Ark5/aNsUXZ3cII1nt2gkQApkaosg8cFuiOzRh6qfJod
	i5ekja5oZTsr3O7WHGMif2yrERSnNfnKr/9EnWCnEkjcsuOhoSwJx9MQLVi1SEKwa9DRN/RUrsRdj
	VBdb+47NfVqxATJQUqHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06Dl-00HVEI-0w;
	Mon, 06 Nov 2023 20:29:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06Dk-00HVE1-0A
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ENtQNxlRVLSKBY79Q7vcdFu/+3J1OovCjHSFf1I2IFE=; b=Lkox1Gdzjgr5A4jfjoL2Y6rzuy
	lTRD7WCQPcnCMPV4nZGQW+ki4yEuAYb83F292uB8RnjGlWBhTA2YWU6SuV/GNIK2Jazz3BBJMN5Rh
	hY2mM020fHeyoq+CfdYeDXZAkBSfKtTr3G/HnVigj1x0+OEZXwWOaLzGBIsXl0nCMXTJPVa7juTb+
	TMkl4P5cm1rGHsje/gbKxiwIL11Xzg12uQapeV4O5doZuK/lfkS3z41mGacqXMdM4hjapZoEwpgO+
	HhwlR9ij/A3ao7TTl7YVXl+9mUQtyYxcCM39Jd0b1qKurQOrcIAykgiU4FUqL1Zqb0zoaeGt7yMVo
	CWrgSugw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06De-00AmPD-0M
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ENtQNxlRVLSKBY79Q7vcdFu/+3J1OovCjHSFf1I2IFE=;
	t=1699302549; x=1700512149; b=SLxTn5eowEexu6LdwX1fTIorIfHt6eFdAF2ABoMno7pvBr1
	W93WIYtGzxVPD3EQlicj2HUj9Ejm81iPXa09HR2fHAwzIuDiKHhCvPuZdVDsnszklCX55w95Bj8AH
	wKsFTg9w6+X4IKoZkT2VkHNXJjdU6pExdUKhupWZjeECuq9CH0+ignQEeyx0gjPsEM1g1YvzzIoeQ
	SGItdTnHdpu+a22GTAtJ9gabLm9Ua5ZkVwlBh9EdnzSaibuV0B31noBRXzWSpwBarMbW4LOYndVG+
	jjBlYBF5sBZfzRowHqBJv7vjMFeNzjVtt6cPg3M3MOgYCXOWIX2xlnxB73c3qrOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06Dc-0000000Fsr3-2ZSr;
	Mon, 06 Nov 2023 21:29:08 +0100
Message-ID: <a2fc55c2c434141530d6a39c05fa3e64998273dd.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 05/11] um: Add final request time to TT wait message
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:29:07 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-5-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-5-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_202912_980904_7A6BA71B 
X-CRM114-Status: GOOD (  11.95  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> Although the information for the next requested time was already sent in
> a prior message, this change introduces the otherwise unused time
> variable in the TT message. This addition enables an extra consistency
> check and can otherwise be ignored.

Seems fine to me.

> --- a/include/uapi/linux/um_timetravel.h
> +++ b/include/uapi/linux/um_timetravel.h
> @@ -77,9 +77,9 @@ enum um_timetravel_ops {
>  	/**
>  	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
>  	 *	runtime, new requests may be made while waiting (e.g. due to
> -	 *	interrupts); the time field is ignored. The calendar must process
> -	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
> -	 *	the host can run again.
> +	 *	interrupts); the time field contains the next requested runtime
> +	 *  for consistency checks. The calendar must process this message and
> +	 *  later send a %UM_TIMETRAVEL_RUN message when the host can run again.

Indentation got messed up here though.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
