Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARDQC-0007vA-Uv
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 08:30:44 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ARDQB-0003QN-0M
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 08:30:43 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
Message-ID: <20031202164257.GA24954@ccure.user-mode-linux.org>
References: <Pine.LNX.4.44.0312020036530.16157-100000@filer.marasystems.com> <Pine.LNX.4.44.0312020123030.16352-200000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312020123030.16352-200000@filer.marasystems.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 2 Dec 2003 11:42:57 -0500
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 02, 2003 at 01:55:25AM +0100, Henrik Nordstrom wrote:
> vfree() calls flush_tlb_all(), but as this does not update the vm_seq
> number old the mapping is still there unless there is another page fault
> before the page is referenced again. Because of this there is a race if
> vmalloc() returns the same area that was last vmfree():d causing that area
> to temporarily refer to the old physical location until the next kernel
> page fault and quickly resulting in very odd results..

Sorry about the delay.  I've been in Tokyo for the last week.  I haven't
stared at the code yet, but your analysis looks reasonable.

> What I wonder is if this can be fixed without dropping the vm_seq
> optimization of tt kernel virtual memory updates. But from looking at the
> skas implementation I suppose dropping the vm_seq optimization is the
> correct way.. (skas does not have this optimization and should thus be
> safe from the issue)

Right, this is because of the kernel existing in multiple host address 
spaces on the host in tt mode, and the kernel VM area needing to be kept
in sync between them.

> What was the design thought behind the vm_seq optimization? I understand
> the principle, but not the conditions when it can be safely deduced that
> the init_mm has not been updated since the last flush_kernel_vm_range().

The idea is to avoid unecessary mmapping and munmapping on context switches
if the kernel VM area hasn't changed since the process last ran.

> I still think the kernel vm pte mappings should be mirrored into the
> current process and flush_kernel_vm_range() changed to do incremental
> remaps where the kernel vm pte mappings of init_mm differs from the
> current process. 

How?

> This applies to both tt and skas mode. 

No, it doesn't.  Those two are completely different in this case.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
