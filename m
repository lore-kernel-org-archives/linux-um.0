Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJEoh-0004oQ-62 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 10:59:51 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DJEof-0004s0-Hz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 10:59:51 -0700
Received: by zproxy.gmail.com with SMTP id 9so139741nzo
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Apr 2005 10:59:42 -0700 (PDT)
Message-ID: <cbec11ac05040610597dfb93e1@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
In-Reply-To: <200504060145.24555.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504060145.24555.rob@landley.net>
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
Date: Thu, 7 Apr 2005 05:59:42 +1200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > And UML does compile under 2.6.11 with a patch for gcc (which is
> > include in 2.6.12-rc4). Haven't yet tried 2.6.12-rc1 but can do later
> > if this will help.
> 
> I'm confused: what?
> 
That should read 2.6.12-rc2 not 2.6.12-rc4.

I will supply the .config when I get into university. I will try to
replicate yours as well - I was running without SKAS I think which is
where your problem appears to be....


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
