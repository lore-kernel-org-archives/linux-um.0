Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRgVR-0002oJ-MM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 20:19:58 -0700
Received: from mail128.messagelabs.com ([216.82.250.131])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HRgVR-0006m3-8E
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 20:19:57 -0700
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate3.mot.com (8.12.11/Motorola) with ESMTP id l2F3JpvA025503
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Mar 2007 20:19:51 -0700 (MST)
Received: from az10vts03 (az10vts03.mot.com [10.64.251.244])
	by az33exr01.mot.com (8.13.1/Vontu) with SMTP id l2F3Jo0w012839
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Mar 2007 22:19:50 -0500 (CDT)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id l2F3Jmun012828
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 14 Mar 2007 22:19:49 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 11:19:37 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201A96E8B@ZMY16EXM67.ds.mot.com>
In-Reply-To: <20070314141004.GA5116@ccure.user-mode-linux.org>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: Re: [uml-devel] Regarding Address space in UML
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
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Thanks Jeff for your response.
So Basically when we run a process in UML, the tracing thread enables
tracing for that process.
Also I had a query on creation of a corresponding process on host...
Why it is done in UML... I mean why a corresponding process gets created
in HOST ? Is it to catch all the signals that host KERNEL delivers ?

Pls let me know.
Thanks,
Abhi 

-----Original Message-----
From: Jeff Dike [mailto:jdike@addtoit.com] 
Sent: Wednesday, March 14, 2007 7:40 PM
To: Krishnappa Abhijith-A21204
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Regarding Address space in UML

On Wed, Mar 14, 2007 at 09:57:33PM +0800, Krishnappa Abhijith-A21204
wrote:
> I had a question on Process address space in UML.
> Will there be a tracing thread for each process created in UML ? which

> is responsible for system call tracking ?

No.  There is one per virtual CPU which traces the process running on
that CPU and runs the kernel for that CPU.

> Also will the address space of a process in UML also consists of the 
> corresponding Tracing thread ?

No, the address space is nearly identical to what it would be on the
host.

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
