Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiVY-0001iU-73 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 11:05:40 -0800
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiVF-0001dY-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 11:05:40 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20050330190509.GA17602@kroah.com>
References: <20050330173348.63741EFE76@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330173348.63741EFE76@zion>
Subject: [uml-devel] Re: [stable] [patch 3/8] uml: quick fix syscall table
	[urgent]
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
Date: Wed, 30 Mar 2005 11:05:09 -0800
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:33:48PM +0200, blaisorblade@yahoo.it wrote:
> 
> CC: <stable@kernel.org>
> 
> *) Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
> duplicated, and that GCC does not accept this (unlike gcc 3). Plus various
> other bugs in the syscall table definitions:
> 
>   *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's a
>   valid syscall (thus a duplicated one).
> 
>   *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
>   times with different values!
> 
>   *) syscalls duplicated in SUBARCHs and in common files (thus assigning twice
>   to the same array entry and causing the GCC 2.95.4 failure mentioned above):
>   sys_utimes, which is common, and sys_fadvise64_64, sys_statfs64,
>   sys_fstatfs64, which exist only on i386.
> 
>   *) syscalls duplicated in each SUBARCH, to put in common files:
>   sys_remap_file_pages, sys_utimes, sys_fadvise64
> 
>   *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the range
>   does not arrive to that point.
> 
>   *) on x86_64, the macro name is __NR_kexec_load and not __NR_sys_kexec_load.
>   Use the correct name in either case.
> 
> Note: as you can see, part of the syscall table definition in UML is
> arch-independent (with everywhere defined syscalls), and part is
> arch-dependant. This has created confusion (some syscalls are listed in both
> places, some in the wrong one, some are wrong on one arch or another).
> 
> Also, as add-ons:
> 
> *) uses __va_copy instead of va_copy since some old versions of gcc (2.95.4
> for instance) don't accept va_copy.
> 
> *) some whitespace cleanups in the syscall table (if you don't like them, feel
> free to remove them).

For this to be considered for the -stable tree, can you remove the
whitespace cleanups, and break this up into different patches for the
different things you are doing (one thing per patch please.)

thanks,

greg k-h


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
