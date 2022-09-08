Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWH4q-003UYM-Qq
	for linux-um@lists.infradead.org; Thu, 08 Sep 2022 12:56:19 +0000
Message-ID: <514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
Subject: Re: [PATCH] um/kernel: fix repeated words in comments
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 08 Sep 2022 14:56:03 +0200
In-Reply-To: <20220908125401.28130-1-wangjianli@cdjrlc.com>
References: <20220908125401.28130-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: wangjianli <wangjianli@cdjrlc.com>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 20:54 +0800, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  arch/um/kernel/physmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index e7c7b53a1435..91485119ae67 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
>  );
>  
>  /*
> - * This list is constructed in parse_iomem and addresses filled in in
> + * This list is constructed in parse_iomem and addresses filled in
>   * setup_iomem, both of which run during early boot.  Afterwards, it's
> 
Fine, I guess, but honestly - that sentence doesn't parse well either
way. Might be worth addressing that at the same time...

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

