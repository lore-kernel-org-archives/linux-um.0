Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCRGi-00021u-Dg
 for linux-um@lists.infradead.org; Thu, 12 Mar 2020 17:05:13 +0000
Date: Thu, 12 Mar 2020 19:04:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] um: Don't use console_drivers directly
Message-ID: <20200312170456.GG1922688@smile.fi.intel.com>
References: <20200212100259.80438-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212100259.80438-1-andriy.shevchenko@linux.intel.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Thomas Meyer <thomas@m3y3r.de>

On Wed, Feb 12, 2020 at 12:02:59PM +0200, Andy Shevchenko wrote:
> console_drivers is kind of (semi-)private variable to the console code.
> Direct use of it make us stuck with it being exported here and there.
> Reduce use of console_drivers by replacing it with for_each_console().

Any comments?

> Cc: Thomas Meyer <thomas@m3y3r.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fix condition (we do NOT want to have a console), remove confusing comment
>  arch/um/kernel/kmsg_dump.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 98bdf69e4c2e..e4abac6c9727 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -9,20 +9,19 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  				enum kmsg_dump_reason reason)
>  {
>  	static char line[1024];
> -
> +	struct console *con;
>  	size_t len = 0;
> -	bool con_available = false;
>  
>  	/* only dump kmsg when no console is available */
>  	if (!console_trylock())
>  		return;
>  
> -	if (console_drivers != NULL)
> -		con_available = true;
> +	for_each_console(con)
> +		break;
>  
>  	console_unlock();
>  
> -	if (con_available == true)
> +	if (con)
>  		return;
>  
>  	printf("kmsg_dump:\n");
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

