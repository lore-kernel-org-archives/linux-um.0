Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX38d-0003fy-Ld for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 11:49:15 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CX307-0006WD-B4
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 11:40:28 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [PATCH] uml_router: cleanup
Message-ID: <20041124192756.GA26938@bytesex>
References: <874qjfftsz.fsf@bytesex.org>
	<BAY24-F33146F620CDD96B205B7283B80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY24-F33146F620CDD96B205B7283B80@phx.gbl>
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
Date: Wed, 24 Nov 2004 20:27:56 +0100
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

> >  * Has outgoing package queues per switch port.
> 
> I wanted this as well - dropping packets just because of a temporary EAGAIN 
> makes network traffic stumble.

I'm not sure any more that this makes actually a big difference.
It may help a bit on network load peaks.

The (host) kernel does some buffering as well in the fifo/socket
buffers, you'll get the -EAGAIN once they are full.  Buffering in the
switch daemon as well just makes the buffer space bigger, but at some
point you have to drop packets.

The TCP protocol has a clever algoritm to get as much as possible out of
a link between two machines which actually *depends* on packets being
dropped once you've over the limit for the link.  Thus dropping packets
isn't something you should try to avoid at any cost.  You can't do that
anyway ;)

> But one thing I think I noticed is you don't expire packets if they
> get stale (packet dropping seems to drop the newest packet rather than
> the oldest as well), which could cause problems too.

Not sure what a real switch/router does in that case.  Note that the
packets which are already in the kernel's fifo/socket buffer can't be
expired as well ...

> >  * use poll() instead of select() (again this likely doesn't make a
> >    noticable difference for most users ...).
> 
> Not to have completely wasted my time, the io dispatcher I wrote around 
> poll() should be an easy retrofit in your package as well, if you want it.
> 
> Or, if it would be useful, I would be happy to try and integrate both 
> packages together.

Feel free to go ahead with merging code and push it upstream.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
