Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 8 Jul 2011 17:42:07 +0200
References: <1310056562.3528.49.camel@vivanov> <201107081244.53433.richard@nod.at> <1310130044.26209.3.camel@vivanov>
In-Reply-To: <1310130044.26209.3.camel@vivanov>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201107081742.07840.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/3] uml: drivers/net_user.c memory leak fix
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag 08 Juli 2011, 15:00:44 schrieb Vitaliy Ivanov:
> > > > This control logic is a bit strange.
> > > > When change_tramp() fails we should not printk() the output variable.
> > > > 
> > > > if (pid < 0){
> > > > 
> > > >  free(output);
> > > >  return;
> > > > 
> > > > }
> > > > 
> > > > Would be much cleaner.
> > > 
> > > I just didn't want to clone this free-return stuff. So, what you
> > > proposing is like this:
> > > ------------
> > > ...
> > > 
> > >         output = uml_kmalloc(output_len, UM_GFP_KERNEL);
> > >         if (output == NULL)
> > >         
> > >                 printk(UM_KERN_ERR "change : failed to allocate output
> > >                 "
> > >                 
> > >                        "buffer\n");
> > >         
> > >         pid = change_tramp(argv, output, output_len);
> > >         if (pid < 0) {
> > >         
> > >                 free(output);               <---------- I'm not sure
> > >                 but 'output' can be NULL here. return;
> > >         
> > >         }
> > >         
> > >         if (output != NULL) {
> > >         
> > >                 printk("%s", output);
> > >                 kfree(output);
> > >         
> > >         }
> > > 
> > > }
> > > ------------
> > > 
> > > I was trying to print 'output' only in case change_tramp is
> > > successful. That's the old logic. And at the same time perform free
> > > only in case output is not NULL.
> > 
> > Why?
> > Freeing a NULL pointer is perfectly fine.
> 
> I should agree that something that you propose has better readability.
> 
> So, here is updated patch.
> 
> Thanks
> ---
> 
> >From b0c5ca0336cc94b2fda251e0da7918394e59c5cd Mon Sep 17 00:00:00 2001
> 
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> Date: Fri, 8 Jul 2011 14:54:29 +0300
> Subject: [PATCH] uml: drivers/net_user.c memory leak fix
> 
> Perform memory cleanup on exit.
> On receiving invalid 'pid' we still should clean 'output' variable.
> 
> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Why are you adding my Signed-off-by?!
That's my job...

> ---
>  arch/um/drivers/net_user.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
> index 9415dd9..5201188 100644
> --- a/arch/um/drivers/net_user.c
> +++ b/arch/um/drivers/net_user.c
> @@ -228,7 +228,10 @@ static void change(char *dev, char *what, unsigned
> char *addr, "buffer\n");
> 
>  	pid = change_tramp(argv, output, output_len);
> -	if (pid < 0) return;
> +	if (pid < 0) {
> +		kfree(output);
> +		return;
> +	}
> 
>  	if (output != NULL) {
>  		printk("%s", output);

Anyway, Applied!

Thanks,
//richard
