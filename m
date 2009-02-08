Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LW5dE-0006cO-5c
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 09:07:16 +0000
Received: from mail-gx0-f28.google.com ([209.85.217.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LW5dA-0006zS-39 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Feb 2009 09:07:16 +0000
Received: by gxk9 with SMTP id 9so801592gxk.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Feb 2009 01:07:10 -0800 (PST)
Date: Sun, 8 Feb 2009 17:07:10 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090208090642.GA383@hack.private>
References: <200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
	<49753063.8040007@hathawaymix.org>
	<alpine.LRH.2.00.0902041803360.7690@vixen.sonytel.be>
	<Pine.LNX.4.64.0902042115530.25136@anakin>
	<20090204204009.GA10680@suse.de>
	<Pine.LNX.4.64.0902042150550.25136@anakin>
	<20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Greg KH <gregkh@suse.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@ZenIV.linux.org.uk>, Rob Landley <rob@landley.net>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Shane Hathaway <shane@hathawaymix.org>, Daolong Wang <ahlongxp@gmail.com>, stable@kernel.org


I am sorry for the delay.

On Sat, Feb 07, 2009 at 12:59:56PM +0100, Heiko Carstens wrote:
>On Wed, 4 Feb 2009 21:54:12 +0100 (CET)
>Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> I verified that Shane's solution:
>> 
>> #define sys_sigprocmask sys_kernel_sigprocmask
>> 
>> works for me, but that's definitely not the cleanest way.
>> 
>> Al Viro also had a suggestion to rework the SYSCALL_DEFINE* macros, but I
>> haven't tried it yet.
>
>
>Patch below should fix it.
>
>
>Subject: [PATCH] syscall define: fix uml compile bug
>
>From: Heiko Carstens <heiko.carstens@de.ibm.com>
>
>With the new system call defines we get this on uml:
>
>arch/um/sys-i386/built-in.o: In function `sys_call_table':
>(.rodata+0x308): undefined reference to `sys_sigprocmask'
>
>Reason for this is that uml passes the preprocessor option
>-Dsigprocmask=kernel_sigprocmask to gcc when compiling the kernel.
>This causes SYSCALL_DEFINE3(sigprocmask, ...) to be expanded to
>SYSCALL_DEFINEx(3, kernel_sigprocmask, ...) and finally to a system call
>named sys_kernel_sigprocmask. However sys_sigprocmask is missing because
>of this.


Hmmm, thanks for analysis this.

I found my mistake, I thought the Makefile invokes the 'strip' command
to do replacement, but it is not, Makefile has a built-in command named
strip. Sorry for this.

Then the problem is fully from preprocessing.


>To avoid macro expansion for the system call name just concatenate the
>name at first define instead of carrying it through severel levels.
>This was pointed out by Al Viro.
>

Yes, indeed!


>Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>


Your patch should fix this problem. But... see below.


> 	}								\
>-	SYSCALL_ALIAS(sys_##name, SyS_##name);				\
>-	static inline long SYSC_##name(__SC_DECL##x(__VA_ARGS__))
>+	SYSCALL_ALIAS(sys##name, SyS##name);				\
>+	static inline long SYSC##name(__SC_DECL##x(__VA_ARGS__))

So your final actual name for a syscall 'foo' will be 'sysfoo'
instead of 'sys_foo', right?

But we have lots of explicit calls to something like sys_foo,
won't your patch break them?


-- 
"Against stupidity, the gods themselves, contend in vain."


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
