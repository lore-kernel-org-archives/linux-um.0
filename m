Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8iiq-0004zO-JC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:10:04 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C8iip-0005Dp-Ts for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:10:04 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls
References: <8B6FF516CBA0194AB0996705076B02520F7C33@ABGEX01E.abg.fsc.net>
In-Reply-To: <8B6FF516CBA0194AB0996705076B02520F7C33@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181817.10308.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Sep 2004 18:17:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>

On Friday 17 September 2004 19:46, Stroesser, Bodo wrote:
> If a program is traced or debugged, in 2.6.x interrupted systemcalls
> with the results -ERESTARTxxxxxxx are not handled correctly, no
> systemcall restart is done.
>
> Here is a patch that should fix the problem. The patch is tested on
> 2.6.6 in tt and skas modes. It applies to 2.6.8.1, but I've not tested
> yet.
>
> Hope, this helps.

I read the patch a bit and I understand and agree on most changes; nice job, 
mostly. However, I don't like at all the changes to 
arch/um/kernel/signal_kern.c.

Could you explain them in more detail, and clean up this part of the patch? 
Comments come below.

> -- uml_orig/arch/um/kernel/signal_kern.c 2004-08-05 18:36:24.000000000 +0200
> +++ uml/arch/um/kernel/signal_kern.c      2004-09-17 15:03:30.441065600 
+0200
> @@ -132,19 +132,18 @@
>  {
>       siginfo_t info;
>       struct k_sigaction *ka;
> -     int err, sig;
> +     int sig;
> 
>       if (!oldset)
>             oldset = &current->blocked;
> 
>       sig = get_signal_to_deliver(&info, regs, NULL);
> -     if(sig == 0)
> -           return(0);

Could you explain why the sig == 0 check must be dropped? I went reading 
get_signal_to_deliver and sig == 0 seems to mean that no signal is available. 
(But I don't understand what "current->notifier" is, but it does not seem 
related to syscall restarting).

> -
> -     /* Whee!  Actually deliver the signal.  */
> -     ka = &current->sighand->action[sig -1 ];
> -     err = handle_signal(regs, sig, ka, &info, oldset, error);

Why do you drop the handling of errors from handle_signal()? If you do this to 
workaround handle_signal() bugs in handling -ERESTART*, fix handle_signal(); 
there are other errors that it can return, and that you must handle.

> -     if(!err) return(1);
> +     if(sig > 0) {
> +           /* Whee!  Actually deliver the signal.  */
> +           ka = &current->sighand->action[sig -1 ];
> +           handle_signal(regs, sig, ka, &info, oldset, error);
> +           return(1);
> +     }
> 
>       /* Did we come from a system call? */
>       if(PT_REGS_SYSCALL_NR(regs) >= 0){

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
