Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGE84-0003uf-QP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Mar 2005 02:39:24 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user77274)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DGE83-0006Jx-3x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Mar 2005 02:39:24 -0800
Subject: Re: [uml-devel] Interesting...
References: <200503290011.03921.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200503290011.03921.rob@landley.net> (Rob Landley's message of
	"Tue, 29 Mar 2005 00:11:03 -0500")
Message-ID: <871x9yhh2p.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 29 Mar 2005 11:39:10 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 29 Mar 2005, Rob Landley said:
> This doesn't work:
> 
> ./linux rootfstype=hostfs rw init=/bin/ls -l > out.txt &

Well, it blocks.

It looks like UML is reading from stdin at some point (I haven't
looked to find out where; I suppose I should).

-- 
This is like system("/usr/funky/bin/perl -e 'exec sleep 1'");
   --- Peter da Silva


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
