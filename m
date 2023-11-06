Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C96FC4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bKNx4BB7QZxYLD02ea3LnwFViuj5Hwmxgx9366xcXK0=; b=33Qh8TG6ACgz1z
	uTuBc40d/bj0Vuh7qH9VoB7OQrNx93ieim5DwJuinw6Lhoo5MaTZCt/JuiQSoapOV4kJ2fGJlFFfh
	mWerRFghya5h3JXwmq98w6gAijN/n7jWxhjDcC5IspJl1M5NjTSyWar+1b+l1edyNTllYhAecQddT
	sbWY4SOC7a8LCMINdkrjQVV0Y1C5cmo9meEpIFfJB4ybX2fjacl+ESgQy+BL3p/sWS0boMxtMpNHS
	hrFN0T0SgYkd1+EGgxNgAZfuRDcjIlTV5xpOb1lBgN1hW3rls0GpaRUza3W0emd54TCz+EwbbUHQw
	yOF5ksWF3V7U2bxWRbeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r069f-00HUkS-2w;
	Mon, 06 Nov 2023 20:25:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r069f-00HUk9-0U
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9EDBdggPX18CBqjr7DTM7sdq+4gUFFVopTcBnvBd7Zs=; b=meG7CCr0U1bljEjL72gZgmKAOU
	jDaZtZWu23lfIo1gtUAY2eaUqqZqnFX3P++jxmYj0eAD+fgr8bGCWI/CToByZThrh8rixO7fqZZM8
	g5V0Y4ys1rKjuvbbFeC9jCtlLfd/Ftn3MqUykBNdZZYhnVkErTI/RkbM/Hfvn8CMWrosaPbP5M6ue
	yR0WKO4GlHudkR08VzttKsnzVhbJ0sKWc5Mu24KAsqPqoIVCtucb2GT21vpMxAHIOfQTvKVu9AE/D
	HVavIzigF6bQ7TR0jsHRSgyunkreSFCaAwHNEHAyrEGDiaTJ9/btIvxdv5NG6qkOvhSQqKQWgY+mm
	joMd45ag==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r069Y-00AmKa-26
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9EDBdggPX18CBqjr7DTM7sdq+4gUFFVopTcBnvBd7Zs=;
	t=1699302290; x=1700511890; b=u5D+Xdh8amlTfruAamctRVQ7OUk13vCzk8TxWd4fF0Jxn3/
	Owy5V1TUd5WJUHsemOdF1jPIo04Wt30+N5UzsjyQs7fjPbkctz7rkCrMD4Ky+HgbgyWlRgc8SU4wz
	GSbWMGqNUCLO6AdG6iEUSlnG7UjXV5SF+5CiaFu0c65YyF7pjPY4kHPtHjzjbzyzOpi4H4FdONGln
	5VRaFOI+8qF+1pTTYNEPh31XL1kGTCyPW+X153YbxzNhZsRTp7tDnhNjn4XedB7JZVh1Pnxcsv2+c
	1Ot9WM7xtVEdPGssfnwcBOHwNt5cAZbsbnDnvFnB2l3yFxCYwgmuVEQ1wOPS80eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r069I-0000000FshH-2qQv;
	Mon, 06 Nov 2023 21:24:41 +0100
Message-ID: <84cd091dc90cf4102f84778f6b8ab724212152cc.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 01/11] um: Make UBD requests synchronous in TT
 ext/infcpu mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:24:39 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-1-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-1-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_202456_861924_F7820B44 
X-CRM114-Status: GOOD (  17.51  )
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
> The UBD driver employs multiple threads to enhance block device accesses
> in userspace. These threads communicate via pipes and are triggered by
> interrupts that utilize the SIGIO handler.
> 
> However, in TT mode, both inf-cpu and external modes, this asynchronous,
> multithreaded request processing lead to issues where requests are not
> processed. This occurs because there is no dedicated time travel handler
> for the UBD interrupt.
> 
> Since asynchronous, multithreaded request processing does not provide
> substantial benefits in time travel mode and may even introduce
> additional overhead (as multiple threads are scheduled sequentially to
> execute requests in TT mode with infinite CPU power), this patch
> switches to synchronous request processing directly within the
> submit_request call for the respective TT modes.

This makes perfect sense. We mostly use hostfs, but recently did the
exact same thing there.

> +#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> +	/* do not initialize asynchronous io-thread and corresponding irq
> +	 * in inf-cpu or ext time travel, as we need synchronous io logic
> +	 */
> +
> +	if (time_travel_mode == TT_MODE_INFCPU ||
> +	    time_travel_mode == TT_MODE_EXTERNAL)

Maybe we should finally refactor these checks though ... :)

And you don't need the ifdef, because time_travel_mode is defined to
TT_MODE_OFF without CONFIG_UML_TIME_TRAVEL_SUPPORT, and then this just
gets optimised out.

>  static int ubd_submit_request(struct ubd *dev, struct request *req)
>  {
> +	int i;
>  	int segs = 0;
>  	struct io_thread_req *io_req;
>  	int ret;
> @@ -1334,6 +1354,17 @@ static int ubd_submit_request(struct ubd *dev, struct request *req)
>  	if (segs)
>  		ubd_map_req(dev, io_req, req);
>  
> +#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> +	//do the request sychronous (bypass io_thread and ubd_handler)
> +	if (time_travel_mode == TT_MODE_INFCPU ||
> +	    time_travel_mode == TT_MODE_EXTERNAL) {
> +		for (i = 0; !io_req->error && i < io_req->desc_cnt; i++)
> +			do_io(io_req, &io_req->io_desc[i]);
> +		finalize_request(io_req);
> +		return 0;
> +	}
> +#endif
> 

Same here, and in fact with the ifdef you'd get an unused variable
warning, but anyway you could move that into the block (or even into the
for now that we require C99!)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
