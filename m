Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1Ync-0006KP-FQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 17:50:46 -0800
Received: from gepetto.dc.ltu.se ([130.240.42.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1Yna-0002il-S9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 17:50:44 -0800
Message-ID: <4599BAE1.9050804@student.ltu.se>
Date: Tue, 02 Jan 2007 02:52:33 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
MIME-Version: 1.0
References: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
In-Reply-To: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 4/8] UML - audio driver formatting
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> Whitespace and style fixes.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> --
>  arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
>  1 file changed, 73 insertions(+), 87 deletions(-)
>
> Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
> +++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
> @@ -15,11 +15,11 @@
>  #include "os.h"
>  
>  struct hostaudio_state {
> -  int fd;
> +	int fd;
>  };
>  
>  struct hostmixer_state {
> -  int fd;
> +	int fd;
>  };
>  
>  #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
> @@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
>  static ssize_t hostaudio_read(struct file *file, char __user *buffer,
>  			      size_t count, loff_t *ppos)
>  {
> -        struct hostaudio_state *state = file->private_data;
> +	struct hostaudio_state *state = file->private_data;
>  	void *kbuf;
>  	int err;
>  
>  #ifdef DEBUG
> -        printk("hostaudio: read called, count = %d\n", count);
> +	printk("hostaudio: read called, count = %d\n", count);
>  #endif
>  
>  	kbuf = kmalloc(count, GFP_KERNEL);
> @@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
>  	if(copy_to_user(buffer, kbuf, err))
>  		err = -EFAULT;
>  
> - out:
> +out:
>   
Isn't labels _suppose_ to be spaced? (due to "grep", if I'm not mistaken)...
>  	kfree(kbuf);
>  	return(err);
>  }
> @@ -99,12 +99,12 @@ static ssize_t hostaudio_read(struct fil
<snip>

Richard Knutsson


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
