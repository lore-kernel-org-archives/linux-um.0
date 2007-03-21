Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HU1Xl-0005e6-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 07:12:01 -0700
Received: from mail119.messagelabs.com ([216.82.241.179])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HU1Xe-0008Oi-Rq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 07:12:01 -0700
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2LEBhTi001516
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 07:11:43 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id l2LEBgbw010535
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 09:11:42 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 21 Mar 2007 22:11:48 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201B0F107@ZMY16EXM67.ds.mot.com>
In-Reply-To: <20070321135510.GC5398@c2.user-mode-linux.org>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: Re: [uml-devel] Regarding Process creation in UML tracing thread mode
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,
		But I was confused with the diagram you described here:
http://user-mode-linux.sourceforge.net/slides/als2000/img4.html

Also from your below response it means that: UML just have a
task_structure maintained....
Also I never saw the UML specific schedule() code in .../arch/um does
UML uses the host schedule itself ?

Regards,
Abhi

-----Original Message-----
From: Jeff Dike [mailto:jdike@addtoit.com] 
Sent: Wednesday, March 21, 2007 7:25 PM
To: Krishnappa Abhijith-A21204
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Regarding Process creation in UML tracing
thread mode

On Wed, Mar 21, 2007 at 07:51:44PM +0800, Krishnappa Abhijith-A21204
wrote:
>              Regarding fork() implementation UML in tracing thread 
> (tt) mode Whenever we call fork in UML the following happens:
>  
> 2 process gets created
> 1 on UML say U_1 and 1 on HOST say H_1

No, one process gets created, in which both the process and the kernel
run.

				Jeff

--
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
