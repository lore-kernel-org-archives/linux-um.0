Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC80L-0007zD-5X for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 19:18:29 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DC80J-0002U5-LC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 19:18:28 -0800
Received: by rproxy.gmail.com with SMTP id 40so11115rnz
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Mar 2005 19:18:27 -0800 (PST)
Message-ID: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Can't compile under vanilla 2.6.11
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
Date: Fri, 18 Mar 2005 16:18:25 +1300
To: UML Developer <user-mode-linux-devel@lists.sourceforge.net>

Hi there,

I've been watching the discussion around 2.6.11 and reading the
archives and I can't find the information with any clarity that I
need. My problem is that I can't get UML to compile. I can on 2.4.27
(with the standard patches) and with 2.6.10 also.

My environment is Debian Woody with 2.4.27 kernel. My gcc version is
2.95.4. I am using default options when I do 'make menu_config
ARCH=um'

Here is the error that I am experiencing once I do 'make linux ARCH=um':
arch/um/kernel/sys_call_table.c:277: duplicate array index in initializer
arch/um/kernel/sys_call_table.c:277: (near initialization for `sys_call_table')
arch/um/kernel/sys_call_table.c:277: duplicate array index in initializer
arch/um/kernel/sys_call_table.c:277: (near initialization for `sys_call_table')

The code at line 277 is:
       ARCH_SYSCALLS
       [ LAST_SYSCALL + 1 ... NR_syscalls ] =
               (syscall_handler_t *) sys_ni_syscall

I don't quite understand this as it surpasses my C knowledge but if I
do a dirty hack and change this to:

       [ LAST_SYSCALL + 1 ... NR_syscalls ] =
               (syscall_handler_t *) sys_ni_syscall

i.e. remove ARCH_SYSCALS it compiles.

However when it goes to finish off and link I then get this error message
arch/um/kernel/built-in.o: In function `do_buffer_op':
arch/um/kernel/built-in.o(.text+0xcf4a): undefined reference to `va_copy'
arch/um/kernel/built-in.o(.data+0x1570): undefined reference to `sys_vserver'

and I don't have a linux kernel.

Can anybody point me in the right direction?

Regards,

Ian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
