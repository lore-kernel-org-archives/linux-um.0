Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9bQg-0002hS-SB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 20:07:14 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9bQg-0006IO-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 20:07:14 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: Fw: [patch] uml: terminal cleanup
References: <20041128010910.1b5478c7.akpm@osdl.org>
	<200503091938.46936.blaisorblade@yahoo.it>
	<20050310081340.GC17880@bytesex>
In-Reply-To: <20050310081340.GC17880@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503102204.08432.rob@landley.net>
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
Date: Thu, 10 Mar 2005 22:04:08 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Blaisorblade <blaisorblade@yahoo.it>

On Thursday 10 March 2005 03:13 am, Gerd Knorr wrote:

> Ouch.  I've never seen that myself though, works perfectly fine for me.
> Could be somehow related to the scrambled compiler logs reported a few
> weeks ago, maybe the tty/line buffer handling is broken ...

I've done some more debugging on that, and I can reproduce it at will on any 
machine now.  The problem is that if the process that is on the other end of 
UML's output pipe gets stopped (like the Xterm consuming the UML output), its 
retry logic is borked.

I have a more detailed analysis with debug info on another machine (I'll try 
to dig that up later tonight), but really briefly, find out the PID of the 
xterm you're running in, I.E. the parent process of the shell you're going to 
run it under ("ps" followed by "ps l" should do it).  Then set up a dumb 
little script ala

while /bin/true
do
	kill -STOP $PID
	sleep 1
	kill -CONT $PID
	sleep 1
done

And now run UML and do and extract a tarball under it or something, and watch 
the output go bananas.

The requeue logic handling -EAGAIN requeues the data that's already on the 
buffer, not the new data that should go ON the buffer.  That's why the 
stuttering.  (What happens when the 4k buffer fills up is anybody's guess.  I 
think data just gets dropped.)

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
