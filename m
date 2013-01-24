Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1TyAbB-0002D5-2l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2013 00:23:21 +0000
Received: from mail-ob0-f169.google.com ([209.85.214.169])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TyAb9-0000Ma-RN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2013 00:23:21 +0000
Received: by mail-ob0-f169.google.com with SMTP id ta14so965381obb.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jan 2013 16:23:14 -0800 (PST)
MIME-Version: 1.0
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Wed, 23 Jan 2013 16:22:43 -0800
Message-ID: <CADNZ+wTLumzXtt+TsapZF1T8+1YQykqy9DzyZmpieY8+897o8A@mail.gmail.com>
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
Subject: [uml-devel] [PATCH] uml: Always use 3_LEVEL_PGTABLES on x86_64
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Tristan Schmelcher <tschmelcher@google.com>

Use 3_LEVEL_PGTABLES on x86_64 even if EXPERIMENTAL is off, since
otherwise UML does not work. Applies to 3.7.1.

Signed-off-by: Tristan Schmelcher <tschmelcher@google.com>
---

I'm not clear on the patch procedure for UML. Assuming you guys like
this, do I send it directly to Linus?

--- linux-3.7.1/arch/x86/um/Kconfig.orig        2013-01-23
15:50:12.671408478 -0800
+++ linux-3.7.1/arch/x86/um/Kconfig     2013-01-23 15:44:38.321878377 -0800
@@ -39,7 +39,7 @@ config RWSEM_GENERIC_SPINLOCK
 config 3_LEVEL_PGTABLES
        bool "Three-level pagetables (EXPERIMENTAL)" if !64BIT
        default 64BIT
-       depends on EXPERIMENTAL
+       depends on EXPERIMENTAL || 64BIT
        help
        Three-level pagetables will let UML have more than 4G of physical
        memory.  All the memory that can't be mapped directly will be treated

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

