Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6FOX-0006xq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 05 Oct 2003 13:22:22 -0700
Received: from bay7-f106.bay7.hotmail.com ([64.4.11.106] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6FOW-00088s-Ct
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 05 Oct 2003 13:22:20 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: text/html
Message-ID: <BAY7-F106QD9Eg44PdO0000c3b5@hotmail.com>
Subject: [uml-devel] Re: Hostaudio module parameters
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 05 Oct 2003 20:20:19 +0000
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

<html><div style='background-color:'><DIV>
<P>&gt;Since hostaudio can be also a module, it's useful to specify the host dsp and </P>
<P>&gt;mixer position even on module loading. So I've added two params with </P></DIV>
<DIV></DIV>&gt;descriptions for this. The patch is straightforward and non-intrusive, so 
<DIV></DIV>&gt;please apply it. 
<DIV></DIV>
<DIV></DIV>
<P>This could be abused to allow reading and writing arbitrary files on the host by loading the module with parameters within the UML.</P>
<P>&gt;By the way: while testing it(I repeated this with an unpatched UML kernel) </P>
<DIV></DIV>&gt;with mpg123, I discovered that it crackles horribly and plays very 
<DIV></DIV>&gt;slowly(i.e. a second of music lasts even two or more ones). Will this ever be 
<DIV></DIV>
<P>&gt;solved? Is this problem specific to me or general?</P>
<P>I think it's due to the dsp&nbsp;device being opened&nbsp;in blocking mode and the UML&nbsp;pauses while the audio data gets written out.&nbsp; There is&nbsp;no support for&nbsp;async IO in the driver, so turning on O_NONBLOCK on the host file open, might speed up the app, but likely&nbsp;result in&nbsp;choppy output, and/or confuse the app with EAGAIN errors.</P>
<P>The answer to this is to rewrite the driver as a virtual sound card with async IO.&nbsp; I may do this at some point, if no one&nbsp;is willing to take on the challenge.</P>
<P>&nbsp;</P>
<P>Steve Schmidtke</P></div><br clear=all><hr>STOP MORE SPAM with  <a href="http://g.msn.com/8HMBENCA/2728??PS=">the new MSN 8 </a> and get 2 months FREE* </html>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
