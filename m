Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba6kj-0006jx-NB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 22:44:57 -0700
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba6kj-0001XQ-AF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 22:44:57 -0700
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040615054545.GB2543@elte.hu>
References: <200406111954.15283.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406111954.15283.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [UML] Performance hit for setting CS segment limit
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
Date: Tue, 15 Jun 2004 07:45:45 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> Hi Ingo, I need some help from you about the performance hit of
> segmentation, which you probably studied for the exec-shield patch.
> 
> In short: if I reduce the limit of the CS, DS and so on segment
> descriptors (let's say it becomes 2,5G instead of 4G), a bit like you
> do in the exec-shield patch, will this setting impact on the
> performance of the process, apart for the time to set them? I also
> assume that segment changes do not flush the TLBs; is this correct?
> 
> I've been told by Jeff Dike (you can check on the ML) that :
> 
> "This is slow, plus ****using segments will cost you a cycle or
> something on EVERY memory reference***. Alan Cox warned me off very
> strongly against doing this.", though maybe he referred to something
> different: is this true in this case?

this might be true for _data_ segments, but not for the code segment.
The code segment limit can be checked when an iTLB miss occurs, no need
to check during code prefetch itself. So there's no overhead.

	Ingo


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
