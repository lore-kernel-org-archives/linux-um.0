Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Trp8y-00032X-CE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jan 2013 12:16:00 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Trp8q-0008Ou-Bq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jan 2013 12:16:00 +0000
Received: from [194.164.232.154] (helo=localhost.localnet)
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1Trp8h-0001CA-FO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jan 2013 12:15:43 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <2143609.blR1ybJ3UI@localhost>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Date: Sun, 06 Jan 2013 12:16:02 +0000
Subject: [uml-devel] UML Network Related Crashing
To: user-mode-linux-devel@lists.sourceforge.net

I note that my message sent yesterday ended up heavily truncated, so I have 
turned on the line-wrap for this one. Sorry about that.

What I was trying to say is that I can repeatedly crash UML by exercising the 
networking heavily as a result of rsync'ing data to and from.

I also said that I have an older kernel (3.1.0) UML (which operates reasonably 
successfully under most circumstances) that I access over the Internet. If I 
try to rsync data from it, I can crash it reliably after 5 or 10 minutes.

This 3.1.0 UML was the first step in an upgrade to a much older UML based 
virtual server that has been in operation for about a decade without any 
trouble. The main objective of upgrading was to take advantage of BTRFS, but I 
have noticed that the UML is less reliable and crashes occasionally. This UML 
is not actually using BTRFS, it has exactly the same disk images as the 
historic one, so the issue is not, I believe, related to BTRFS, but some other 
aspect of the newer kernel. I now believe that the reliability issue is 
probably related to the networking issue.

I have tried setting up a second, 3.8.0-rc2 based, UML on the same host and 
rsync'd between them over mcast network interfaces. I get crashing on one or 
the other UML.

I have found that I don't get much information about the failures. When things 
go wrong, the UML is completely locked up and is not responsive either from 
the session in which it was started, or via uml_mconsole. Things usually seem 
to have locked-up before any message comes into view. Once or twice I have 
seen the line that says '---[ cut here ]---', showing that something was 
trying to come out, but whatever message there was does not become visible.

I have set up two 3.8.0-rc2 based UMLs on a local machine and rsync data over 
mcast network interfaces. I'm hoping that I get something out that will help 
someone to identify the problem.

The latest result that has some information is:

------------[ cut here ]------------0:00
WARNING: at net/core/skbuff.c:573 skb_release_head_state+0x60/0xba()
Modules linked in:

but that is as much as I get. This UML instance is now totally locked up. This 
behaviour is consistent with the other failures I get on my older UML.

Previous conversations suggest that it is known that there is some network 
related problem in UML, but it has not been tracked down. I feel that it 
rather defeats the object if a UML instance cannot run reliably with 
networking. I will carry on with my exercising of my UMLs and report anything 
that I find.

Regards,
David Humphreys

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_123012
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

