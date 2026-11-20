Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03045606A8A6
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZXZfz12V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vLvWjKh1LRnRhnuwrtjU/KRMUpKZP14gigi9j87P640=; b=ZXZfz12V3vNN3w
	LvgnNi86EcDHNnv5krOsbJKkCCPafN3Jb1RUjzD3V2tvLmut2dGlwnFTKCSN3Ovva98UY8FOfLFks
	Do1CZKXwQEMwu8PMkgd+uF6UIJIN8Bj2c2tIYoJqJIuqMwkMTxGNFjww7S/ECR9jKSkeT43yddAPn
	l1qLsRU00h6MkYR94GG4swjNqcuVUf+TUd33R1RqvjbkO5/BfVQm3B0PnOhY3BQEkvYsEq8AiLzzO
	a19YyZibS8DnmFXz3qR864SOpsS7YEMurWDXW2GLC5qY7qBQ85LpPZNQ5u/UqTwqQ/QR7zXMDI/fn
	TRTT1r2+rw9M8WeA8vvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUT1J-0000000FrTb-3zIS;
	Fri, 20 Nov 2026 18:07:33 +0000
Received: from ns3.kot-begemot.co.uk ([31.70.137.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUT18-0000000FrQk-2QZt
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 18:07:29 +0000
Received: from [192.168.19.6] (helo=jain.kot-begemot.co.uk)
	by ns3.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xUT0z-00000002Jix-1yiC;
	Fri, 20 Nov 2026 18:07:13 +0000
Received: from [192.168.21.17]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1xUSmt-0000000ERT6-3f1a;
	Fri, 20 Nov 2026 18:07:12 +0000
Message-ID: <4a3531de-35a7-4b2d-a9fc-11a77a8d057f@cambridgegreys.com>
Date: Fri, 20 Nov 2026 18:07:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: UML: user_mode_linux_howto_v2: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Renzo Davoli <renzo@cs.unibo.it>, linux-um@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20261120175509.1369714-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_100724_933336_044CEC61 
X-CRM114-Status: GOOD (  12.01  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/11/2026 17:55, Manuel Ebner wrote:
> Add missing ')'.
> 
> CC: Renzo Davoli <renzo@cs.unibo.it>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> [v2]
>   Correct position of closing bracket (Randy Dunlap)
> 
> [v1]
>   https://lore.kernel.org/all/20260909140051.1365758-2-manuelebnerli@mailbox.org/
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 9224bea5ee..e4b1cb1092 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -581,7 +581,7 @@ https://github.com/virtualsquare/sshlirp
>   
>   connect to a local area cloud (all the UML nodes using the same
>   multicast address running on hosts in the same multicast domain (LAN)
> -will be automagically connected together to a virtual LAN.
> +will be automagically connected together to a virtual LAN.)
>   
>   ***********
>   Running UML

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

