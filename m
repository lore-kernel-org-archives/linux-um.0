Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsiOr-0005F9-Ur for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 06:35:17 -0700
Received: from zsc3s004.nortelnetworks.com ([47.81.138.65])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BsiOr-0002gi-KA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 06:35:17 -0700
Message-ID: <41123785.5040004@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Q: UML thread communication - scheduling oddness
References: <200408050020.i750Kwvv009127@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 05 Aug 2004 09:35:01 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net, Randy Macleod <macleodr@nortelnetworks.com>

That's an excellent theory esp. ince we do not see the problem typically 
on a host with more memory. I presume there are tricks we can play to 
get our memory not to be swapped out (recall a discussion on that here).

Could you add a few sentences though on the delivery mechnisms for the 
the packets to the kernel thread and to userspace. I saw a poll() on the 
pollfds array which has the taps fd in it but this is a non-blocking 
poll and I could not trace to how often it is called and what triggers 
it - I also saw the sigio handler but I could not see who was generating 
the SIGIO - is that how the userspace thread is woken up?

If there is some thing else I can read to get some background that would 
help...otherwise its back to the source of course.

thank you kindly, Giovanni

Jeff Dike wrote:
> gmarzot@nortelnetworks.com said:
>  > That is, if I run a little busy loop
>  >   /mnt/plankton/stress --cpu 1 --io 1
>  > on the server side, the round trip time for messages is greatly
>  > *improved*. without this activity and a basically dormant server side
>  > UML the round trip times show considerable variabilty with gaps on the
>  >  order of seconds.
> 
> How's this for a theory:  The server's host is short on memory.  A UML 
> which
> is answering pings every second or so can be considered pretty idle, and 
> thus
> a good candidate to have its pages swapped out.  So, this happens, and when
> a ping comes in, UML needs to be swapped back in, causing your long and
> unpredictable delays.
> 
> Running a busy loop in the UML makes it busy from the point of view of the
> host and prevents it from being swapped out, giving you nice ping 
> latencies.
> 
>                                 Jeff
> 
> 





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
