Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1WgA5H-0005n8-Mw
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 09:48:47 +0000
Received: from mail-yh0-f42.google.com ([209.85.213.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WgA5G-0008TU-RN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 09:48:47 +0000
Received: by mail-yh0-f42.google.com with SMTP id f73so3986287yha.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 May 2014 02:48:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd7386ea80ce1fd3e5a864966b3b5e80@nixia.no>
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
	<5362651A.1020504@gmx.de> <5362B53E.5060601@nod.at>
	<dd7386ea80ce1fd3e5a864966b3b5e80@nixia.no>
Date: Fri, 2 May 2014 11:48:41 +0200
Message-ID: <CAFLxGvw4R-hi2j2beE6YGbMHX-eNMoA4TdHMv2rNwSnEePAynA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] trinity commit 23dc478aba breaks syscall "mremap"
 at a 32 bit user mode linux
To: Stian Skjelstad <stian@nixia.no>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, May 2, 2014 at 8:43 AM,  <stian@nixia.no> wrote:
>> Yeah, this is because trinity destroys the UML stub code.
>> Please test the attached patch, it should fix the root cause of the
>> problem.
>
> @@ -124,6 +125,9 @@ static int add_munmap(unsigned long addr, unsigned
> long len,
>         struct host_vm_op *last;
>         int ret = 0;
>
> +       if ((addr >= STUB_START) && (addr < STUB_END))
> +               return -EINVAL;
> +
>         if (hvc->index != 0) {
>                 last = &hvc->ops[hvc->index - 1];
>                 if ((last->type == MUNMAP) &&
>
> I do not know how add_munmap is called, so this is more of a question.
> What happens in the use cases where the mmap spans multiple pages, and
> the stub is in the middle and other variations?

add_munmap() is only called on existing mappings.
UML ensures that we have always a mapping at STUB_START.
Doing a mremap() or munmap() i.e. on STUB_START - 4096 won't trigger
the add_munmap().

It is also not possible to create an overlapping map over the STUB.
update_pte_range() makes this impossible.

If you find a way to bypass this, please drop me a mail.
The UML TLB code is not trivial and also not written by me.
Maybe I've overlooked something. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

