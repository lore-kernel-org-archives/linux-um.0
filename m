Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsGws-00089B-TF for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 00:48:50 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CsGwr-00014C-J8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 00:48:50 -0800
Received: from [10.0.0.10] (sorenson.dsl.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.12.11/8.12.11) with ESMTP id j0M8ml2P025295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 22 Jan 2005 01:48:48 -0700
Message-ID: <41F2136F.1020004@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000507000305060905070303"
Subject: [uml-devel] Build errors when compiling 2.6.11-rc2-um
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
Date: Sat, 22 Jan 2005 01:48:47 -0700
To: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000507000305060905070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm seeing compile errors in arch/um/kernel/sys_call_table.c with 
2.6.11-rc2.  See attached.

Thanks,
Frank
-- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com

--------------000507000305060905070303
Content-Type: plain/text;
 name="build_errors.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build_errors.txt"

  CC      arch/um/kernel/sys_call_table.o
  arch/um/kernel/sys_call_table.c:284: error: `__NR_vperfctr_open' undeclared here (not in a function)
  arch/um/kernel/sys_call_table.c:284: error: nonconstant array index in initializer
  arch/um/kernel/sys_call_table.c:284: error: (near initialization for `sys_call_table')
  arch/um/kernel/sys_call_table.c:285: error: `__NR_vperfctr_control' undeclared here (not in a function)
  arch/um/kernel/sys_call_table.c:285: error: nonconstant array index in initializer
  arch/um/kernel/sys_call_table.c:285: error: (near initialization for `sys_call_table')
  arch/um/kernel/sys_call_table.c:286: error: `__NR_vperfctr_unlink' undeclared here (not in a function)
  arch/um/kernel/sys_call_table.c:286: error: nonconstant array index in initializer
  arch/um/kernel/sys_call_table.c:286: error: (near initialization for `sys_call_table')
  arch/um/kernel/sys_call_table.c:287: error: `__NR_vperfctr_iresume' undeclared here (not in a function)
  arch/um/kernel/sys_call_table.c:287: error: nonconstant array index in initializer
  arch/um/kernel/sys_call_table.c:287: error: (near initialization for `sys_call_table')
  arch/um/kernel/sys_call_table.c:288: error: `__NR_vperfctr_read' undeclared here (not in a function)
  arch/um/kernel/sys_call_table.c:288: error: nonconstant array index in initializer
  arch/um/kernel/sys_call_table.c:288: error: (near initialization for `sys_call_table')
  make[1]: *** [arch/um/kernel/sys_call_table.o] Error 1
  make: *** [arch/um/kernel] Error 2


--------------000507000305060905070303--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
