Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1KvSwF-0007Xj-Sj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 08:31:31 +0000
Received: from monty.telenet-ops.be ([195.130.132.56])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KvSw6-0006MN-8t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 08:31:31 +0000
Date: Thu, 30 Oct 2008 09:31:04 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <804dabb00810291851xc617690wac1404176437fb84@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0810300925590.4898@anakin>
References: <804dabb00810291851xc617690wac1404176437fb84@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel]
	=?windows-1252?q?=22warning=3A_passing_argument_1_of_?=
	=?windows-1252?q?=91um=5Fexecve=92_discards_qualifiers_from_pointer_targe?=
	=?windows-1252?q?t_type=22?=
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
To: Peter Teoh <htmldeveloper@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 30 Oct 2008, Peter Teoh wrote:
> While compiling the latest 2.6.28-rc2 (make linux ARCH=um O=uml):
> 
>   CC      arch/um/kernel/syscall.o
> /hdc1/download/2.6/linux26-acer/arch/um/kernel/syscall.c: In function
> 'kernel_execve':
> /hdc1/download/2.6/linux26-acer/arch/um/kernel/syscall.c:130: warning:
> passing argument 1 of 'um_execve' discards qualifiers from pointer
> target type
> /hdc1/download/2.6/linux26-acer/arch/um/kernel/syscall.c:130: warning:
> passing argument 2 of 'um_execve' discards qualifiers from pointer
> target type
> /hdc1/download/2.6/linux26-acer/arch/um/kernel/syscall.c:130: warning:
> passing argument 3 of 'um_execve' discards qualifiers from pointer
> target type
> u  CC      arch/um/kernel/sysrq.o
>   CC      arch/um/kernel/time.o
> 
> snip
> 
>   CC      kernel/trace/trace.o
> /hdc1/download/2.6/linux26-acer/kernel/trace/trace.c: In function
> 'tracing_generic_entry_update':
> /hdc1/download/2.6/linux26-acer/kernel/trace/trace.c:659: error:
> implicit declaration of function 'irqs_disabled_flags'
> make[3]: *** [kernel/trace/trace.o] Error 1
> make[2]: *** [kernel/trace] Error 2
> make[1]: *** [kernel] Error 2
> make: *** [sub-make] Error 2
> 
> The .config as per attached.

I see there are no UML builds yet on
http://kisskb.ellerman.id.au/kisskb/matrix/.
Perhaps it would be a good idea to add them?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
