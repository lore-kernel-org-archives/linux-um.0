Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DeGRr-0005O1-DP	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:59:11 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DeGRn-0003dm-UQ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Jun 2005 10:59:11 -0700
Message-ID: <42A09A63.9090002@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
References: <1115573839.10373.42.camel@cobra>
	<20050508183533.GA27251@ccure.user-mode-linux.org>
	<1115590823.10373.68.camel@cobra> <1115600253.10373.74.camel@cobra>
	<1117307236.10041.4.camel@localhost> <1117691482.10122.107.camel@localhost>
	<20050602210649.GA24306@ccure.user-mode-linux.org>
	<1117766016.10122.202.camel@localhost>
	<20050603023809.GA28818@ccure.user-mode-linux.org>
	<1117826890.10090.48.camel@localhost>
	<20050603164910.GA20908@ccure.user-mode-linux.org>
In-Reply-To: <20050603164910.GA20908@ccure.user-mode-linux.org>
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
Date: Fri, 03 Jun 2005 19:58:59 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: antoine <antoine@nagafix.co.uk>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Fri, Jun 03, 2005 at 08:28:10PM +0100, antoine wrote:
> 
>>I think there is still a memory leak lurking, OOM seems to kick in (see
>>bottom of this email)
> 
> 
> Yeah, it's a page leak, I think from page tables, which I haven't tracked
> down yet.
> 
> 
>>Very minor thing: I noticed that the TT threads generally do not show
>>which process they are running inside the UML (as it used to), any way
>>to restore this?
> 
> 
> Those aren't tt threads, they are skas0 threads, and we could probably restore 
> the command names, but I haven't bothered doing so.
I thought about doing so, as the output of ps really looks bad.
Unfortunately, I found only very nasty ways.
On older host's, we could try to expand or strip down the environment in a similar
way as is used it tt. Then, names could be placed into stub-(stack?)-page.
Nasty, but it could work.
An even worse case is a host using stack-randomization. We need a pointer in the
host poining to stub-pages. If the host has left a "hole" above the stack, would
we have to "exec" until accidentally we get a stack starting at upper address-range
limit?
		Bodo
> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
> a projector? How fast can you ride your desk chair down the office luge track?
> If you want to score the big prize, get to know the little guy.  
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
