Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtA80-0006K8-SD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 11:44:00 -0800
Received: from mxfep02.bredband.com ([195.54.107.73])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtA7z-0002Ko-4b for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 11:44:00 -0800
Received: from kakmonster.int.dactylis.com ([85.224.135.43] [85.224.135.43])
	by mxfep02.bredband.com with ESMTP id
	<20050124194343.TMZL12890.mxfep02.bredband.com@kakmonster.int.dactylis.com>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 24 Jan 2005 20:43:43 +0100
Received: from [85.224.198.209]
	(c-d1c6e055.165-1-64736c11.cust.bredbandsbolaget.se [85.224.198.209])
	(authenticated bits=0)
	by kakmonster.int.dactylis.com (8.13.1/8.13.1) with ESMTP id
	j0OJhbca011750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 24 Jan 2005 20:43:42 +0100
Message-ID: <41F54FE9.7060503@better.se>
From: Marcus Better <marcus@better.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] skas3 patch breaks ATI video drivers
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
Date: Mon, 24 Jan 2005 20:43:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I applied Blaisorblade's host-skas3-2.6.9-v7.patch, and it breaks the 
fglrx graphics driver from ATI[1]. This is with Debian kernel 2.6.9, but 
I believe it applies to vanilla kernels also.

The problem is the following declaration added to include/asm-i386/desc.h:

----------------------------------------------------------
extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
		      unsigned long bytecount);
----------------------------------------------------------

The fglrx driver contains the following macro in a source file:

_syscall3( int, modify_ldt, int, func, void *, ptr, unsigned long, 
bytecount )

Here the compiler chokes with the following error:
---------------------------------------------------------
/usr/src/modules/fglrx-4.3.0-3.14.6/firegl_public.c:181: error: 
conflicting types for `modify_ldt'
include/asm/desc.h:144: error: previous declaration of `modify_ldt'
---------------------------------------------------------

I don't understand the details of the kernel code, but it seems that the 
problem is that the SKAS patch defines the function modify_ldt which 
conflicts with the syscall macros.

I renamed the new function to _modify_ldt instead (and changed the two 
or three references to it in ldt.c), and this seems to fix the problem.

Please CC replies to me, I'm not subscribed to the list.

Thanks for your work!

Marcus B.

[1] http://www.ati.com/support/drivers/linux/radeon-linux.html




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
