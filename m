Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5sPE-0007iT-V8 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Mar 2004 12:21:48 -0800
Received: from dns2.uxu.ch ([195.216.70.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5sPB-0003It-P2 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Mar 2004 12:21:46 -0800
Message-ID: <40609C47.60409@uxu.ch>
From: =?ISO-8859-1?Q?Felix_M=FCri?= <uml@uxu.ch>
MIME-Version: 1.0
Subject: Re: [uml-devel] 802.11 emulation under UML
References: <20040322170011.8039.qmail@web25105.mail.ukl.yahoo.com>
In-Reply-To: <20040322170011.8039.qmail@web25105.mail.ukl.yahoo.com>
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
Date: Tue, 23 Mar 2004 21:21:27 +0100
To: maria maria <for_spam2004@yahoo.it>, User-mode-linux-devel@lists.sourceforge.net

maria maria wrote:
> Hi!
> I want to make a module based off the net daemon that
> has wireless extensions.
> The first thing I need to do is to make an uml
> wireless daemon that simulates 802.11 protocol
> (CSMA/CA: to send RTS, CTS, ACK for each packet, to
> run a backoff algorithm 
> to realize collision avoidance, etc...).
> I would like to know where in the uml switch code is
> the best place to do that.
> I'm really looking for some help with uml switch
> because it is pretty undocumented...
uml_switch uses the interface for routing ethernet packets which has 
noting to do with device drivers (the standard tun device driver is used).
I wouldn't say, that uml switch is badly documented. The code is 
straight forward and well written (I had to understand it to program my 
replacement uml_switch2 (http://www.uxu.ch/uxu/software/uml_switch2)

I fear, you need to replace the daemon uml-networkadapter with something 
more powerful. By the way, Jeff has some ideas for additional changes in 
the uml-networkadapter that you could implement too ;-)

Regards, Felix

I think I need to
> add some set from inside uml, but I really don't know
> how to do...I'm pretty new to linux.....
> Can someone help me?
> Thank you in advance!
> 
> Maria
> 
> 
> ______________________________________________________________________
> Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
> http://it.yahoo.com/mail_it/foot/?http://it.mail.yahoo.com/
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
