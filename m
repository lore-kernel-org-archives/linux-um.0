Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UOspR-000620-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 16:52:29 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UOspN-0007L3-VO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 16:52:29 +0000
Received: by mail-wi0-f179.google.com with SMTP id hn17so1898668wib.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 07 Apr 2013 09:52:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
Date: Sun, 7 Apr 2013 18:52:19 +0200
Message-ID: <CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
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

On Sat, Apr 6, 2013 at 9:23 PM, Terry Hsu <terry.shoes@gmail.com> wrote:
> Is there any available resource that explains how user-mode-linux maps the
> pages of a task in UML to the host kernel?

The code...? ;)
UML receives a SIGEGV on the host side if a page is not mapped.
The SIGEGV handler then installs the mapping using mmap().

> In my UML, I modified a task's page table when forking it. Then I ran into a
> situation where the page fault happens over and over again for the same
> address in the forked task. I use gdb debugger and find out that when the
> page fault happens for the first time, the kernel calls do_wp_page() to
> fault in the page and marks the page present. This should prevent the next
> page fault for the same address from happening again. I checked the PTE in
> UML, they are marked as present so is it possible that the page is not being
> allocated properly on the host kernel so that the page fault keeps happening
> for the same address even though UML thinks the page is present.
>
> Any suggestions?

If the same fault happens over and over UML (on the host side) seems
unable to fix the fault.
Check the return values of mmap()....

Thanks,
//richard

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

