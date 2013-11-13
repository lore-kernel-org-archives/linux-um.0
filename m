Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VgWPw-0007CG-R3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Nov 2013 09:07:20 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VgWPv-00046u-55
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Nov 2013 09:07:20 +0000
Message-ID: <52834138.7050005@nod.at>
Date: Wed, 13 Nov 2013 10:07:04 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <alpine.LNX.2.00.1310150330350.9078@eggly.anvils>
	<528308E8.8040203@asianux.com>
In-Reply-To: <528308E8.8040203@asianux.com>
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
Subject: Re: [uml-devel] [PATCH] arch: um: kernel: skas: mmu: remove
 pmd_free() and pud_free() for failure processing in init_stub_pte()
To: Chen Gang <gang.chen@asianux.com>, Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, uml-user <user-mode-linux-user@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

Am 13.11.2013 06:06, schrieb Chen Gang:
> Unfortunately, p?d_alloc() and p?d_free() are not pair!! If p?d_alloc()
> succeed, they may be used, so in the next failure, we have to skip them
> to let exit_mmap() or do_munmap() to process it.
> 
> According to "Documentation/vm/locking", 'mm->page_table_lock' is for
> using vma list, so not need it when its related vmas are detached or
> unmapped from using vma list.
> 
> The related work flow:
> 
>   exit_mmap() ->
>     unmap_vmas(); /* so not need mm->page_table_lock */
>     free_pgtables();
> 
>   do_munmap()->
>     detach_vmas_to_be_unmapped(); /* so not need mm->page_table_lock */
>     unmap_region() ->
>       free_pgtables();
> 
>   free_pgtables() ->
>     free_pgd_range() ->
>       free_pud_range() ->
>         free_pmd_range() ->
>           free_pte_range() ->
>             pmd_clear();
>             pte_free_tlb();
>           pud_clear();
>           pmd_free_tlb();
>         pgd_clear(); 
>         pud_free_tlb();
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Sounds reasonable to me.
*But* there are patches you from out there that tried to fix similar issues and got reverted later.
Now I'm a bit nervous and want a ACK from mm folks to have this verified.
It's not that I don't trust you, but I really don't trust you. ;-)

Thanks,
//richard

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

