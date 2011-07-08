Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qf8YS-0004M7-WE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jul 2011 10:45:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qf8YR-0004sV-Pi
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jul 2011 10:45:04 +0000
From: Richard Weinberger <richard@nod.at>
Date: Fri, 8 Jul 2011 12:44:53 +0200
References: <1310056562.3528.49.camel@vivanov>
	<201107071927.16237.richard@nod.at>
	<CAGTPOqfe8JxMsOru=pydy6ofEi0Ax-N=W_2UZwq5y=grrTemhQ@mail.gmail.com>
In-Reply-To: <CAGTPOqfe8JxMsOru=pydy6ofEi0Ax-N=W_2UZwq5y=grrTemhQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201107081244.53433.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH 1/3] uml: drivers/net_user.c memory leak fix
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Am Freitag 08 Juli 2011, 12:30:56 schrieb Vitaliy Ivanov:
> On Thu, Jul 7, 2011 at 8:27 PM, Richard Weinberger <richard@nod.at> wrote:
> > Am Donnerstag 07 Juli 2011, 18:36:02 schrieb Vitaliy Ivanov:
> >> >From 9b9f36f46aa708c3245f5ded83f96421966b2edf Mon Sep 17 00:00:00 2001
> >> 
> >> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> Date: Thu, 7 Jul 2011 19:23:13 +0300
> >> Subject: [PATCH 1/3] uml: drivers/net_user.c memory leak fix
> >> 
> >> Perform memory cleanup on exit.
> >> On receiving invalid 'pid' we still should clean 'output' variable.
> >> 
> >> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> ---
> >>  arch/um/drivers/net_user.c |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
> >> index 9415dd9..989b653 100644
> >> --- a/arch/um/drivers/net_user.c
> >> +++ b/arch/um/drivers/net_user.c
> >> @@ -228,10 +228,11 @@ static void change(char *dev, char *what, unsigned
> >> char *addr, "buffer\n");
> >> 
> >>       pid = change_tramp(argv, output, output_len);
> >> -     if (pid < 0) return;
> >> 
> >>       if (output != NULL) {
> >> -             printk("%s", output);
> >> +             if (pid >= 0) {
> >> +                     printk("%s", output);
> >> +             }
> >>               kfree(output);
> >>       }
> >>  }
> > 
> > This control logic is a bit strange.
> > When change_tramp() fails we should not printk() the output variable.
> > 
> > if (pid < 0){
> >  free(output);
> >  return;
> > }
> > 
> > Would be much cleaner.
> 
> I just didn't want to clone this free-return stuff. So, what you
> proposing is like this:
> ------------
> ...
>         output = uml_kmalloc(output_len, UM_GFP_KERNEL);
>         if (output == NULL)
>                 printk(UM_KERN_ERR "change : failed to allocate output "
>                        "buffer\n");
> 
>         pid = change_tramp(argv, output, output_len);
>         if (pid < 0) {
>                 free(output);               <---------- I'm not sure
> but 'output' can be NULL here.
>                 return;
>         }
> 
>         if (output != NULL) {
>                 printk("%s", output);
>                 kfree(output);
>         }
> }
> ------------
> 
> I was trying to print 'output' only in case change_tramp is
> successful. That's the old logic. And at the same time perform free
> only in case output is not NULL.

Why?
Freeing a NULL pointer is perfectly fine.

Thanks,
//richard

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

