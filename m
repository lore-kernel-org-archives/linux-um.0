Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNDPo-0007h3-SJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2005 10:18:36 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DNDPj-0003bx-94 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2005 10:18:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problems with UML on Debian Sarge 64 host
References: <CBELIFGMBIEPIEOFCJFAMEFLCAAA.brocka@sterlingcgi.com>
In-Reply-To: <CBELIFGMBIEPIEOFCJFAMEFLCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504171932.23595.blaisorblade@yahoo.it>
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
Date: Sun, 17 Apr 2005 19:32:23 +0200
To: Anthony Brock <brocka@sterlingcgi.com>, user-mode-linux-devel@lists.sourceforge.net

On Friday 15 April 2005 08:42, Anthony Brock wrote:
> Blaisor,

> Do you have an evaluation SKAS patch available for 64-bit Linux (2.6.11) on
> the AMD Opteron? Or has this project taken a back seat to other tasks?

Yes to both question, i.e. we are not yet there. I actually *did* a port to 
64-bit, which is -v9-pre1, and it compiles, at least it did yesterday (maybe 
my local tree had some changes from the released patch). Somebody reported it 
does not compile, however.

The real problem is that it does not work yet (aka I cannot make it work on my 
box), and I don't know why.

I already had done the port at 2.6.8.1 time and it had the same problem. And 
actually, I'm busy with development (and at the very moment too busy even to 
do a lot of development).

> I'm almost ready to start testing this configuration if one is available.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
