Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRei8-0000zG-OA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 17:20:24 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FRei3-0007pY-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 17:20:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] system call accessing the host os
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
	<20060405181812.GA5684@ccure.user-mode-linux.org>
In-Reply-To: <20060405181812.GA5684@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604070220.01278.blaisorblade@yahoo.it>
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
Date: Fri, 7 Apr 2006 02:20:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Olivier Crameri <olivier.crameri@epfl.ch>

On Wednesday 05 April 2006 20:18, Jeff Dike wrote:
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
> UML kernel vmalloc.

No, I made it "greater than 4k" in 2.4.24 time... in fact it's what's 
happening to him (see his last mail):

void *__wrap_malloc(int size)
{
        void *ret;

        if(!CAN_KMALLOC())
                return(__real_malloc(size));
        else if(size <= PAGE_SIZE) /* finding contiguos pages can be hard*/
                ret = um_kmalloc(size);
        else ret = um_vmalloc(size);
}

128K is the maximum conceivable kmallocable size, but it hardly works due to 
fragmentation.

> In this case, the buffer isn't mapped, and 
> passing it into a system call will make it return -EFAULT.  The
> easiest workaround for this is to memset the thing immediately after
> allocating it.

> Also, if you're using the libc things you're talking about, watch out
> for your stack consumption.  By default, you get two pages (8K).

By default on UML you get 4 pages, 16K, i.e. PAGE_SIZE *  (1 << 
CONFIG_KERNEL_STACK_ORDER) == 4k * (1<<2) == 4k * 4.

> printf will completely use it up, so it is unusable in kernel code.

Indeed. sprintf() + write(1) works, instead - grep for my_printf in the source 
code, I've coded this hack up.

> UML kernel stack size is configurable - CONFIG_KERNEL_STACK_ORDER -
> bumping that to 3 will double the kernel stack size.  If problems then
> go away, then you know that libc is overflowing your stack.

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
