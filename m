Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7YsU-001Vqe-Vw
 for linux-um@lists.infradead.org; Wed, 12 Jan 2022 08:21:08 +0000
Subject: Re: [PATCH] um: add generated capflags.c to gitignore
References: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4ae59d27-6778-0376-58db-a67899ac125d@cambridgegreys.com>
Date: Wed, 12 Jan 2022 07:59:03 +0000
MIME-Version: 1.0
In-Reply-To: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 11/01/2022 22:23, Benjamin Beichler wrote:
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/.gitignore b/arch/um/.gitignore
> index 6323e5571887..8168b3bc08b8 100644
> --- a/arch/um/.gitignore
> +++ b/arch/um/.gitignore
> @@ -2,3 +2,4 @@
>   kernel/config.c
>   kernel/config.tmp
>   kernel/vmlinux.lds
> +capflags.c
> \ No newline at end of file
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

