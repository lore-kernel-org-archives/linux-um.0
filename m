Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCS5N-0004Ee-7M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 16:45:01 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DCS5L-0002r3-15
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2005 16:45:00 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Can't compile under vanilla 2.6.11
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
In-Reply-To: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503181842.07824.rob@landley.net>
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
Date: Fri, 18 Mar 2005 18:42:07 -0500
To: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Thursday 17 March 2005 10:18 pm, Ian McDonald wrote:
> Hi there,
>
> I've been watching the discussion around 2.6.11 and reading the
> archives and I can't find the information with any clarity that I
> need. My problem is that I can't get UML to compile. I can on 2.4.27
> (with the standard patches) and with 2.6.10 also.
>
> My environment is Debian Woody with 2.4.27 kernel. My gcc version is
> 2.95.4. I am using default options when I do 'make menu_config
> ARCH=um'
>
> Here is the error that I am experiencing once I do 'make linux ARCH=um':
> arch/um/kernel/sys_call_table.c:277: duplicate array index in initializer
> arch/um/kernel/sys_call_table.c:277: (near initialization for
> `sys_call_table') arch/um/kernel/sys_call_table.c:277: duplicate array
> index in initializer arch/um/kernel/sys_call_table.c:277: (near
> initialization for `sys_call_table')
>
> The code at line 277 is:
>        ARCH_SYSCALLS
>        [ LAST_SYSCALL + 1 ... NR_syscalls ] =
>                (syscall_handler_t *) sys_ni_syscall

ARCH_SYSCALLS is defined in  arch/um/include/sysdep-i386/syscalls.h by the 
way...

In case you wanted to try to find which syscall was going "boing" for you...

grep is your friend. :)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
