Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWuVA-0002bI-5d
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 01:31:24 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWuV9-0001W5-JZ
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 01:31:23 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] [bug] uml segfaults if forcing static link, 2.6.0-test11
In-Reply-To: <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
Message-ID: <Pine.GSO.4.58.0312180830170.15937@altair.dur.ac.uk>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 18 Dec 2003 08:35:06 +0000 (GMT)
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 17 Dec 2003, Jeff Dike wrote:

> mingo@elte.hu said:
> > the attached .config produces an UML binary that segfaults much the
> > same way as before the ALIGN fixes.
>
> HAHAHA, there is justice in this world :-)
>
> This one is your fault, I think.
>
> See this patch and see if it fixes the problem:
> 	http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=106867347801038&w=2

Though that isn't a complete solution, as the same issue causes a random
amount less memory, averaging about 16M, to be allocated to the UML
process, potentially causing out of memory problems, including a failure
to boot at all.

For some other bugs you might see in FC1, see
http://toast.debian.net/~may/umlproject/bugs.html

	Michael Young


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
