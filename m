Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ab4ed-0006o4-91
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 13:10:23 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ab4ec-0002Np-Rd
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 13:10:23 -0800
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Ab4eZ-0002rL-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Dec 2003 22:10:19 +0100
From: Jason Lunz <lunz@falooley.org>
Message-ID: <slrnbv12f4.4rj.lunz@absolut.localnet>
References: <200312261905.48277.blaisorblade_spam@yahoo.it> <200312271927.26870.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: UML patches against vanilla 2.6.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 29 Dec 2003 20:09:08 +0000 (UTC)
To: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I have some doubts about the 2.6 host-skas patch. I've searched through the 
> list for earlier ports to 2.6 and I've seen someone (Bryan O'Sullivan 
> <bos@serpentine.com>) complaining:
>
> "The big issue with the skas patches, though, appears to be that they
> don't handle the UML kernel being killed, which results in the host
> kernel's memory management being completely trashed."
>
> Is this a real issue or not?

I think so. I'm running 2.6.0 vanilla + Ingo's combo -A2 on my host,
with 2.4.23 UMLs. I tried to do something in the uml involving lots of
tmpfs usage, and the host system crashed.

This was just before I went away for the holiday; I'm only now catching
up. I haven't re-tested with any of the newer 2.6 skas patches.

Jason



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
