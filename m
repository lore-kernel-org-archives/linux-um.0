Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCxnm-00041N-2g for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:36:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DCxnh-0005Np-7w for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:36:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] uml help __alloc_pages: 0-order
	allocation failed (gfp=0xf0/0)
References: <000d01c52b22$8ab2c020$0201a8c0@lualele>
	<000501c52b25$717710e0$0201a8c0@lualele>
	<20050317192527.GA15619@taniwha.stupidest.org>
In-Reply-To: <20050317192527.GA15619@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503172049.39200.blaisorblade@yahoo.it>
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
Date: Thu, 17 Mar 2005 20:49:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Paul Warren <pdw@ex-parrot.com>
Cc: Chris Wedgwood <cw@f00f.org>, itamar <itamar@ispbrasil.com.br>, user-mode-linux-user@lists.sourceforge.net

On Thursday 17 March 2005 20:25, Chris Wedgwood wrote:
> On Thu, Mar 17, 2005 at 04:13:37PM -0300, itamar wrote:
> > I am running the guest kernel with mem=256M
>
> does it sound reasonable that 256MB of memory is in use?  if so can
> you trim that down?
>
> if this seems too high we need to see if there is a leak somewhere
Paul Warren said that there is a leak in 2.4 UML related to hostfs stuff.. and 
I already saw this message from some 2.4 recent UMLs. I hope Paul Warren can 
explain what he saw and help us...

In case we have confirmation it's hostfs-related, we only need to go back to 
the stable 2.4.24-1um hostfs code (i.e. pre-humfs), as I already do in the 
2.4-bs tree.
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
