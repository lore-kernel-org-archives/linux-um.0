Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9SuO-000122-Ed for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:29:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C9SuL-0003wF-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:29:03 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.4.26 and strstr
References: <20862.1095640178@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <20862.1095640178@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409202026.05960.blaisorblade_spam@yahoo.it>
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
Date: Mon, 20 Sep 2004 20:26:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Monday 20 September 2004 02:29, Michael Richardson wrote:
> I recently moved from 2.4.19 for the Openswan regression tests to
> 2.4.26. (a number of kernels in between were just not as stable)

> I encountered a problem with strstr(). It was no longer available
> to modules. It did link okay when I built our code statically.. I don't
> know that is because it was linking (incorrectly) against libc, or what.
No, that is not incorrect, for UML - at least it has always done things that 
way. So it should suffice adding EXPORT_SYMBOL (and not EXPORT_SYMTAB) in the 
right place (see below).

However, in this particular case, you should just edit 
arch/um/kernel/user_ksyms.c and uncomment those EXPORT_SYMBOL at the top of 
the file. Don't care about the comment "they caused problem", it's not true 
in my experience.

> strstr() is an hand assembled in arch/i386/lib/strstr.c.
> As far as I can see, there is nothing to build any of the code there.

> I think that the answer is that arch/um/sys-i386 should have strstr.c
> added to the Makefile, but I'm far from sure on this. In particular,
> this does not seem to make the symbol available to modules.
> (yes, I threw EXPORT_SYMTAB in).

You mean EXPORT_SYMBOL, right? Remember to put it inside a file listed in 
export-objs in its Makefile (which means that you should put it inside 
arch/um/kernel/ksyms.c, or arch/um/sys-i386/ksyms.c).

> {I don't honestly know why this routine isn't inlined with the rest of
>  the string.h routines.}


> marajade-[openswan-2/nightly/UMLPOOL/plain] mcr 1019 %diff -u
> arch/um/sys-i386/Makefile~ arch/um/sys-i386/Makefile ---
> arch/um/sys-i386/Makefile~  2004-09-15 15:44:43.000000000 -0400 +++
> arch/um/sys-i386/Makefile   2004-09-19 20:23:27.000000000 -0400 @@ -6,15
> +6,16 @@
>  O_TARGET = built-in.o
>
>  obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o ptrace.o \
> -       ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o
> +       ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o strstr.o
>  export-objs = ksyms.o
>
>  USER_OBJS = bugs.o ptrace_user.o sigcontext.o fault.o

> -SYMLINKS = semaphore.c extable.c
> +SYMLINKS = semaphore.c extable.c strstr.c

>  semaphore.c-dir = kernel
>  extable.c-dir = mm
> +strstr.c-dir = lib

Bye
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
