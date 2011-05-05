Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <paul.chavent@fnac.net>) id 1QHtOt-0000Fg-Mf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2011 07:55:07 +0000
Received: from smtp22.services.sfr.fr ([93.17.128.10])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QHtOs-00024i-BS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 May 2011 07:55:07 +0000
Received: from smtp11.services.sfr.fr (msfrf1103 [10.18.24.53])
	by msfrf2205.sfr.fr (SMTP Server) with ESMTP id 1196270005C7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  5 May 2011 09:34:31 +0200 (CEST)
From: <paul.chavent@fnac.net>
Message-ID: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
MIME-Version: 1.0
Date: Thu,  5 May 2011 09:34:24 +0200 (CEST)
Reply-To: paul.chavent@fnac.net
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
Subject: [uml-devel] [PATCH] for ARCH=um,
 optionaly give a path for the vde installation.
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi.

I use uml with vde. The kernel links against libvdeplug.a and automatically find it. But i would like to manually give its path.

So i made a patch for being able to give the VDE_PREFIX when we call make.

I wonder if this patch could be included in the mainstream kernel, or if there is a better way of doing it.

Could you give me your opinion please ?

Regards .

Paul.



------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

