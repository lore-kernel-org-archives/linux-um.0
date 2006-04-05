Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FREUj-000672-ER for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 13:20:49 -0700
Received: from nproxy.gmail.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FREUi-0000fM-OB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 13:20:49 -0700
Received: by nproxy.gmail.com with SMTP id b2so1406475nfe
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 05 Apr 2006 13:20:45 -0700 (PDT)
Message-ID: <b54af0b00604051320l54bab57ag311746325c887d7f@mail.gmail.com>
From: "Olivier Crameri" <olivier.crameri@gmail.com>
Reply-To: olivier.crameri@epfl.ch
Subject: Re: [uml-devel] system call accessing the host os
In-Reply-To: <20060405181812.GA5684@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
	<20060405181812.GA5684@ccure.user-mode-linux.org>
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
Date: Wed, 5 Apr 2006 22:20:44 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thanks for the answer. I bumped CONFIG_KERNEL_STACK_ORDER to 3, but it
doesn't help.

I have a system call that does nothing but execute my code to parse my
file in the host.
When I said that using malloc didn't work, I meant the following: I'm
using malloc to allocate a buffer in the UML kernel. I'm not passing a
user level buffer to the system call. Then, when I use fread to read
my file into this buffer, if I read a small number of bytes, it works.
However when I try to fread the entire file (38k), fread returns 0.
The same thing using a buffer returned by um_kmalloc works perfectly
(i.e. returns 1 and the buffer is filled with the file data).

Later on, I use sscanf to parse my buffer. No matter what happens,
sscanf returns 0, which is wrong even if there is no error. The exact
same code compiled in the host works perfectly.

Again, thank you for your help, I really appreciate.
Olivier

On 4/5/06, Jeff Dike <jdike@addtoit.com> wrote:
> On Wed, Apr 05, 2006 at 07:16:22PM +0200, Olivier Crameri wrote:
> > Unfortunately, I'm having some weird issues that I can't really
> > understand. I can read the file using fread, but only in a buffer
> > that I allocated using um_kmalloc. If I use a buffer allocated by
> > malloc, the fread fails. Then, even if I replace all  my mallocs by
> > um_kmallocs, some libc functions (such as sscanf) don't seem to work
> > properly. I guess I'm missing something, but I can't figure out what.
>
> Define "fails" and "don't seem to work properly".
>
> If your buffers are larger than 128K, then libc malloc gets turned into
> UML kernel vmalloc.  In this case, the buffer isn't mapped, and
> passing it into a system call will make it return -EFAULT.  The
> easiest workaround for this is to memset the thing immediately after
> allocating it.
>
> Also, if you're using the libc things you're talking about, watch out
> for your stack consumption.  By default, you get two pages (8K).
> printf will completely use it up, so it is unusable in kernel code.
>
> UML kernel stack size is configurable - CONFIG_KERNEL_STACK_ORDER -
> bumping that to 3 will double the kernel stack size.  If problems then
> go away, then you know that libc is overflowing your stack.
>
>                                 Jeff
>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
