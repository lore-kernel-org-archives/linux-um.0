Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbCFA-0007Vi-3a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 22:48:52 -0700
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbCF9-0000t9-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 22:48:51 -0700
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: [UML] Performance hit for setting CS segment limit
Message-ID: <20040618054954.GA13608@elte.hu>
References: <200406111954.15283.blaisorblade_spam@yahoo.it>
	<20040615054545.GB2543@elte.hu>
	<200406162141.57213.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406162141.57213.blaisorblade_spam@yahoo.it>
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
Date: Fri, 18 Jun 2004 07:49:54 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> >, but not for the code segment.
> > The code segment limit can be checked when an iTLB miss occurs
> 
> And so iTLB means instruction TLB, right? (I was wondering about this
> in your discussion about 4G/4G patch with Andrea Arcangeli).

yeah.

> Also, from some tests, I would guess that also for Celeron, and not
> only for Xeon, there are at least 64 dTLB. Is this correct? I used
> this to explain some benchmark datas.

'x86info -c' will tell you precisely how many TLBs there are for each 
type.

> I noticed that when touching more than 64 different pages (i.e. 512 in
> my test), flushing or not the TLBs gave almost no "secondary cost" for
> reloading them when re-touching those pages, while the secondary cost
> was very high with 64 pages.

yes, there are such boundaries. (they are often not precisely at 64
pages because code also needs a stack and maybe global variables, but
generally it's around the # of dTLBs.)

> >, no need
> > to check during code prefetch itself. So there's no overhead.
> 
> The only difference, here, is that for data segments, which are also
> important here, on a dTLB (i.e. I guess dTLB = data TLB) fault the
> check is done for a certain segment, so it could have a little
> overhead (though Intel claims it is done in parallel with address
> translation, in their manuals).

it depends on the CPU. But generally the more modern an x86 CPU is, the
higher the relative penalty for any segmentation trick ... and this
trend wont stop in the future i'm afraid.

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
