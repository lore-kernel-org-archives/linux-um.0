Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CySWn-00020a-8h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 02:23:29 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CySWj-0006Ju-CL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 02:23:29 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081122.22613.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't compile
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
Date: Tue, 8 Feb 2005 11:22:22 +0100
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 February 2005 11:09, Anton Altaparmakov wrote:
> Hi,
>
> With the current linux-2.6 BK tree I get this when trying to compile
> UML:
>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/um/kernel/built-in.o(__ksymtab+0x2b0): In function `um_execve':
> arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> /bin/bash: line 1: 26161 Exit 1                  nm -n .tmp_vmlinux1
>      26162 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
> make: *** [.tmp_kallsyms1.S] Error 139
>
> This is with SKAS mode enabled and TT disabled.  My .config is attached.

Hmm - I do not understand at all where `__bb_init_func' comes from (not from 
UML by sure, only from kernel headers possibly). And from preprocessing the 
source (of the -bk4 snapshot), nothing similar comes out.

long um_execve(char *file, char * *argv, char * *env)
{
 long err;

 err = execve1(file, argv, env);
 if(!err)
  do_longjmp((current_thread_info()->task)->thread.exec_buf, 1);
 return(err);
}

make arch/um/kernel/exec_kern.i ARCH=um

grep bb_init arch/um/kernel/exec_kern.i
gives nothing (tested with your config, too).

Try adding a "#undef execve1" before the problematic line, and reporting (here 
I don't get the failure).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
