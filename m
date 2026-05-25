Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E5FCD5BB1
	for <linux-um@archiver.kernel.org>; Mon, 25 May 2026 20:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9AsWKgEfmrIMxl67jBxbUxZhNMqcuPEASNuQqqNWJqs=; b=tgCcnlDWmPpX2QhPtDlkl0qr/Z
	usae+cKG+cwEJS28+mpM2WVhMvH+0RdGGGA6hWUnV18GNarFj2gMjSX1Sx0DBqzJx32esWRWmXf9B
	uCy+PFgJvgQJCogz9DyCLRGEEOPcOpztYI+2nsFW36Ud57JravfM3Qy5zJfNjCMJ4hlcsupFxDx1K
	DU5VOVIeq4ZyjasAlwKC2IITX6D7PNEtwfBKQVYXSrjclhzKgWy3IuC/O6JHejb/pbnvdeOGUGLhZ
	LpHh5ivubaMgsozrw15TXEH3Fx41DvxBX9P0TgAPXXGFWtG6/obCiJhIRZIDz6/nguPpT3nzjwJYr
	BgFAlg8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRbpl-00000000Ozr-1ct5;
	Mon, 25 May 2026 20:23:33 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRbph-00000000OzH-0AEj
	for linux-um@lists.infradead.org;
	Mon, 25 May 2026 20:23:30 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9DBE240B0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1779740607; bh=9AsWKgEfmrIMxl67jBxbUxZhNMqcuPEASNuQqqNWJqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z81ySdkrf0RTwdSwvwBDD1jbD/kU2ycCIoSa4sxJzCcYPGzilYvtL668gEqAErju9
	 +6j+YQlASalQlzJMfCz4NZMkrsPNUR/MgzCaZa/+z5J+BurCvLwuLKfpqncW6OAZmZ
	 jfTddA8h8hwZrh39/jPeWqczMr/cfbDU3NzAi6mdk1QbkRDVqYOepU6VPLwj35Gzjp
	 G4ENFi2ajWjwnKDl73Jx9TRAXhCUEoPCtW1Thr0UMW4jw0ZfLohL8+L23pF4kKgM2U
	 I/w7rTukgOprMvffVdD7zf7EwafEEP4NivpBA2O91tR8EKV0lUx04/rYte5LU+xaN4
	 Txo0HjATDc8/Q==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9DBE240B0C;
	Mon, 25 May 2026 20:23:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sakurai Shun <ssh1326@icloud.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Sakurai Shun <ssh1326@icloud.com>, linux-um@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix typo in user_mode_linux_howto_v2.rst
In-Reply-To: <20260517022456.5895-1-ssh1326@icloud.com>
References: <20260517022456.5895-1-ssh1326@icloud.com>
Date: Mon, 25 May 2026 14:23:26 -0600
Message-ID: <87v7cbz1a9.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_132329_081911_D5434E9F 
X-CRM114-Status: GOOD (  14.22  )
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

Sakurai Shun <ssh1326@icloud.com> writes:

> Replace "privilges" with "privileges"
>
> Signed-off-by: Sakurai Shun <ssh1326@icloud.com>
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index c37e8e594..9224bea5e 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -234,7 +234,7 @@ an ioctl to setup the tun interface and/or use raw sockets where needed.
>  This can be achieved by granting the user a particular capability instead
>  of running UML as root.  In case of vector transport, a user can add the
>  capability ``CAP_NET_ADMIN`` or ``CAP_NET_RAW`` to the uml binary.
> -Thenceforth, UML can be run with normal user privilges, along with
> +Thenceforth, UML can be run with normal user privileges, along with
>  full networking.

Applied, thanks.

jon

