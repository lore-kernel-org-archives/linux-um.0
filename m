Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARLR9-000425-Hk
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 17:04:15 -0800
Received: from pacific.moreton.com.au ([203.143.235.130] helo=dorfl.internal.moreton.com.au)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ARLR7-0000i5-1D
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 17:04:13 -0800
Received: from snapgear.com (steveb1.sw.moreton.com.au [10.1.9.1])
	by dorfl.internal.moreton.com.au (8.12.8/8.12.9) with ESMTP id hB3143dN085309
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Dec 2003 11:04:03 +1000 (EST)
	(envelope-from steveb@snapgear.com)
Message-ID: <3FCD3683.2030503@snapgear.com>
From: Steve Bennett <steveb@snapgear.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020602070805010701050007"
Subject: [uml-devel] [PATCH] provide asm/ldt.h
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
Date: Wed, 03 Dec 2003 11:04:03 +1000
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------020602070805010701050007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached trivial patch provides access to <asm/ldt.h> when compiling
against UML.
I required this when compiling strace.

-- 
Steve Bennett                 http://www.SnapGear.com/
steveb@snapgear.com           Custom Embedded Solutions + Security

--------------020602070805010701050007
Content-Type: text/plain;
 name="uml-strace-ldt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-strace-ldt.patch"

diff  -u linux-2.4.x/include/asm-um/ldt.h
--- linux-2.4.x/include/asm-um/ldt.h.orig
+++ linux-2.4.x/include/asm-um/ldt.h	2003-12-02 16:17:23.000000000 +1000
@@ -0,0 +1 @@
+#include <asm/arch/ldt.h>

--------------020602070805010701050007--



-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
