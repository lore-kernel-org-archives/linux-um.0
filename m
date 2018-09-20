Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g34Gk-00072S-TV
 for linux-um@lists.infradead.org; Thu, 20 Sep 2018 19:05:45 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] Don't hardcode path as it is architecture dependent
Date: Thu, 20 Sep 2018 21:05:29 +0200
Message-ID: <2232247.seiAqWBpkp@blindfold>
In-Reply-To: <20180920062640.23038-1-rrs@debian.org>
References: <20180920062640.23038-1-rrs@debian.org>
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
To: Ritesh Raj Sarraf <rrs@debian.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2018, 08:26:38 CEST schrieb Ritesh Raj Sarraf:
> The current code fails to run on amd64 because of hardcoded reference to
> i386
> 
> Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>

Thanks for spotting this!

> ---
>  arch/um/drivers/port_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
> index 9a8e1b64c22e..5f56d11b886f 100644
> --- a/arch/um/drivers/port_user.c
> +++ b/arch/um/drivers/port_user.c
> @@ -168,7 +168,7 @@ int port_connection(int fd, int *socket, int *pid_out)
>  {
>  	int new, err;
>  	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
> -			 "/usr/lib/uml/port-helper", NULL };
> +			 OS_LIB_PATH "/uml/port-helper", NULL };
>  	struct port_pre_exec_data data;
>  
>  	new = accept(fd, NULL, 0);

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

