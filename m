Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM5RM-00068i-6V for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:03:16 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM5RK-0007eU-GL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 07:03:16 -0700
Message-ID: <417D0967.7090909@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Unknown symbols
References: <41795C77.1070101@fujitsu-siemens.com>
	<200410230316.17757.blaisorblade_spam@yahoo.it>
	<20041023030913.GA7740@ccure.user-mode-linux.org>
In-Reply-To: <20041023030913.GA7740@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Mon, 25 Oct 2004 16:10:47 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Sat, Oct 23, 2004 at 03:16:16AM +0200, BlaisorBlade wrote:
> 
>>>For end_iomem inserting a EXPORT_SYMBOLS in arch/um/kernel/um_arch.c seems
>>>to be enough.
>>
>>Yes, I guess. Send the resulting patch to Jeff - as a separate one.
> 
> 
> Those are userspace things, so they go in user_syms.c - that already has the
> export crap copied into it.
> 
> 				Jeff
OK. Here is the first patch. It handles end_iomem only. Since end_iomem is
located in arch_um.c, I prefered to put the EXPORT_SYMBOL into ksyms.c.

I hope, you agree.

The EXPORTs for vsyscall_* are included in a separate patch. It's mailed in
the vsyscall-thread, because it includes some improvement for vsyscall also.

---

diff -puNr a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
--- a/arch/um/kernel/ksyms.c	2004-10-18 23:53:08.000000000 +0200
+++ b/arch/um/kernel/ksyms.c	2004-10-25 14:23:32.811120267 +0200
@@ -48,6 +48,7 @@ EXPORT_SYMBOL(to_virt);
  EXPORT_SYMBOL(mode_tt);
  EXPORT_SYMBOL(handle_page_fault);
  EXPORT_SYMBOL(find_iomem);
+EXPORT_SYMBOL(end_iomem);

  #ifdef CONFIG_MODE_TT
  EXPORT_SYMBOL(strncpy_from_user_tt);


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
