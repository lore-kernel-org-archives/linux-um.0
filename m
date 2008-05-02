Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrrdH-0001Fu-9w for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:32:47 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrrdF-0007t3-Mz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 02:32:47 -0700
Date: Fri, 2 May 2008 12:31:52 +0300
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20080502093152.GA4090@cs181133002.pp.htv.fi>
References: <alpine.LFD.1.10.0805021450260.3349@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805021450260.3349@localhost.localdomain>
Subject: Re: [uml-devel] [Patch] UML: Fix inconsistence due to tty_operation
	change
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: akpm@linux-foundation.org, Alan Cox <alan@redhat.com>, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

[ Alan as tty maintainer added to Cc ]

On Fri, May 02, 2008 at 02:59:46PM +0800, WANG Cong wrote:
>
> 'put_char' of 'struct tty_operations' has changed from 'void' into 'int'.
> This can also shut up comipler warnings.

Not only, this could also be a runtime error.

> Cc: Jeff Dike <jdike@addtoit.com>
> Signed-off-by: WANG Cong <wangcong@zeuux.org>
>
> ---
>
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 10b86e1..5047490 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -191,9 +191,9 @@ void line_flush_chars(struct tty_struct *tty)
>  	line_flush_buffer(tty);
>  }
>
> -void line_put_char(struct tty_struct *tty, unsigned char ch)
> +int line_put_char(struct tty_struct *tty, unsigned char ch)
>  {
> -	line_write(tty, &ch, sizeof(ch));
> +	return line_write(tty, &ch, sizeof(ch));
>  }
>
>  int line_write(struct tty_struct *tty, const unsigned char *buf, int len)
> diff --git a/arch/um/include/line.h b/arch/um/include/line.h
> index 1223f2c..979b73e 100644
> --- a/arch/um/include/line.h
> +++ b/arch/um/include/line.h
> @@ -71,7 +71,7 @@ extern int line_setup(struct line *lines, unsigned int sizeof_lines,
>  		      char *init, char **error_out);
>  extern int line_write(struct tty_struct *tty, const unsigned char *buf,
>  		      int len);
> -extern void line_put_char(struct tty_struct *tty, unsigned char ch);
> +extern int line_put_char(struct tty_struct *tty, unsigned char ch);
>  extern void line_set_termios(struct tty_struct *tty, struct ktermios * old);
>  extern int line_chars_in_buffer(struct tty_struct *tty);
>  extern void line_flush_buffer(struct tty_struct *tty);

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
