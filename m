Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzCO5-00020p-Vp for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:21:33 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzCO1-0001nx-5K for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:21:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <7769792b3ce4e3e093cfd819954ae55e@server-ranch.ch>
	<200502072023.41630.blaisorblade@yahoo.it>
	<db90534f90b487c87a9d0fa2311a82b2@server-ranch.ch>
In-Reply-To: <db90534f90b487c87a9d0fa2311a82b2@server-ranch.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101220.25484.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Security Issues
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
Date: Thu, 10 Feb 2005 12:20:25 +0100
To: Dominik Hirt <dhi@server-ranch.ch>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 09 February 2005 10:36, Dominik Hirt wrote:
> Hi
>
> Many thanks for your answer.
> So the problem exists only when module support is activated in the
> kernel of the uml, right?
Well, what I said is that on any UML the guest root can do everything on the 
host as normal user (but everything is not much if you chroot your UML). And 
this is not the "security hole" I spoke about, since this is not fixable 
(it's not a bug either, actually).

That's easy to exploit with module support, and possible even without 
when /dev/kmem is writable; this applies also to normal kernels, there is 
literature about normal kernels. It is probably hard, however, I guess.

The bug which is fixed in the patches allows *normal user* to reach the host, 
even without module support.
> Do you need any mirror in Switzerland?
> When the expected traffic is not too high I could offer you one for
> free.
Well, thanks a lot, however for now I don't think additional mirrors are 
needed... at least until somebody starts complaining for the load (but 
patches are usually little, so there should not be any problem, I guess).
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
