Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sahne@0x90.at>) id 1XbQNI-0000PV-EF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Oct 2014 08:44:04 +0000
Received: from zimbra.brainity.com ([188.40.76.72])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XbQNG-0006gX-EJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Oct 2014 08:44:04 +0000
Date: Tue, 7 Oct 2014 10:28:24 +0200 (CEST)
From: Daniel Walter <d.walter@0x90.at>
Message-ID: <779241076.3024.1412670504362.JavaMail.root@0x90.at>
In-Reply-To: <1487140382.2997.1412670384789.JavaMail.root@0x90.at>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH] Dump really early stack traces
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Richard Weinberger <richard@nod.at>, thomas@m3y3r.de

> <snip>

Hi Thomas,

Could you please fix your patch since there are multiple issues with it
1) I does not apply cleanly against the current linux tree 
   mostly due to kmsg_dump.c which is not in the proper format
   it should be b/arch/um/kernel/kmsg_dump.c like the rest of the patch

2) After fixing this it did not build
   Please make sure to build test your patch on a fresh checkout of the tree
   by applying your patch, make ARCH=um mrproper, make ARCH=um defconfig make ARCH=um

3) The patch itself does not comply to patch standards.
   please read Documentation/SubmittingPatches for more information
   you can use scripts/checkpatch.pl to check for common errors
   eg: Signed-off-by is missing, etc.


Now that we're done with the non-technical things, I don't like 

a) that you move the inline function (current_thread_info) out of the
   header file

b) introduce a branch into this function which is most likely never taken
   (you could use if (unlikely(!is_kernel_addr((void *)ti)) )

c) I'd personally would make is_kernel_addr either an inline function or a macro

d) please split up the 2 changes in to different patches
   1) return init_thread_info if not kernel_addr
   2) add kmsg_dumper to panic_exit()

e) I'm not sure if returning init_thread_info is the right approach, it might
   mask other errors like memory corruption bugs, etc.

I do like the kmsg_dumper thing, so would you mind sending this as a separate patch ?

Cheers,

Daniel

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

