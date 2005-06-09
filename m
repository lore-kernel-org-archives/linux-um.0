Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgPmg-0001tf-SY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 09:21:34 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgPmd-0007yS-Ve	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 09:21:34 -0700
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200506091724.50908.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1118334683.10190.66.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 09 Jun 2005 17:31:22 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > Now, if someone could have a look at hppfs I could resurect my
> > honeypots.
> I've not the time, however test the attached patches. The first one fixes the 
> basical bugs; the second one could be needed to fix a fd leak... but I don't 
> think it's needed at all, so test with only the first and let me know if the 
> 2nd is needed, or if there are any problems (in that case, a ready-to-use 
> hppfs configuration + explaination would be happily accepted, I've really 
> little time now).
Works fine with just the first patch. Thank you very much!
(how can I detect this fd leak you mentioned?)

Antoine

Now time to grab a copy of ssh v<=3.0 and see what happens ;-)



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
