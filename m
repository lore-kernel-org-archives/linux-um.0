Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDl3c-0005ar-Tc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 07:08:04 -0700
Received: from smtp3.poczta.onet.pl ([213.180.130.29])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDl3c-0004n1-AT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 07:08:04 -0700
From: Marcin Pawlik <wapkil@op.pl>
Subject: Re: [uml-devel] [patch] Re: Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
Message-ID: <20040414134604.GA24262@mpmain>
References: <20040413212307.GA14758@mpmain>
	<Pine.LNX.4.44.0404140305370.20676-200000@filer.marasystems.com>
	<20040414133215.GA7464@mpmain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040414133215.GA7464@mpmain>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 14 Apr 2004 15:46:04 +0200
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 14 at 15:32, Marcin Pawlik wrote:
> Do you know where and which thread closes the files? I tried to add
> file closing to kill_io_thread() (patch attached) and it helps
[...]

> diff -urN kernel-source-2.4.24/arch/um/drivers/ubd_kern.c
> kernel-source-2.4.24.mp/arch/um/drivers/ubd_kern.c ---
> kernel-source-2.4.24/arch/um/drivers/ubd_kern.c	2004-04-14
> 14:38:21.000000000 +0200
> +++ kernel-source-2.4.24.mp/arch/um/drivers/ubd_kern.c	2004-04-14
> 14:42:55.000000000 +0200 @@ -495,6 +495,16 @@
>  
>  void kill_io_thread(void)
>  {
> +	int i;
> +	struct ubd * ubd_devp = ubd_dev;
> +
> +	for(i = 0; i < MAX_DEV; i++, ubd_devp++) {
> +		if(ubd_devp) {
> +			os_close_file(ubd_devp->fd);
> +			close(ubd_devp->cow.fd);

To be consistent I should of course change the line above to
"os_close_file(ubd_devp->cow.fd);", sorry.

Regards,

-- 
Marcin Pawlik


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
