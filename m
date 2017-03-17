Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: WARNING: CPU: 0 PID: 1 at mm/mmap.c:1110 vma_merge+0x9a/0x2c8
References: <b579ab24-7032-9322-fc8d-671c25d802d6@nod.at>
 <20170317183635.GC28995@redhat.com>
Message-ID: <0f49aa0a-0249-8be2-6010-dc816afb40d0@nod.at>
Date: Fri, 17 Mar 2017 23:51:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170317183635.GC28995@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: adityam@microsoft.com, Rik van Riel <riel@redhat.com>, hughd@google.com, mgorman@techsingularity.net, janvorli@microsoft.com, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

[re-sending with mailinglists]

Andrea,

Am 17.03.2017 um 19:36 schrieb Andrea Arcangeli:
> I think the problem is in setup_arg_pages that is making an assumption
> non true in UML (and only UML) case, i.e. that there are no vmas below
> bprm->vma by the time mprotect_fixup is executed. That is not the case
> for UML as you likely installed vmas below bprm->vma before calling
> mprotect_fixup in setup_arg_pages. The fix should be just to change
> setup_arg_pages to find the correct "prev" vma, then this code will
> pick "area" as prev->vm_next which is bprm->vma as expected:
> 
> 	if (prev)
> 		next = prev->vm_next;
> 	else
> 		next = mm->mmap;
> 	area = next;
> 
> *prev == NULL tells vma_merge that the only vma that there is is
> mm->mmap so it uses that as "area" but for you mm->mmap is prev or
> prev->prev or something like that, not the "area". To make it find the
> right area you need to pass the right *prev to mprotect_fixup if there
> are real "prev" vmas not just bprm->vma instantiated.

I think you are right, thanks for the great explanation!

UML installs this vma very early and as of now I'm not sure why we can't
install it a bit later just like we do for the vDSO.
So far it did not explode. :)
This solution would be better than finding a pre-existing vma before
calling mprotect_fixup().

Thanks,
//richard

