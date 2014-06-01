Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Wr0bB-0001Ii-Of
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jun 2014 07:54:33 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wr0b7-0001yl-5R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jun 2014 07:54:33 +0000
Message-ID: <538ADC2C.6060902@nod.at>
Date: Sun, 01 Jun 2014 09:54:20 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1401582246-30025-1-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <1401582246-30025-1-git-send-email-enjoymindful@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] delete unnecessary bootmem struct page array
To: Real Name <enjoymindful@gmail.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Hi!

Am 01.06.2014 02:24, schrieb Real Name:
> 1) uml kernel bootmem managed through bootmem_data->node_bootmem_map,
> not struct page array, so it is unnecessary.
> 
> 2) the struct page array allocate has been pointer by a *loacl* pointer
> struct page *map in init_maps function. The array can't be access after
> the init_maps exit. As a result, there is about 1% of total memory leak.

Please add a Signed-off-by tag using your real name.

Thanks,
//richard

> ---
>  arch/um/kernel/um_arch.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 016adf0..d4c98d1 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -348,12 +348,6 @@ int __init linux_main(int argc, char **argv)
>  	start_vm = VMALLOC_START;
>  
>  	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
> -	if (init_maps(physmem_size, iomem_size, highmem)) {
> -		printf("Failed to allocate mem_map for %Lu bytes of physical "
> -		       "memory and %Lu bytes of highmem\n", physmem_size,
> -		       highmem);
> -		exit(1);
> -	}
>  
>  	virtmem_size = physmem_size;
>  	stack = (unsigned long) argv;
> 

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

