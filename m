Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C23C05027
	for <linux-um@archiver.kernel.org>; Sun, 12 Feb 2023 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/YYGQGj7eTOckn2Qn7Ff+iKDeyQh5k7h3IYAcDb0HQk=; b=RjHUAe2EuN1mwH
	YGH3qBotO2Bd2t5UA13lpBzFU3zBLhj6eB8LMFs6yb54hRsESvtLzzhxizlmg0erWQ51a9Ba/wbwV
	NobSyrNn9F4BKRmOWfigTUSa9uoXJivoumukfzfOjY7SyMR36h3FAq8rAoFmnkQjYtstwvezYXvKL
	ZOswXr+SFOY3L/fFhkUyyAAWFSbzxs/Yw4he31FgCulNx97sZLEFSW3hTE3eENtfYtSFUC55NbDH0
	8ivIS8a4Uxqk9Jgos4IQEAPvb6kC5DpawbzV4tV0//SqtNSosGzpVrRpidrVzzMONBqXnRfGrKozu
	fWLHwQCYHFO9SR7UP1Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRJzh-00COKz-Vw; Sun, 12 Feb 2023 21:34:45 +0000
Received: from [2601:1c2:980:9ec0::df2f]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRJze-00COKc-K3; Sun, 12 Feb 2023 21:34:42 +0000
Message-ID: <e3f6699b-4b6e-b2b4-9561-1b6d828a740b@infradead.org>
Date: Sun, 12 Feb 2023 13:34:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] um: add __weak for exported functions
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20230212203204.34cef454b288.I409a7567fcf846cd8f79e7788eb8c8869547463e@changeid>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230212203204.34cef454b288.I409a7567fcf846cd8f79e7788eb8c8869547463e@changeid>
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



On 2/12/23 11:32, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the exported glibc functions don't exist, we get link
> failures. Avoid that by adding __weak so they're allowed
> to not exist.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/um/os-Linux/user_syms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
> index fd575ecbcaec..54722c7f884f 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -39,7 +39,7 @@ EXPORT_SYMBOL(printf);
>   * good; so the versions of these symbols will always match
>   */
>  #define EXPORT_SYMBOL_PROTO(sym)       \
> -	int sym(void);                  \
> +	int sym(void) __weak; \
>  	EXPORT_SYMBOL(sym);
>  
>  extern void readdir64(void) __attribute__((weak));

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
