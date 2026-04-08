Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24AEFD5F8C
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8+KM1He4y8YFVz0IVPpHaGgsGzxBtpcXzn8bdfNOks=; b=nop3vyzxmEl2JG+ojYc1Oik1lr
	Ht9SwAzLZyoaPHHQkdwdCb73kImiJpknAjiyY/qrq9buEo6dt+rexMWn9i1CFXDm2n5xvA3zJz9P/
	iBb2EBVl/XtXjcOrqcMEhrG13YSvHdiFqMuf+HX9qsq5BIfwV6Qz/icFLqkE2nwQO0rTlEYUghPPa
	8u7sPLvK/j+pci6PhbQKo0Wkfv5SHFq+1GXzx0e4gNXB75y8T6KaVchrc2YxjtU4vi8raqihlngEW
	+J/yVLzuZjVQRxI0bzDfBDsp2Ka/TxHhUb8o3YJgLYo8essWig23WR05HpuZ+Wn3SUZqts+13fLM3
	7c2bPfQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANVH-00000008Rzc-0cRi;
	Wed, 08 Apr 2026 07:39:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANVD-00000008Ryt-0PHK
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 07:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o8+KM1He4y8YFVz0IVPpHaGgsGzxBtpcXzn8bdfNOks=;
	t=1775633947; x=1776843547; b=YkUqyDWTeK0Plmaz4naQWnLtl4NFbsQ7vjJywyFAM8CWTM6
	wKxUBQEjIZ/sJCat/6O6hFoon5sLyvX+LGaygeGGD44ZBftOwiiQJegGaz6BJtp6+f579KA4OApHb
	+tFIJxnFkddnB4J7UqtmWkTJDtwRThLeI+nPeWF4RAhOYr0v0XnXjUspotUq+MCZ52Za0Iroiv22g
	hDZH3OTCmJQ8EObhhunQQNX0YrOurHhPW1FVVTX8exc9uVA0iuw+pKyensqFNk6lBGGbixwS8PjnC
	JDtlHgP3+qVeXYeZZCn1ezohN+DSTH5xwubUjK3zFqmP1j/eNLkNfG44fq0JVexA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wANV9-0000000E7Ov-31Ty;
	Wed, 08 Apr 2026 09:39:04 +0200
Message-ID: <d022d5597e1d5ca3ecddb192e39d4a14a16d4c5a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: reject out-of-range port channel numbers
From: Johannes Berg <johannes@sipsolutions.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Apr 2026 09:39:02 +0200
In-Reply-To: <20260401160315.88534-1-pengpeng@iscas.ac.cn>
References: <20260401160315.88534-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_003908_841274_644E18C8 
X-CRM114-Status: GOOD (  10.52  )
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

On Thu, 2026-04-02 at 00:03 +0800, Pengpeng Hou wrote:
> port_init() parses the port channel number into an int, formats it into
> a small fixed string buffer, and later passes it to htons() for bind().
> Out-of-range values can therefore overflow the local device-name buffer
> and still get silently truncated at the socket layer.

So ... you have a whole bunch of these fixes, but do we really assume
that the kernel command-line is somehow attacker controlled for ARCH=3Dum?

Maybe I'm not imagining the right things, but I have a hard time seeing
anyone run a service of any sort where the command line gets to be user-
controlled, and yet the kernel needs to be secure against that user; in
a normal ARCH=3Dum scenario the command line is written by the user as
something like

	linux foo=3Dbar mem=3D256M ...

and then can happily attach gdb to the process and muck with it any way
they want anyway?

I'd probably say the code shouldn't have been this way at the start, but
I'm also not convinced it's even really worth fixing for anything but
the "look my LLM found _something_" creds...

johannes

