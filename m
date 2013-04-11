Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UQHBa-0008Q3-N6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 13:05:06 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UQHBZ-0000hY-SV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Apr 2013 13:05:06 +0000
Received: by mail-wi0-f179.google.com with SMTP id hn17so523795wib.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Apr 2013 06:04:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<CAER6Ckd0bH6epErKnu-NBdf6S=wc7FrY68eLmxZVRmDptK2gEg@mail.gmail.com>
Date: Thu, 11 Apr 2013 15:04:59 +0200
Message-ID: <CAFLxGvw=d7a5kFEMd921rWx6SFptnkFkXGKwPSMBxaobHLepug@mail.gmail.com>
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

On Thu, Apr 11, 2013 at 6:15 AM, Terry Hsu <terry.shoes@gmail.com> wrote:
> Hi Richard, thanks for replying. I did go back to see the code and try to
> understand what exactly is going on in UML, but still no luck.
>
> The faulted address is covered by one of the vm areas of the task, so it
> passed the vma sanity check at the beginning of handle_page_fault(). I print
> out the PTEs of the task and I notice one strange thing: when the fault
> happens for the first time, the PTE does not exist; the PTE is present when
> the second fault happens for the same address (but still a page fault); in
> the third page fault (same address), the PTE does not exist anymore.
>
> So in my case, the faulted address does not require a new vma to be
> installed.

But this is a feature added by you?
We are not talking about a mainline kernel, right?

> Also I've looked into copy_mm() to see how pages are copied from parent task
> to its child. I do not understand the purpose of the  the special mapping
> installed by UML. It seems that every new task with a new mm_struct will
> have one special mapping at the head of its vma list.

The special mapping (the SKAS stub) is needed to install new mapping
from the host
side of UML.
Currently the stub pages have a vma, this will go away such that they
have only a PTE.

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

