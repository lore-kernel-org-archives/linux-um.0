Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D969C71136
	for <linux-um@archiver.kernel.org>; Thu, 12 Jun 2025 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geyoIOufnNyL2QORApZMSyBSnDHoOLrbH0b4kuCOKOw=; b=l7H0/blWqVzCpKwyKYqOOTL4qo
	rZpnNUFL2Eye7EuCy9THxJ4mFDkaCaWL4Vn8zoIXTC6YmehElaxdM9V3ZSvtU4lnycGU9iEDbTYd+
	/h7e73zZqO115NQF4P1C3+VI6Gzz4EBY+baVBx6tbL0tz6rvgV5YTcTwToR05T0Nt0HPOf2hIl8sx
	omDEecr+hRz8Adk1NFtQjkUOYabb11jTmM7aMRQBd6aa+XABgrR31EG/PQ7jCt2mC0J51JfIBRyDO
	G2eXu8FDAQZrMU3Ex4EQPzuU4UJ4r/4vMpiUb15SjR/+xG7Q5o3glbR1SF8vVYb9UzZhppllvdZY+
	T7MksAfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPnsO-0000000EMG6-0tn1;
	Thu, 12 Jun 2025 19:46:16 +0000
Received: from mout-p-102.mailbox.org ([2001:67c:2050:0:465::102])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPkUk-0000000DuKc-3Ma7
	for linux-um@lists.infradead.org;
	Thu, 12 Jun 2025 16:09:40 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bJ6sl126cz9tJR;
	Thu, 12 Jun 2025 18:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749744555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geyoIOufnNyL2QORApZMSyBSnDHoOLrbH0b4kuCOKOw=;
	b=ybcFJJih7D/IT5O/wPsKKWJ/ydLa/CH1tbqS1yTFezbtu/x/Gk/Ukz1HABfykXqLk1xH7r
	Q29kOWiRnS20CWxhwbUpiLf5yZ4L7PZeXmJq8AsQfraNqgF3GLkbT0vPRWwiOWgkGdhBK2
	Z2aukNMRIOQDNz5A7xMU5DZwAFuD5pL1QkOcFTpeMrVzAcAJMODZaP1lGat4Le2KJgOK/8
	OtGFlCR8JwBqGx2i9FbQ+ZIICZXvP3bD7hufR7jrZO+f/l7xJ9+EfJsmGOEqoDyJar/pOU
	BOf3XPL4QySy6xgN6U4qZmPIL+uALdP0IR4JKUgnxE+0+pDtkOUNgemJZtEb7g==
Date: Thu, 12 Jun 2025 21:39:10 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, justinstitt@google.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] um: replace deprecated strncpy with strscpy
Message-ID: <apa4k3ikv5huxms2dyf2cduhkg73gt5sei3skg7kxcrew6v6py@4fxolyigqe4e>
References: <20250607213006.7858-1-listout@listout.xyz>
 <202506092114.01147457A5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202506092114.01147457A5@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_090939_026735_D238D150 
X-CRM114-Status: GOOD (  15.27  )
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

On 09.06.2025 21:15, Kees Cook wrote:
> 
> I think we need wholesale fix the kernel's usage of
> strncpy_from_user()... first, how is it being used?
So I looked at some of the codes under driver, but it's not very clear
to me how they are currently used.
For example in drivers/tty/vt/vt.c there is this code

	if (!op->data)
		s = NULL;
	else if (strncpy_from_user(name, op->data, MAX_FONT_NAME - 1) < 0)
		return -EFAULT;
	else
		name[MAX_FONT_NAME - 1] = 0;

Which looks like it's not getting NUL terminated.
Where as there's also other instances such as in
drivers/accel/ivpu/ivpu_debugfs.c


	ret = strncpy_from_user(buffer, user_buf, size);
	if (ret < 0)
		return ret;

and in drivers/gpu/drm/virtio/virtgpu_ioctl.c


	ret = strncpy_from_user(vfpriv->debug_name,
			u64_to_user_ptr(value),
			DEBUG_NAME_MAX_LEN - 1);

again in drivers/dma/xilinx/xilinx_dpdma.c we see


	ret = strncpy_from_user(kern_buff, buf, size);
	if (ret < 0)
		goto done;

So it seems like it's not very consistent to me. But I might be wrong.

> Are things being
> manually terminated? Are something destinations not actually C Strings?

Some of them are, while others are not. For example in
drivers/dma/xilinx/xilinx_dpdma.c example the kern_buff is a pointer to
char while in the drivers/gpu/drm/virtio/virtgpu_ioctl.c example
vfpriv->debug_name is an array.

> We may want two APIs (like strtomem vs strscpy). And then since we're
> dealing with user data, I would think padding should be included?

Can you please example on this a bit, like would you like two separate
functions, for example strscpy_from_user and strtomem_from_user. For the
padding we use _pad version of the strscpy function.
> -- 
> Kees Cook

-- 
Regards,
listout

