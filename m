Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C57Ys-0004SO-PQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 11:52:54 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C57Yr-00025z-UY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 11:52:54 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
References: <BACKUPJQjdF8qoH28Db000022d5@NOSPAM.BRITSYS.NET>
	<413E5265.2080001@britsys.net>
In-Reply-To: <413E5265.2080001@britsys.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082009.51059.blaisorblade_spam@yahoo.it>
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
Date: Wed, 8 Sep 2004 20:09:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: David Jeffery <djeffery@britsys.net>, ralston@stral.net

On Wednesday 08 September 2004 02:29, David Jeffery wrote:
> Michael Ralston wrote:
> >I've been testing out this patch...
> >
> >It seems it allows me to start a uml-2.6.8.1 with SKAS using libc6-2.3.2.
> >I'm not sure if programs that make use of NPTL are running correctly
> > though.
>
> It depends on what part of pthreads the programs use.  My patch only
> fixes basic thread creation.  If you run the pthread test suite from
> LSB, you'll find there is alot still broken.  Sorry for my patch
> sounding more impressive than it was.  The few pthread things I ran work
> but they didn't make extensive use of the nptl's pthread features.  I'm
> going to try and look at what's broken but no guarantees I'll know how
> to fix it.
Ok, now that seems reasonable.

The biggest problem are these two syscalls (this is a quote from 
arch/um/kernel/sys_call_table.c):

        [ __NR_set_thread_area ] (syscall_handler_t *) sys_ni_syscall,
        [ __NR_get_thread_area ] (syscall_handler_t *) sys_ni_syscall,

We've always been knowing that the problem is setting the TLS space - on i386 
you do it by allocating a memory area for each thread and setting a reference 
to it(to change on thread switching) in the GDT (a special memory area 
handled by the CPU).
However, it should be possible to make them work - see modify_ldt 
implementation in SKAS mode to understand how.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
