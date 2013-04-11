Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UQOtg-0008Hs-Ft
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 21:19:08 +0000
Received: from mail-we0-f172.google.com ([74.125.82.172])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQOtf-0004we-Ni
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 21:19:08 +0000
Received: by mail-we0-f172.google.com with SMTP id r3so1610496wey.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Apr 2013 14:19:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6CkcWS1KUpxBqOh+6N36k8HhQT61OJ+d3N=H3tHygMos39Q@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
	<CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
	<CAER6CkcWS1KUpxBqOh+6N36k8HhQT61OJ+d3N=H3tHygMos39Q@mail.gmail.com>
Date: Thu, 11 Apr 2013 23:19:01 +0200
Message-ID: <CAFLxGvz8MX6YtAHU6w_hsUX_zDBwBspmUqA_1CjNBO1FxyFyBg@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: Terry Hsu <terry.shoes@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Apr 11, 2013 at 10:14 PM, Terry Hsu <terry.shoes@gmail.com> wrote:
> The page fault loop for the same address happens in my UML. But for both my
> UML and the mainline (I am using 3.7.1) kernel, the addresses that trigger
> the page fault (in the child thread) are covered by certain vm areas. I use
> gdb to trace the function call and notice that mmap_region() is never called
> during the execution of the child task. I am guessing it's because the child
> task does not use large enough memory space to have the UML installed
> mapping for it.

Okay, let's try to figure out what happens here.
The UML _guest_ process has some vmas installed, upon access the host
kernel finds
out that there is no memory mapping installed in the _host_ side of
UML and sends SIGSEGV
to the process. UML's host part catches the SIGSEGV and tries to fix it.
Usually it does so by mmap()'ing the faulting page into the UML guest process.
This is where the SKAS stub magic happens. It write the to be fixed
address into STUB_DATA
and sets EIP/RIP to STUB_CODE such that the process itself calls mmap().
After the stub has finished it traps itself and the UML emulation continues.

Now we need to figure out a) What address is faulting and why? b) What
does the UML _host_ side
code to fix it? i.e. What are the mmap() parameters? c) Does this mmap() fail?

To me it looks like UML is unable to fix the fault and therefore it
faults over and over again.

--
Thanks,
//richard

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

