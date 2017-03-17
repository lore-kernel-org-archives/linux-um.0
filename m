Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1covvV-0000lN-5s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:44:33 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1covvU-0005LI-Bj
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:44:33 +0000
References: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
	<CAFLxGvx0zpqgbp49DxQ_V8bxLGRKw6ziYstqK7hzcqUUvXuajQ@mail.gmail.com>
	<92e57cd0-8ef6-445d-ec61-a79a6f7a6da8@kot-begemot.co.uk>
	<9f1f1741-76ac-bff7-276b-76167c2bca51@nod.at>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <5b5d5162-13b0-be10-ab12-7e5b32e7f032@kot-begemot.co.uk>
Date: Fri, 17 Mar 2017 17:44:25 +0000
MIME-Version: 1.0
In-Reply-To: <9f1f1741-76ac-bff7-276b-76167c2bca51@nod.at>
Subject: Re: [uml-devel] UML regression with latest RC 4.11-rc2
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
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 17/03/17 17:33, Richard Weinberger wrote:
> Am 17.03.2017 um 18:04 schrieb Anton Ivanov:
>> On 17/03/17 16:56, Richard Weinberger wrote:
>>> Anton,
>>>
>>> On Fri, Mar 17, 2017 at 8:51 AM, Anton Ivanov
>>> <anton.ivanov@kot-begemot.co.uk> wrote:
>>>> Hi list, hi Richard
>>>>
>>>> There is an extra check in mm/mmap.c which now throws a WARN on every
>>>> page in making UML unusable with the latest 4.11-rc2
>>> Which WARN? Can you find the offending commit?
>> mm/mmap.c line 1112
> Okay, this triggers since:
>
> commit e86f15ee64d8ee46255d964d55f74f5ba9af8c36
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Oct 7 17:01:28 2016 -0700
>
>     mm: vma_merge: fix vm_page_prot SMP race condition against rmap_walk
>
> But you have to enable VM debugging to see it.

I have most debugging enabled to make sure I do not introduce any
re-entrancy in the IRQ handlers and/or have any allocations of the wrong
type where they do not belong.

We should probably submit a short patch #ifdef to turn this WARN() off
for UML

Brgds,

A.

>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

