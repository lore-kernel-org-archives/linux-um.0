Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TN1WX-0002Lz-Md
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Oct 2012 13:13:01 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TN1WU-0007jb-J3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Oct 2012 13:13:01 +0000
Received: from [194.164.232.154] (helo=vault01.localnet)
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TN1WK-0007Lq-U4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Oct 2012 14:12:49 +0100
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <14846952.alsA7bkick@vault01>
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
Date: Sat, 13 Oct 2012 13:13:02 +0000
Subject: [uml-devel] linux-3.6.x ARCH=um will not build
To: user-mode-linux-devel@lists.sourceforge.net

Apologies if this repeats any previous attempts made by me: problems with 
something called 'gmane'

===
 ...
  CC      arch/um/os-Linux/signal.o
arch/um/os-Linux/signal.c:18:8: error: conflicting types for 'sig_info'
/nfs4xp/software/krn/linux-3.6.x/linux-3.6.2-um64/arch/um/include/shared/as-
layout.h:64:15: note: previous declaration of 'sig_info' was here

I get the above error when trying to build both linux-3.6 and linux-3.6.2 in 
both x86 (gcc-4.7.2) and x86_64 (gcc-4.6.3) environments.

Since both files involved in the conflict are part of the source distribution, 
I don't think that it can be a fault with my environment; but then I don't 
understand why it obviously works for others.

arch/um/os-Linux/signal.c:18:8
arch/um/include/shared/as-layout.h:64:15

Regards,

David

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

