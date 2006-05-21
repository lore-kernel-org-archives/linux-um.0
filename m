Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fhrrf-0008AV-Nu for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:15 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fhrre-0007JA-MT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:14 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fhrra-0000Jg-Qd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2006 10:37:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] debug uml
References: <5d8380130605180850i443dd0b7wf603fbe364ec1345@mail.gmail.com>
In-Reply-To: <5d8380130605180850i443dd0b7wf603fbe364ec1345@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211723.37942.blaisorblade@yahoo.it>
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
Date: Sun, 21 May 2006 17:23:34 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Knezevic <laladelausanne@gmail.com>

On Thursday 18 May 2006 17:50, Nikola Knezevic wrote:
> Hi all,
> any solutions how to debug uml while it is booting?
> I can trace 

You mean single-step?

> it to process.c:start_userspace and a call to clone. After 
> that, I can't do anything,

Ah, you can't trace the cloned process... or maybe the main one!

> until I send HUP from another console, 
> which is a bit slow.

How that HUP works? I.e. you kill -HUP the main thread and you re-get control 
inside GDB?

> Any suggestions?
Put a pause() call where you want to stop and recompile. Jeff Dike usually 
does so to workaround gdb problems (breakpoints not working)

I'm re-reading your email now and I'm dubious - I often see that breakpoints 
work up to a certain point.

I.e. I set a breakpoint, start UML, it works up to a certain point, afterwards 
it doesn't any more, until I restop it (I use SIGINT but I now understand 
it's the same thing).

I guess GDB doesn't handle well some UML's calls.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
