Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFax5-0000QS-7L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 09:17:11 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CFawo-0002aP-DG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 09:17:11 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Panic while core dumping in tt-mode
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C52@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Thu, 7 Oct 2004 18:13:37 +0200
Content-Transfer-Encoding: 8bit
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>

> Testing my extensions for vsyscall/sysenter I need to check the
presence of the vsyscall-page in the core. But in tt-mode the kernel
panics if core dump > is started. In copy_fpu_fxsave_tt() the line
> 
>   struct i387_fxsave_struct *fpu = SC_FXSR_ENV(PT_REGS_SC(regs));
> 
> sets fpu to 0x70, then memcpy() segfaults.
> Maybe the reason is in the new signal-delivery?
No, silly speculation! The real reason is, that in signal delivery
no fp-status is written and the pointer to the fp-status in the
signalcontext is set to NULL, if a thread had never used the fp-regs.
Easy to fix that, but what with the other issues:
- In skas fpregs never are dumped. (Instead random data is written
  to core)
- dumping the register sets of other threads running in the same
  thread group and mm is not supported
- fpxregs are not dumped. They could be dumped "if (have_fpx_regs)"
  (from arch/um/os-Linux/sys-i386/registers.c)
Should I try a fix? Does it make sense to fix all this?

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
