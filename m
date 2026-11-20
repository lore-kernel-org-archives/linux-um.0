Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C588606A335
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eFSUYyeL;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=FYumAXpr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=naEaD4YpWe3Shxw4+guWDoGoPtnn7xqfX4oJv7EZIOM=; b=eFSUYyeLVbBgYr9gpzwrBZyooI
	6z+2nnvYzXVnAoSUHl+NO+41SQR9cZfC1IlhjW9DSYVDIjI7dFAdt/rOZPosB7TY9oUNDPTu3BmOA
	IJX+st5ZYalxErgTsCJeb+PLaWKDHJET7zrBSTdi6rPHUgaj45uEjSKEbLYJQAsAJ3dN5/8jTsebu
	Gt0NvP9shmqLpO3mDOeKxme0u+0BbE4VK4kJG7rINXunG6ziLdwHP2lMvXkulPmE2IzJKvFLbWgDd
	DvsZIy6RVcTIoariJ31gPmOpbGThgeozlI67d4mSXqBUWUFAh6xv8HJadsLnUc8vSJwBp49Yfwso6
	DviSSjBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUWAf-0000000GJFP-3ugx;
	Fri, 20 Nov 2026 21:29:25 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUWA3-0000000GJ44-0GGw
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 21:29:23 +0000
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 9EAA61C007E;
	Fri, 20 Nov 2026 22:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795210108;
	bh=x3B2s1APWxBBSLeZ9kG+9z74t/qJot5h+obwq2A0BhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYumAXprYIdO2B295hQWcmjvo6+tlHIGynsCT/3RMw+/P80LvZ5apbZaQB4w+ixCk
	 kQHxPL+v5h8TPqRgVVm4sNPBJKibZ67PawB9aIWD+hrobu66VKOw98veL47Ad76MkI
	 MvFp/R8xG7fnA1PXfINxmBFbTEfE5vFNzMCNje34=
Date: Fri, 20 Nov 2026 22:28:26 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: UML: user_mode_linux_howto_v2: Fix bracket
Message-ID: <awC7erLjtqyg2_dx@cs.unibo.it>
References: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_132848_121722_629B9285 
X-CRM114-Status: GOOD (  13.67  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:55:09PM +0100, Manuel Ebner wrote:
> Add missing ')'.
> 
> CC: Renzo Davoli <renzo@cs.unibo.it>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> [v2]
>  Correct position of closing bracket (Randy Dunlap)
> 
> [v1]
>  https://lore.kernel.org/all/20260909140051.1365758-2-manuelebnerli@mailbox.org/
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 9224bea5ee..e4b1cb1092 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -581,7 +581,7 @@ https://github.com/virtualsquare/sshlirp
>  
>  connect to a local area cloud (all the UML nodes using the same
>  multicast address running on hosts in the same multicast domain (LAN)
> -will be automagically connected together to a virtual LAN.
> +will be automagically connected together to a virtual LAN.)
>  
>  ***********
>  Running UML

Acked-By: Renzo Davoli <renzo@cs.unibo.it>

