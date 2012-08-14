Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dhowells@redhat.com>) id 1T1IqM-0002dn-57
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:15:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T1IqL-0005jT-F6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2012 15:15:42 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <502A69FA.8040805@nod.at>
References: <502A69FA.8040805@nod.at> <502A6759.3090802@nod.at>
	<15981.1344955883@warthog.procyon.org.uk>
	<502A613F.1090600@nod.at> <87a9xys53h.fsf@rustcorp.com.au>
	<20120726150419.0de645e8750e3a15fa0f1aaa@canb.auug.org.au>
	<50115FCF.4060708@xenotime.net> <502932A0.3060001@xenotime.net>
	<15532.1344954413@warthog.procyon.org.uk>
	<18600.1344956051@warthog.procyon.org.uk>
	<18933.1344956788@warthog.procyon.org.uk>
Date: Tue, 14 Aug 2012 16:15:28 +0100
Message-ID: <30102.1344957328@warthog.procyon.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-next: Tree for July 26 (uml)
To: Richard Weinberger <richard@nod.at>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org


How about this then?

David
---
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 9926e11..a4b0c10 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -21,9 +21,11 @@ config 64BIT
 config X86_32
 	def_bool !64BIT
 	select HAVE_AOUT
+	select MODULES_USE_ELF_REL
 
 config X86_64
 	def_bool 64BIT
+	select MODULES_USE_ELF_RELA
 
 config RWSEM_XCHGADD_ALGORITHM
 	def_bool X86_XADD && 64BIT

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

