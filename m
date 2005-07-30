Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dywdo-0002ki-63	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:05:00 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1Dywdk-0006Ca-FI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:05:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] NPTL pthread_create() cannot work.
References: <AD266326EC54D9118CE700110A9E2BE205C830AA@zch07exm01.corp.mot.com>
In-Reply-To: <AD266326EC54D9118CE700110A9E2BE205C830AA@zch07exm01.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302055.43880.blaisorblade@yahoo.it>
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
Date: Sat, 30 Jul 2005 20:55:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Zhu Tom-a2289c <A2289c@motorola.com>

On Friday 29 July 2005 13:12, Zhu Tom-a2289c wrote:
> Dear all,

> I am using patch 
> <http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/uml-2.6.1
>2-rc4-bb-20050521-18:54/uml-2.6.12-rc4-bb-20050521-18:54.patch.bz2>
> uml-2.6.12-rc4-bb-20050521-18:54.patch.bz2 on kernel 2.6.12-rc4. but found
> pthread_create() cannot work.

> it seems, in copy_thread() in arch/um/kernel/process_kern.c, the ret
> value's setting is not correct
Yes, I already fixed that recently - that patch is a development one and 
you're the first tester I heard of.

> int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
>   unsigned long stack_top, struct task_struct * p,
>   struct pt_regs *regs)
> {
>  int ret;
>
>  p->thread = (struct thread_struct) INIT_THREAD;
>  ret = CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,
>     clone_flags, sp, stack_top, p, regs);
>
>  if (ret || !current->thread.forking)
>   goto out;
>
>  clear_flushed_tls(p);
>
>  if (UPT_ESI(&current->thread.regs.regs) != UPT_ESI(&p->thread.regs.regs))
>   printk(KERN_DEBUG "newtls_new %x,old %x\n", (unsigned int)
> UPT_ESI(&current->thread.regs.regs), (unsigned int)
> UPT_ESI(&p->thread.regs.regs));
>
>  /*
>   * Set a new TLS for the child thread?
>   */
>  if (clone_flags & CLONE_SETTLS) {
>   struct user_desc info;
>   int idx;
>
>   ret = -EFAULT;
>   if (copy_from_user(&info, (void __user
> *)UPT_ESI(&current->thread.regs.regs), sizeof(info))) goto out;
>   ret = -EINVAL;
>   if (LDT_empty(&info))
>    goto out;
>
>   idx = info.entry_number;
>
>   set_tls_entry(p, &info, idx, 0);
>  }
>
> out:
>  return ret;
> }
>
>
> I add a "ret=0;" after set_tls_entry(p, &info, idx, 0);

> after it, pthread_create() can return correctly, but the new thread cannot
> be scheduled correctly. there is always a "Segment Fault".
I've succeeded in fixing even this...
> I am using libc 2.3.3 and libc 2.3.4.
>
> Note:
> on 2.3.2, no "Segment Fault", it looks good.
Is that compiled with NPTL / TLS support? Has 2.3.2 any TLS support at all?
> Has anyone had a test of NPTL on UML?
Currently it is known not to work, but I'm working on fixing that.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
