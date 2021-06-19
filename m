Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luUgI-00GVU9-Ba
 for linux-um@lists.infradead.org; Sat, 19 Jun 2021 06:42:16 +0000
Subject: Re: [PATCH] um: remove unneeded semicolon in um_arch.c
References: <20210619020301.77672-1-wanjiabing@vivo.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4320e0ea-1339-e2c1-03c0-271dbcd6e22d@cambridgegreys.com>
Date: Sat, 19 Jun 2021 07:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <20210619020301.77672-1-wanjiabing@vivo.com>
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
To: Wan Jiabing <wanjiabing@vivo.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes.berg@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@gooogle.com>, Corey Minyard <cminyard@mvista.com>, Thomas Meyer <thomas@m3y3r.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joe Perches <joe@perches.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On 19/06/2021 03:02, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./arch/um/kernel/um_arch.c:284:34-35: Unneeded semicolon
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   arch/um/kernel/um_arch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index f9f1463f0521..a149a5e9a16a 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -281,7 +281,7 @@ static void parse_host_cpu_flags(char *line)
>   	int i;
>   	for (i = 0; i < 32*NCAPINTS; i++) {
>   		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> -			set_cpu_cap(&boot_cpu_data, i);;
> +			set_cpu_cap(&boot_cpu_data, i);
>   	}
>   }
>   static void parse_cache_line(char *line)
> 

Thanks.

I do not think the patch which introduces this ([v7,1/3] um: Add support 
for host CPU flags and alignment) has been merged yet. I do not see it 
in the tree as of this morning.

I can see that it is already marked as done in patchwork so it is on its 
way.

Richard, what do you want me to do - reissue a fixed one or we should 
accept the fix once the original is merged?

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

